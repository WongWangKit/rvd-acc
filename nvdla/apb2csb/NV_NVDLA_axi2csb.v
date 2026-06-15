// ================================================================
// AXI to NVDLA CSB bridge
//
// Single-outstanding, 32-bit AXI slave front end for the NVDLA CSB
// register bus.  Each AXI burst beat is converted into one CSB access.
// FIXED and INCR bursts are supported; WRAP/reserved bursts return SLVERR.
// ================================================================
module NV_NVDLA_axi2csb (
    clk_i,
    rst_n_i,

    axi_awvalid_i,
    axi_awaddr_i,
    axi_awid_i,
    axi_awlen_i,
    axi_awburst_i,
    axi_wvalid_i,
    axi_wdata_i,
    axi_wstrb_i,
    axi_wlast_i,
    axi_bready_i,
    axi_arvalid_i,
    axi_araddr_i,
    axi_arid_i,
    axi_arlen_i,
    axi_arburst_i,
    axi_rready_i,

    axi_awready_o,
    axi_wready_o,
    axi_bvalid_o,
    axi_bresp_o,
    axi_bid_o,
    axi_arready_o,
    axi_rvalid_o,
    axi_rdata_o,
    axi_rresp_o,
    axi_rid_o,
    axi_rlast_o,

    csb2nvdla_ready,
    nvdla2csb_data,
    nvdla2csb_valid,
    nvdla2csb_wr_complete,
    csb2nvdla_addr,
    csb2nvdla_nposted,
    csb2nvdla_valid,
    csb2nvdla_wdat,
    csb2nvdla_write
);

input         clk_i;
input         rst_n_i;

input         axi_awvalid_i;
input  [31:0] axi_awaddr_i;
input  [3:0]  axi_awid_i;
input  [7:0]  axi_awlen_i;
input  [1:0]  axi_awburst_i;
input         axi_wvalid_i;
input  [31:0] axi_wdata_i;
input  [3:0]  axi_wstrb_i;
input         axi_wlast_i;
input         axi_bready_i;
input         axi_arvalid_i;
input  [31:0] axi_araddr_i;
input  [3:0]  axi_arid_i;
input  [7:0]  axi_arlen_i;
input  [1:0]  axi_arburst_i;
input         axi_rready_i;

output        axi_awready_o;
output        axi_wready_o;
output        axi_bvalid_o;
output [1:0]  axi_bresp_o;
output [3:0]  axi_bid_o;
output        axi_arready_o;
output        axi_rvalid_o;
output [31:0] axi_rdata_o;
output [1:0]  axi_rresp_o;
output [3:0]  axi_rid_o;
output        axi_rlast_o;

input         csb2nvdla_ready;
input  [31:0] nvdla2csb_data;
input         nvdla2csb_valid;
input         nvdla2csb_wr_complete;
output        csb2nvdla_valid;
output [15:0] csb2nvdla_addr;
output        csb2nvdla_nposted;
output [31:0] csb2nvdla_wdat;
output        csb2nvdla_write;

localparam [1:0] AXI_BURST_FIXED = 2'b00;
localparam [1:0] AXI_BURST_INCR  = 2'b01;

localparam [1:0] RESP_OKAY       = 2'b00;
localparam [1:0] RESP_SLVERR     = 2'b10;

localparam [2:0] ST_IDLE         = 3'd0;
localparam [2:0] ST_WR_DATA      = 3'd1;
localparam [2:0] ST_WR_CSB       = 3'd2;
localparam [2:0] ST_WR_WAIT      = 3'd3;
localparam [2:0] ST_WR_RESP      = 3'd4;
localparam [2:0] ST_RD_CSB       = 3'd5;
localparam [2:0] ST_RD_WAIT      = 3'd6;
localparam [2:0] ST_RD_RESP      = 3'd7;

reg [2:0]  state;

