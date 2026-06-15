// ================================================================
// AXI to NVDLA CSB bridge
//
// Single-outstanding, 32-bit AXI slave front end for the NVDLA CSB
// register bus.  AXI bursts are accepted, but only the first beat of
// each burst is sent to CSB; later beats are consumed/responded normally.
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

localparam [1:0] RESP_OKAY   = 2'b00;
localparam [1:0] RESP_SLVERR = 2'b10;

localparam [2:0] ST_IDLE       = 3'd0;
localparam [2:0] ST_WR_FIRST   = 3'd1;
localparam [2:0] ST_WR_DRAIN   = 3'd2;
localparam [2:0] ST_WR_WAIT    = 3'd3;
localparam [2:0] ST_WR_RESP    = 3'd4;
localparam [2:0] ST_RD_CSB     = 3'd5;
localparam [2:0] ST_RD_RESP    = 3'd6;

reg [2:0]  state;

reg        aw_full;
reg [15:0] aw_addr;
reg [3:0]  aw_id;
reg [7:0]  aw_len;
reg        aw_bad;

reg        first_w_full;
reg [31:0] first_w_data;
reg        first_w_bad;
reg        first_w_last;
reg [7:0]  w_beat_cnt;
reg        w_done;
reg        wr_complete_seen;

reg [15:0] ar_addr;
reg [3:0]  ar_id;
reg [7:0]  ar_len;
reg        ar_bad;
reg [7:0]  r_beat_cnt;
reg [31:0] first_r_data;

reg        bvalid;
reg [1:0]  bresp;
reg [3:0]  bid;

reg        rvalid;
reg [31:0] rdata;
reg [1:0]  rresp;
reg [3:0]  rid;
reg        rlast;

wire idle_no_resp;
wire aw_fire;
wire w_fire;
wire ar_fire;
wire first_w_fire;
wire write_ready;
wire read_done;

assign idle_no_resp = (state == ST_IDLE) & ~bvalid & ~rvalid & ~aw_full & ~w_done;

assign axi_awready_o = idle_no_resp;
assign axi_arready_o = idle_no_resp & ~first_w_full & ~axi_awvalid_i & ~axi_wvalid_i;
assign axi_wready_o  = ((state == ST_IDLE) & ~first_w_full & ~bvalid & ~rvalid) |
                       (state == ST_WR_DRAIN);

assign aw_fire = axi_awvalid_i & axi_awready_o;
assign w_fire  = axi_wvalid_i  & axi_wready_o;
assign ar_fire = axi_arvalid_i & axi_arready_o;
assign first_w_fire = w_fire & (state == ST_IDLE);

assign write_ready = (aw_full | aw_fire) & (first_w_full | first_w_fire);
assign read_done = (r_beat_cnt == ar_len);

assign axi_bvalid_o = bvalid;
assign axi_bresp_o  = bresp;
assign axi_bid_o    = bid;

assign axi_rvalid_o = rvalid;
assign axi_rdata_o  = rdata;
assign axi_rresp_o  = rresp;
assign axi_rid_o    = rid;
assign axi_rlast_o  = rlast;

assign csb2nvdla_valid   = ((state == ST_WR_FIRST) | (state == ST_RD_CSB));
assign csb2nvdla_addr    = (state == ST_RD_CSB) ? ar_addr : aw_addr;
assign csb2nvdla_wdat    = first_w_data;
assign csb2nvdla_write   = (state == ST_WR_FIRST);
assign csb2nvdla_nposted = 1'b1;

