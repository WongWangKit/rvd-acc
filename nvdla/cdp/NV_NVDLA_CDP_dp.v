module NV_NVDLA_CDP_dp (
    input           dp2reg_done             ,
    input           nvdla_core_clk          ,
    input           nvdla_core_rstn         ,
    input           cdp_rdma2dp_valid       ,
    output          cdp_rdma2dp_ready       ,
    input  [66:0]   cdp_rdma2dp_pd          ,
    output          cdp_dp2wdma_valid       ,
    input           cdp_dp2wdma_ready       ,
    output [66:0]   cdp_dp2wdma_pd          ,
    input           nvdla_core_clk_orig     
);

wire    [66:0]          dp_pd;
wire                    dp_valid;
wire                    dp_ready;
wire    [66:0]          dp_out_pd;
wire                    dp_out_valid;
wire                    dp_out_ready;
wire    [ 3:0]          fifo_wr_en;
wire    [ 3:0]          fifo_full;
wire    [255:0]         fifo_data;
wire    [ 3:0]          fifo_rd_en;
wire    [ 3:0]          fifo_empty;

reg     [ 1:0]          dp_data_cnt;
reg     [ 1:0]          dp_data_cnt_d1;


pipe_unit #(
    .DATA_WIDTH(67)
) NV_NVDLA_CDP_dp_din_pipe (
    .clk            ( nvdla_core_clk            ),
    .rstn           ( nvdla_core_rstn           ),
    .data_in        ( cdp_rdma2dp_pd[66:0]      ),
    .data_in_vld    ( cdp_rdma2dp_valid         ),
    .data_in_rdy    ( cdp_rdma2dp_ready         ),
    .data_out       ( dp_pd                     ),
    .data_out_vld   ( dp_valid                  ),
    .data_out_rdy   ( dp_ready                  )
);

assign dp_ready = ~|fifo_full;
assign fifo_rd_en[0] = ~fifo_empty[0] && dp_data_cnt == 2'b00 && dp_out_ready;
assign fifo_rd_en[1] = ~fifo_empty[1] && dp_data_cnt == 2'b01 && dp_out_ready;
assign fifo_rd_en[2] = ~fifo_empty[2] && dp_data_cnt == 2'b10 && dp_out_ready;
assign fifo_rd_en[3] = ~fifo_empty[3] && dp_data_cnt == 2'b11 && dp_out_ready;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        dp_data_cnt <= 2'b0;
    end else begin
        if (|fifo_rd_en) begin
            dp_data_cnt <= dp_data_cnt + 1'b1;
        end else
        if (dp2reg_done) begin
            dp_data_cnt <= 2'b0;
        end
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        dp_data_cnt_d1 <= 2'b0;
        // dp_out_valid <= 1'b0;
    end else begin
        dp_data_cnt_d1 <= dp_data_cnt;
        // dp_out_valid <= |fifo_rd_en;
    end
end

syncFIFO_diffWidth # (
    .DIN_WIDTH      (16                         ),
    .DOUT_WIDTH     (64                         ),
    .WADDR_WIDTH    (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          ),
    .MSB_FIFO       (0                          )
) dat_fifo_0 (
    .din            ({dp_pd[39:32], dp_pd[7:0]} ),
    .wr_en          (dp_valid                   ),
    .full           (fifo_full[0]               ),
    .almost_full    (                           ),
    .dout           (fifo_data[ 63:  0]         ),
    .rd_en          (fifo_rd_en[0]              ),
    .empty          (fifo_empty[0]              ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

syncFIFO_diffWidth # (
    .DIN_WIDTH      (16                         ),
    .DOUT_WIDTH     (64                         ),
    .WADDR_WIDTH    (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          ),
    .MSB_FIFO       (0                          )
) dat_fifo_1 (
    .din            ({dp_pd[47:40], dp_pd[15:8]}),
    .wr_en          (dp_valid                   ),
    .full           (fifo_full[1]               ),
    .almost_full    (                           ),
    .dout           (fifo_data[127: 64]         ),
    .rd_en          (fifo_rd_en[1]              ),
    .empty          (fifo_empty[1]              ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

syncFIFO_diffWidth # (
    .DIN_WIDTH      (16                         ),
    .DOUT_WIDTH     (64                         ),
    .WADDR_WIDTH    (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          ),
    .MSB_FIFO       (0                          )
) dat_fifo_2 (
    .din            ({dp_pd[55:48], dp_pd[23:16]}),
    .wr_en          (dp_valid                   ),
    .full           (fifo_full[2]               ),
    .almost_full    (                           ),
    .dout           (fifo_data[191:128]         ),
    .rd_en          (fifo_rd_en[2]              ),
    .empty          (fifo_empty[2]              ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

syncFIFO_diffWidth # (
    .DIN_WIDTH      (16                         ),
    .DOUT_WIDTH     (64                         ),
    .WADDR_WIDTH    (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          ),
    .MSB_FIFO       (0                          )
) dat_fifo_3 (
    .din            ({dp_pd[63:56], dp_pd[31:24]}),
    .wr_en          (dp_valid                   ),
    .full           (fifo_full[3]               ),
    .almost_full    (                           ),
    .dout           (fifo_data[255:192]         ),
    .rd_en          (fifo_rd_en[3]              ),
    .empty          (fifo_empty[3]              ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

syncFIFO # (
    .DATA_WIDTH     (3                          ),
    .ADDR_WIDTH     (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          )
) cmd_fifo (
    .din            (dp_pd[66:64]               ),
    .wr_en          (dp_valid                   ),
    .full           (                           ),
    .almost_full    (                           ),
    .dout           (dp_out_pd[66:64]           ),
    .rd_en          (|fifo_rd_en                ),
    .empty          (                           ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

assign dp_out_pd[63:0] = dp_data_cnt == 2'b00 ? fifo_data[ 63:  0] :
                         dp_data_cnt == 2'b01 ? fifo_data[127: 64] :
                         dp_data_cnt == 2'b10 ? fifo_data[191:128] :
                         dp_data_cnt == 2'b11 ? fifo_data[255:192] : 'b0;
assign dp_out_valid = |fifo_rd_en;

pipe_unit #(
    .DATA_WIDTH(67)
) NV_NVDLA_CDP_dp_dout_pipe (
    .clk            ( nvdla_core_clk            ),
    .rstn           ( nvdla_core_rstn           ),
    .data_in        ( dp_out_pd[66:0]           ),
    .data_in_vld    ( dp_out_valid              ),
    .data_in_rdy    ( dp_out_ready              ),
    .data_out       ( cdp_dp2wdma_pd            ),
    .data_out_vld   ( cdp_dp2wdma_valid         ),
    .data_out_rdy   ( cdp_dp2wdma_ready         )
);

endmodule