reg [15:0] wr_addr;
reg [3:0]  wr_id;
reg [7:0]  wr_len;
reg [1:0]  wr_burst;
reg [7:0]  wr_beat;
reg        wr_error;
reg        wr_beat_done;
reg [31:0] wr_data;

reg [15:0] rd_addr;
reg [3:0]  rd_id;
reg [7:0]  rd_len;
reg [1:0]  rd_burst;
reg [7:0]  rd_beat;
reg        rd_error;

reg        bvalid;
reg [1:0]  bresp;
reg [3:0]  bid;

reg        rvalid;
reg [31:0] rdata;
reg [1:0]  rresp;
reg [3:0]  rid;
reg        rlast;

wire idle_ready;
wire aw_fire;
wire w_fire;
wire ar_fire;
wire wr_last_expected;
wire wr_last_seen;
wire wr_beat_error;
wire rd_last_beat;

assign idle_ready     = (state == ST_IDLE) & ~bvalid & ~rvalid;
assign axi_awready_o  = idle_ready;
assign axi_arready_o  = idle_ready & ~axi_awvalid_i;
assign axi_wready_o   = (state == ST_WR_DATA);

assign aw_fire = axi_awvalid_i & axi_awready_o;
assign w_fire  = axi_wvalid_i  & axi_wready_o;
assign ar_fire = axi_arvalid_i & axi_arready_o;