always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
        state        <= ST_IDLE;
        aw_full      <= 1'b0;
        aw_addr      <= 16'd0;
        aw_id        <= 4'd0;
        aw_len       <= 8'd0;
        aw_bad       <= 1'b0;
        first_w_full <= 1'b0;
        first_w_data <= 32'd0;
        first_w_bad  <= 1'b0;
        first_w_last <= 1'b0;
        w_beat_cnt   <= 8'd0;
        w_done       <= 1'b0;
        wr_complete_seen <= 1'b0;
        ar_addr      <= 16'd0;
        ar_id        <= 4'd0;
        ar_len       <= 8'd0;
        ar_bad       <= 1'b0;
        r_beat_cnt   <= 8'd0;
        first_r_data <= 32'd0;
        bvalid       <= 1'b0;
        bresp        <= RESP_OKAY;
        bid          <= 4'd0;
        rvalid       <= 1'b0;
        rdata        <= 32'd0;
        rresp        <= RESP_OKAY;
        rid          <= 4'd0;
        rlast        <= 1'b0;
    end else begin
        if (bvalid & axi_bready_i) begin
            bvalid <= 1'b0;
        end

        if (rvalid & axi_rready_i) begin
            rvalid <= 1'b0;
        end

        if (aw_fire) begin
            aw_full <= 1'b1;
            aw_addr <= axi_awaddr_i[17:2];
            aw_id   <= axi_awid_i;
            aw_len  <= axi_awlen_i;
            aw_bad  <= (axi_awburst_i == 2'b11);
        end

        if (first_w_fire) begin
            first_w_full <= 1'b1;
            first_w_data <= axi_wdata_i;
            first_w_bad  <= (axi_wstrb_i != 4'hf);
            first_w_last <= axi_wlast_i;
            w_beat_cnt   <= 8'd0;
            w_done       <= axi_wlast_i;
        end

        if ((state == ST_WR_DRAIN) | (state == ST_WR_WAIT)) begin
            if (nvdla2csb_wr_complete) begin
                wr_complete_seen <= 1'b1;
            end
        end

        case (state)
        ST_IDLE: begin
            if (ar_fire) begin
                ar_addr    <= axi_araddr_i[17:2];
                ar_id      <= axi_arid_i;
                ar_len     <= axi_arlen_i;
                ar_bad     <= (axi_arburst_i == 2'b11);
                r_beat_cnt <= 8'd0;
                if (axi_arburst_i == 2'b11) begin
                    rvalid <= 1'b1;
                    rdata  <= 32'd0;
                    rresp  <= RESP_SLVERR;
                    rid    <= axi_arid_i;
                    rlast  <= (axi_arlen_i == 8'd0);
                    state  <= ST_RD_RESP;
                end else begin
                    state <= ST_RD_CSB;
                end
            end else if (write_ready) begin
                bid <= aw_full ? aw_id : axi_awid_i;
                if ((aw_full ? aw_bad : (axi_awburst_i == 2'b11)) |
                    (first_w_full ? first_w_bad : (axi_wstrb_i != 4'hf))) begin
                    if ((aw_full ? aw_len : axi_awlen_i) == 8'd0) begin
                        bvalid <= 1'b1;
                        bresp  <= RESP_SLVERR;
                        aw_full <= 1'b0;
                        first_w_full <= 1'b0;
                        w_done <= 1'b0;
                        state <= ST_WR_RESP;
                    end else begin
                        state <= ST_WR_DRAIN;
                    end
                end else begin
                    state <= ST_WR_FIRST;
                end
            end
        end

        ST_WR_FIRST: begin
            if (csb2nvdla_ready) begin
                aw_full      <= 1'b0;
                first_w_full <= 1'b0;
                if ((aw_len == 8'd0) | first_w_last) begin
                    w_done <= first_w_last;
                    wr_complete_seen <= 1'b0;
                    state  <= first_w_last ? ST_WR_WAIT : ST_WR_DRAIN;
                end else begin
                    wr_complete_seen <= 1'b0;
                    state <= ST_WR_DRAIN;
                end
            end
        end

        ST_WR_DRAIN: begin
            if (w_done) begin
                if (aw_bad | first_w_bad) begin
                    bvalid <= 1'b1;
                    bresp  <= RESP_SLVERR;
                    aw_full <= 1'b0;
                    first_w_full <= 1'b0;
                    w_done <= 1'b0;
                    state  <= ST_WR_RESP;
                end else if (wr_complete_seen | nvdla2csb_wr_complete) begin
                    bvalid <= 1'b1;
                    bresp  <= RESP_OKAY;
                    w_done <= 1'b0;
                    wr_complete_seen <= 1'b0;
                    state  <= ST_WR_RESP;
                end else begin
                    state <= ST_WR_WAIT;
                end
            end else if (w_fire) begin
                w_beat_cnt <= w_beat_cnt + 8'd1;
                w_done     <= axi_wlast_i | (w_beat_cnt == aw_len);
            end
        end

        ST_WR_WAIT: begin
            if (wr_complete_seen | nvdla2csb_wr_complete) begin
                bvalid <= 1'b1;
                bresp  <= RESP_OKAY;
                w_done <= 1'b0;
                wr_complete_seen <= 1'b0;
                state  <= ST_WR_RESP;
            end
        end

        ST_WR_RESP: begin
            if (~bvalid | axi_bready_i) begin
                state <= ST_IDLE;
            end
        end

        ST_RD_CSB: begin
            if (csb2nvdla_ready) begin
                state <= ST_RD_RESP;
            end
        end

        ST_RD_RESP: begin
            if (~rvalid) begin
                if ((r_beat_cnt == 8'd0) & ~ar_bad) begin
                    if (nvdla2csb_valid) begin
                        first_r_data <= nvdla2csb_data;
                        rvalid <= 1'b1;
                        rdata  <= nvdla2csb_data;
                        rresp  <= RESP_OKAY;
                        rid    <= ar_id;
                        rlast  <= read_done;
                    end
                end else begin
                    rvalid <= 1'b1;
                    rdata  <= 32'd0;
                    rresp  <= ar_bad ? RESP_SLVERR : RESP_OKAY;
                    rid    <= ar_id;
                    rlast  <= read_done;
                end
            end else if (axi_rready_i) begin
                if (rlast) begin
                    state <= ST_IDLE;
                end else begin
                    r_beat_cnt <= r_beat_cnt + 8'd1;
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