assign wr_last_expected = (wr_beat == wr_len);
assign wr_last_seen     = axi_wlast_i | wr_last_expected;
assign wr_beat_error    = (axi_wstrb_i != 4'hf) | (axi_wlast_i != wr_last_expected);
assign rd_last_beat     = (rd_beat == rd_len);

assign axi_bvalid_o = bvalid;
assign axi_bresp_o  = bresp;
assign axi_bid_o    = bid;

assign axi_rvalid_o = rvalid;
assign axi_rdata_o  = rdata;
assign axi_rresp_o  = rresp;
assign axi_rid_o    = rid;
assign axi_rlast_o  = rlast;

assign csb2nvdla_valid   = (state == ST_WR_CSB) | (state == ST_RD_CSB);
assign csb2nvdla_addr    = (state == ST_RD_CSB) ? rd_addr : wr_addr;
assign csb2nvdla_wdat    = wr_data;
assign csb2nvdla_write   = (state == ST_WR_CSB);
assign csb2nvdla_nposted = 1'b1;

always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
        state        <= ST_IDLE;
        wr_addr      <= 16'd0;
        wr_id        <= 4'd0;
        wr_len       <= 8'd0;
        wr_burst     <= AXI_BURST_FIXED;
        wr_beat      <= 8'd0;
        wr_error     <= 1'b0;
        wr_beat_done <= 1'b0;
        wr_data      <= 32'd0;
        rd_addr      <= 16'd0;
        rd_id        <= 4'd0;
        rd_len       <= 8'd0;
        rd_burst     <= AXI_BURST_FIXED;
        rd_beat      <= 8'd0;
        rd_error     <= 1'b0;
        bvalid       <= 1'b0;
        bresp        <= RESP_OKAY;
        bid          <= 4'd0;
        rvalid       <= 1'b0;
        rdata        <= 32'd0;
        rresp        <= RESP_OKAY;
        rid          <= 4'd0;
        rlast        <= 1'b0;
    end else begin
        case (state)
        ST_IDLE: begin
            if (aw_fire) begin
                wr_addr      <= axi_awaddr_i[17:2];
                wr_id        <= axi_awid_i;
                wr_len       <= axi_awlen_i;
                wr_burst     <= axi_awburst_i;
                wr_beat      <= 8'd0;
                wr_error     <= (axi_awburst_i != AXI_BURST_FIXED) &
                                (axi_awburst_i != AXI_BURST_INCR);
                wr_beat_done <= 1'b0;
                bid          <= axi_awid_i;
                bresp        <= RESP_OKAY;
                state        <= ST_WR_DATA;
            end else if (ar_fire) begin
                rd_addr  <= axi_araddr_i[17:2];
                rd_id    <= axi_arid_i;
                rd_len   <= axi_arlen_i;
                rd_burst <= axi_arburst_i;
                rd_beat  <= 8'd0;
                rd_error <= (axi_arburst_i != AXI_BURST_FIXED) &
                            (axi_arburst_i != AXI_BURST_INCR);
                rid      <= axi_arid_i;
                rresp    <= RESP_OKAY;
                state    <= ((axi_arburst_i == AXI_BURST_FIXED) |
                             (axi_arburst_i == AXI_BURST_INCR)) ? ST_RD_CSB : ST_RD_RESP;
            end
        end

        ST_WR_DATA: begin
            if (w_fire) begin
                wr_data      <= axi_wdata_i;
                wr_beat_done <= wr_last_seen;

                if (wr_error | wr_beat_error) begin
                    wr_error <= 1'b1;
                    if (wr_last_seen) begin
                        bvalid <= 1'b1;
                        bresp  <= RESP_SLVERR;
                        state  <= ST_WR_RESP;
                    end else begin
                        wr_beat <= wr_beat + 8'd1;
                        if (wr_burst == AXI_BURST_INCR) begin
                            wr_addr <= wr_addr + 16'd1;
                        end
                    end
                end else begin
                    state <= ST_WR_CSB;
                end
            end
        end

        ST_WR_CSB: begin
            if (csb2nvdla_ready) begin
                if (nvdla2csb_wr_complete) begin
                    if (wr_beat_done) begin
                        bvalid <= 1'b1;
                        bresp  <= RESP_OKAY;
                        state  <= ST_WR_RESP;
                    end else begin
                        wr_beat <= wr_beat + 8'd1;
                        if (wr_burst == AXI_BURST_INCR) begin
                            wr_addr <= wr_addr + 16'd1;
                        end
                        state <= ST_WR_DATA;
                    end
                end else begin
                    state <= ST_WR_WAIT;
                end
            end
        end

        ST_WR_WAIT: begin
            if (nvdla2csb_wr_complete) begin
                if (wr_beat_done) begin
                    bvalid <= 1'b1;
                    bresp  <= RESP_OKAY;
                    state  <= ST_WR_RESP;
                end else begin
                    wr_beat <= wr_beat + 8'd1;
                    if (wr_burst == AXI_BURST_INCR) begin
                        wr_addr <= wr_addr + 16'd1;
                    end
                    state <= ST_WR_DATA;
                end
            end
        end

        ST_WR_RESP: begin
            if (bvalid & axi_bready_i) begin
                bvalid <= 1'b0;
                state  <= ST_IDLE;
            end
        end

        ST_RD_CSB: begin
            if (csb2nvdla_ready) begin
                state <= ST_RD_WAIT;
            end
        end

        ST_RD_WAIT: begin
            if (nvdla2csb_valid) begin
                rvalid <= 1'b1;
                rdata  <= nvdla2csb_data;
                rresp  <= RESP_OKAY;
                rid    <= rd_id;
                rlast  <= rd_last_beat;
                state  <= ST_RD_RESP;
            end
        end

        ST_RD_RESP: begin
            if (!rvalid) begin
                rvalid <= 1'b1;
                rdata  <= 32'd0;
                rresp  <= rd_error ? RESP_SLVERR : RESP_OKAY;
                rid    <= rd_id;
                rlast  <= rd_last_beat;
            end else if (axi_rready_i) begin
                rvalid <= 1'b0;
                if (rlast) begin
                    state <= ST_IDLE;
                end else begin
                    rd_beat <= rd_beat + 8'd1;
                    if (rd_burst == AXI_BURST_INCR) begin
                        rd_addr <= rd_addr + 16'd1;
                    end
                    state <= rd_error ? ST_RD_RESP : ST_RD_CSB;
                end
            end
        end

        default: begin
            state <= ST_IDLE;
        end
        endcase
    end
end

endmodule
