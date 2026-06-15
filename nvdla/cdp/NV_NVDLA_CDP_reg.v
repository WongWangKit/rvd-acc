// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_reg.v
`include "simulate_x_tick.vh"
module NV_NVDLA_CDP_reg (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,csb2cdp_req_pd //|< i
  ,csb2cdp_req_pvld //|< i
  ,dp2reg_done //|< i
  ,cdp2csb_resp_pd //|> o
  ,cdp2csb_resp_valid //|> o
  ,csb2cdp_req_prdy //|> o
  ,reg2dp_dst_base_addr_high //|> o
  ,reg2dp_dst_base_addr_low //|> o
  ,reg2dp_dst_line_stride //|> o
  ,reg2dp_dst_surface_stride //|> o
  ,reg2dp_op_en //|> o
  ,slcg_op_en //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [62:0] csb2cdp_req_pd;
input csb2cdp_req_pvld;
input dp2reg_done;
output [33:0] cdp2csb_resp_pd;
output cdp2csb_resp_valid;
output csb2cdp_req_prdy;
output [31:0] reg2dp_dst_base_addr_high;
output [31:0] reg2dp_dst_base_addr_low;
output [31:0] reg2dp_dst_line_stride;
output [31:0] reg2dp_dst_surface_stride;
output reg2dp_op_en;
output [3:0] slcg_op_en;
wire csb_rresp_error;
wire [33:0] csb_rresp_pd_w;
wire [31:0] csb_rresp_rdat;
wire csb_wresp_error;
wire [33:0] csb_wresp_pd_w;
wire [31:0] csb_wresp_rdat;
wire [23:0] d0_reg_offset;
wire [31:0] d0_reg_rd_data;
wire [31:0] d0_reg_wr_data;
wire d0_reg_wr_en;
wire [23:0] d1_reg_offset;
wire [31:0] d1_reg_rd_data;
wire [31:0] d1_reg_wr_data;
wire d1_reg_wr_en;
wire dp2reg_consumer_w;
wire lut_end;
wire [31:0] reg2dp_d0_cya;
wire [15:0] reg2dp_d0_datin_offset;
wire [15:0] reg2dp_d0_datin_scale;
wire [4:0] reg2dp_d0_datin_shifter;
wire [31:0] reg2dp_d0_datout_offset;
wire [15:0] reg2dp_d0_datout_scale;
wire [5:0] reg2dp_d0_datout_shifter;
wire reg2dp_d0_dma_en;
wire [31:0] reg2dp_d0_dst_base_addr_high;
wire [31:0] reg2dp_d0_dst_base_addr_low;
wire [31:0] reg2dp_d0_dst_line_stride;
wire reg2dp_d0_dst_ram_type;
wire [31:0] reg2dp_d0_dst_surface_stride;
wire [1:0] reg2dp_d0_input_data_type;
wire reg2dp_d0_lut_en;
wire reg2dp_d0_mul_bypass;
wire reg2dp_d0_nan_to_zero;
wire [1:0] reg2dp_d0_normalz_len;
wire reg2dp_d0_op_en_trigger;
wire reg2dp_d0_sqsum_bypass;
wire [31:0] reg2dp_d1_cya;
wire [15:0] reg2dp_d1_datin_offset;
wire [15:0] reg2dp_d1_datin_scale;
wire [4:0] reg2dp_d1_datin_shifter;
wire [31:0] reg2dp_d1_datout_offset;
wire [15:0] reg2dp_d1_datout_scale;
wire [5:0] reg2dp_d1_datout_shifter;
wire reg2dp_d1_dma_en;
wire [31:0] reg2dp_d1_dst_base_addr_high;
wire [31:0] reg2dp_d1_dst_base_addr_low;
wire [31:0] reg2dp_d1_dst_line_stride;
wire reg2dp_d1_dst_ram_type;
wire [31:0] reg2dp_d1_dst_surface_stride;
wire [1:0] reg2dp_d1_input_data_type;
wire reg2dp_d1_lut_en;
wire reg2dp_d1_mul_bypass;
wire reg2dp_d1_nan_to_zero;
wire [1:0] reg2dp_d1_normalz_len;
wire reg2dp_d1_op_en_trigger;
wire reg2dp_d1_sqsum_bypass;
wire reg2dp_lut_addr_trigger;
wire reg2dp_lut_data_rd_trigger;
wire reg2dp_lut_data_wr_trigger;
wire [2:0] reg2dp_op_en_reg_w;
wire reg2dp_producer;
wire [23:0] reg_offset;
wire [31:0] reg_offset_wr;
wire [31:0] reg_rd_data;
wire reg_rd_en;
wire [31:0] reg_wr_data;
wire reg_wr_en;
wire [21:0] req_addr;
wire [1:0] req_level;
wire req_nposted;
wire req_srcpriv;
wire [31:0] req_wdat;
wire [3:0] req_wrbe;
wire req_write;
wire [23:0] s_reg_offset;
wire [31:0] s_reg_rd_data;
wire [31:0] s_reg_wr_data;
wire s_reg_wr_en;
wire select_d0;
wire select_d1;
wire select_s;
wire [3:0] slcg_op_en_d0;
reg [33:0] cdp2csb_resp_pd;
reg cdp2csb_resp_valid;
reg dp2reg_consumer;
reg dp2reg_d0_clr;
reg [31:0] dp2reg_d0_inf_input_num;
reg [31:0] dp2reg_d0_inf_input_num_w;
reg [31:0] dp2reg_d0_nan_input_num;
reg [31:0] dp2reg_d0_nan_input_num_w;
reg [31:0] dp2reg_d0_nan_output_num;
reg [31:0] dp2reg_d0_nan_output_num_w;
reg dp2reg_d0_reg;
reg dp2reg_d0_set;
reg dp2reg_d1_clr;
reg [31:0] dp2reg_d1_inf_input_num;
reg [31:0] dp2reg_d1_inf_input_num_w;
reg [31:0] dp2reg_d1_nan_input_num;
reg [31:0] dp2reg_d1_nan_input_num_w;
reg [31:0] dp2reg_d1_nan_output_num;
reg [31:0] dp2reg_d1_nan_output_num_w;
reg dp2reg_d1_reg;
reg dp2reg_d1_set;
reg [9:0] dp2reg_lut_addr;
reg [1:0] dp2reg_status_0;
reg [1:0] dp2reg_status_1;
reg [31:0] reg2dp_cya;
reg reg2dp_d0_op_en;
reg reg2dp_d0_op_en_w;
reg reg2dp_d1_op_en;
reg reg2dp_d1_op_en_w;
reg [15:0] reg2dp_datin_offset;
reg [15:0] reg2dp_datin_scale;
reg [4:0] reg2dp_datin_shifter;
reg [31:0] reg2dp_datout_offset;
reg [15:0] reg2dp_datout_scale;
reg [5:0] reg2dp_datout_shifter;
reg reg2dp_dma_en;
reg [31:0] reg2dp_dst_base_addr_high;
reg [31:0] reg2dp_dst_base_addr_low;
reg [31:0] reg2dp_dst_line_stride;
reg reg2dp_dst_ram_type;
reg [31:0] reg2dp_dst_surface_stride;
reg [1:0] reg2dp_input_data_type;
reg reg2dp_lut_en;
reg reg2dp_mul_bypass;
reg reg2dp_nan_to_zero;
reg [1:0] reg2dp_normalz_len;
reg reg2dp_op_en_ori;
reg [2:0] reg2dp_op_en_reg;
reg reg2dp_sqsum_bypass;
reg [62:0] req_pd;
reg req_pvld;
reg [3:0] slcg_op_en_d1;
reg [3:0] slcg_op_en_d2;
reg [3:0] slcg_op_en_d3;
//Instance single register group
NV_NVDLA_CDP_REG_single u_single_reg (
   .reg_rd_data (s_reg_rd_data[31:0]) //|> w
  ,.reg_offset (s_reg_offset[11:0]) //|< w
  ,.reg_wr_data (s_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (s_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.producer (reg2dp_producer) //|> w
  ,.consumer (dp2reg_consumer) //|< r
  ,.status_0 (dp2reg_status_0[1:0]) //|< r
  ,.status_1 (dp2reg_status_1[1:0]) //|< r
  );
//Instance two duplicated register groups
NV_NVDLA_CDP_REG_dual u_dual_reg_d0 (
   .reg_rd_data (d0_reg_rd_data[31:0]) //|> w
  ,.reg_offset (d0_reg_offset[11:0]) //|< w
  ,.reg_wr_data (d0_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (d0_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.dst_base_addr_high (reg2dp_d0_dst_base_addr_high[31:0]) //|> w
  ,.dst_base_addr_low (reg2dp_d0_dst_base_addr_low[31:0]) //|> w
  ,.dst_line_stride (reg2dp_d0_dst_line_stride[31:0]) //|> w
  ,.dst_surface_stride (reg2dp_d0_dst_surface_stride[31:0]) //|> w
  ,.op_en_trigger (reg2dp_d0_op_en_trigger) //|> w
  ,.op_en (reg2dp_d0_op_en) //|< r
  );
NV_NVDLA_CDP_REG_dual u_dual_reg_d1 (
   .reg_rd_data (d1_reg_rd_data[31:0]) //|> w
  ,.reg_offset (d1_reg_offset[11:0]) //|< w
  ,.reg_wr_data (d1_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (d1_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.dst_base_addr_high (reg2dp_d1_dst_base_addr_high[31:0]) //|> w
  ,.dst_base_addr_low (reg2dp_d1_dst_base_addr_low[31:0]) //|> w
  ,.dst_line_stride (reg2dp_d1_dst_line_stride[31:0]) //|> w
  ,.dst_surface_stride (reg2dp_d1_dst_surface_stride[31:0]) //|> w
  ,.op_en_trigger (reg2dp_d1_op_en_trigger) //|> w
  ,.op_en (reg2dp_d1_op_en) //|< r
  );
////////////////////////////////////////////////////////////////////////
// //
// GENERATE CONSUMER PIONTER IN GENERAL SINGLE REGISTER GROUP //
// //
////////////////////////////////////////////////////////////////////////
assign dp2reg_consumer_w = ~dp2reg_consumer;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_consumer <= 1'b0;
  end else begin
  if ((dp2reg_done) == 1'b1) begin
    dp2reg_consumer <= dp2reg_consumer_w;
// VCS coverage off
  end else if ((dp2reg_done) == 1'b0) begin
  end else begin
    dp2reg_consumer <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
////////////////////////////////////////////////////////////////////////
// //
// GENERATE TWO STATUS FIELDS IN GENERAL SINGLE REGISTER GROUP //
// //
////////////////////////////////////////////////////////////////////////
always @(
  reg2dp_d0_op_en
  or dp2reg_consumer
  ) begin
    dp2reg_status_0 = (reg2dp_d0_op_en == 1'h0 ) ? 2'h0 :
                      (dp2reg_consumer == 1'h1 ) ? 2'h2 :
                      2'h1 ;
end
always @(
  reg2dp_d1_op_en
  or dp2reg_consumer
  ) begin
    dp2reg_status_1 = (reg2dp_d1_op_en == 1'h0 ) ? 2'h0 :
                      (dp2reg_consumer == 1'h0 ) ? 2'h2 :
                      2'h1 ;
end
////////////////////////////////////////////////////////////////////////
// //
// GENERATE OP_EN LOGIC //
// //
////////////////////////////////////////////////////////////////////////
always @(
  reg2dp_d0_op_en
  or reg2dp_d0_op_en_trigger
  or reg_wr_data
  or dp2reg_done
  or dp2reg_consumer
  ) begin
    reg2dp_d0_op_en_w = (~reg2dp_d0_op_en & reg2dp_d0_op_en_trigger) ? reg_wr_data[0 ] :
                        (dp2reg_done && dp2reg_consumer == 1'h0 ) ? 1'b0 :
                        reg2dp_d0_op_en;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_d0_op_en <= 1'b0;
  end else begin
  reg2dp_d0_op_en <= reg2dp_d0_op_en_w;
  end
end
always @(
  reg2dp_d1_op_en
  or reg2dp_d1_op_en_trigger
  or reg_wr_data
  or dp2reg_done
  or dp2reg_consumer
  ) begin
    reg2dp_d1_op_en_w = (~reg2dp_d1_op_en & reg2dp_d1_op_en_trigger) ? reg_wr_data[0 ] :
                        (dp2reg_done && dp2reg_consumer == 1'h1 ) ? 1'b0 :
                        reg2dp_d1_op_en;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_d1_op_en <= 1'b0;
  end else begin
  reg2dp_d1_op_en <= reg2dp_d1_op_en_w;
  end
end
always @(
  dp2reg_consumer
  or reg2dp_d1_op_en
  or reg2dp_d0_op_en
  ) begin
    reg2dp_op_en_ori = dp2reg_consumer ? reg2dp_d1_op_en : reg2dp_d0_op_en;
end
assign reg2dp_op_en_reg_w = dp2reg_done ? 3'b0 :
                            {reg2dp_op_en_reg[1:0], reg2dp_op_en_ori};
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_op_en_reg <= {3{1'b0}};
  end else begin
  reg2dp_op_en_reg <= reg2dp_op_en_reg_w;
  end
end
assign reg2dp_op_en = reg2dp_op_en_reg[3-1];
assign slcg_op_en_d0 = {4{reg2dp_op_en_ori}};
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    slcg_op_en_d1 <= {4{1'b0}};
  end else begin
  slcg_op_en_d1 <= slcg_op_en_d0;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    slcg_op_en_d2 <= {4{1'b0}};
  end else begin
  slcg_op_en_d2 <= slcg_op_en_d1;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    slcg_op_en_d3 <= {4{1'b0}};
  end else begin
  slcg_op_en_d3 <= slcg_op_en_d2;
  end
end
assign slcg_op_en = slcg_op_en_d3;
////////////////////////////////////////////////////////////////////////
// //
// GENERATE ACCESS LOGIC TO EACH REGISTER GROUP //
// //
////////////////////////////////////////////////////////////////////////
//EACH subunit has 4KB address space
assign select_s = (reg_offset[11:0] < (32'hf048 & 32'hfff)) ? 1'b1: 1'b0;
assign select_d0 = (reg_offset[11:0] >= (32'hf048 & 32'hfff)) & (reg2dp_producer == 1'h0 );
assign select_d1 = (reg_offset[11:0] >= (32'hf048 & 32'hfff)) & (reg2dp_producer == 1'h1 );
assign s_reg_wr_en = reg_wr_en & select_s;
assign d0_reg_wr_en = reg_wr_en & select_d0 & ~reg2dp_d0_op_en;
assign d1_reg_wr_en = reg_wr_en & select_d1 & ~reg2dp_d1_op_en;
assign s_reg_offset = reg_offset;
assign d0_reg_offset = reg_offset;
assign d1_reg_offset = reg_offset;
assign s_reg_wr_data = reg_wr_data;
assign d0_reg_wr_data = reg_wr_data;
assign d1_reg_wr_data = reg_wr_data;
assign reg_rd_data = ({32{select_s}} & s_reg_rd_data) |
                     ({32{select_d0}} & d0_reg_rd_data) |
                     ({32{select_d1}} & d1_reg_rd_data);
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
////////////////////////////////////////////////////////////////////////
// //
// GENERATE CSB TO REGISTER CONNECTION LOGIC //
// //
////////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    req_pvld <= 1'b0;
  end else begin
  req_pvld <= csb2cdp_req_pvld;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    req_pd <= {63{1'b0}};
  end else begin
  if ((csb2cdp_req_pvld) == 1'b1) begin
    req_pd <= csb2cdp_req_pd;
// VCS coverage off
  end else if ((csb2cdp_req_pvld) == 1'b0) begin
  end else begin
    req_pd <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
// PKT_UNPACK_WIRE( csb2xx_16m_be_lvl , req_ , req_pd )
assign req_addr[21:0] = req_pd[21:0];
assign req_wdat[31:0] = req_pd[53:22];
assign req_write = req_pd[54];
assign req_nposted = req_pd[55];
assign req_srcpriv = req_pd[56];
assign req_wrbe[3:0] = req_pd[60:57];
assign req_level[1:0] = req_pd[62:61];
assign csb2cdp_req_prdy = 1'b1;
//Address in CSB master is word aligned while address in regfile is byte aligned.
assign reg_offset = {req_addr, 2'b0};
assign reg_wr_data = req_wdat;
assign reg_wr_en = req_pvld & req_write;
assign reg_rd_en = req_pvld & ~req_write;
// PKT_PACK_WIRE_ID( nvdla_xx2csb_resp , dla_xx2csb_rd_erpt , csb_rresp_ , csb_rresp_pd_w )
assign csb_rresp_pd_w[31:0] = csb_rresp_rdat[31:0];
assign csb_rresp_pd_w[32] = csb_rresp_error ;
assign csb_rresp_pd_w[33:33] = 1'd0 /* PKT_nvdla_xx2csb_resp_dla_xx2csb_rd_erpt_ID  */ ;
// PKT_PACK_WIRE_ID( nvdla_xx2csb_resp , dla_xx2csb_wr_erpt , csb_wresp_ , csb_wresp_pd_w )
assign csb_wresp_pd_w[31:0] = csb_wresp_rdat[31:0];
assign csb_wresp_pd_w[32] = csb_wresp_error ;
assign csb_wresp_pd_w[33:33] = 1'd1 /* PKT_nvdla_xx2csb_resp_dla_xx2csb_wr_erpt_ID  */ ;
assign csb_rresp_rdat = reg_rd_data;
assign csb_rresp_error = 1'b0;
assign csb_wresp_rdat = {32{1'b0}};
assign csb_wresp_error = 1'b0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cdp2csb_resp_pd <= {34{1'b0}};
  end else begin
    if(reg_rd_en)
    begin
        cdp2csb_resp_pd <= csb_rresp_pd_w;
    end
    else if(reg_wr_en & req_nposted)
    begin
        cdp2csb_resp_pd <= csb_wresp_pd_w;
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cdp2csb_resp_valid <= 1'b0;
  end else begin
    cdp2csb_resp_valid <= (reg_wr_en & req_nposted) | reg_rd_en;
  end
end
////////////////////////////////////////////////////////////////////////
// //
// GENERATE OUTPUT REGISTER FILED FROM DUPLICATED REGISTER GROUPS //
// //
////////////////////////////////////////////////////////////////////////
always @(
  dp2reg_consumer
  or reg2dp_d1_dst_base_addr_high
  or reg2dp_d0_dst_base_addr_high
  ) begin
    reg2dp_dst_base_addr_high = dp2reg_consumer ? reg2dp_d1_dst_base_addr_high : reg2dp_d0_dst_base_addr_high;
end
always @(
  dp2reg_consumer
  or reg2dp_d1_dst_base_addr_low
  or reg2dp_d0_dst_base_addr_low
  ) begin
    reg2dp_dst_base_addr_low = dp2reg_consumer ? reg2dp_d1_dst_base_addr_low : reg2dp_d0_dst_base_addr_low;
end
always @(
  dp2reg_consumer
  or reg2dp_d1_dst_line_stride
  or reg2dp_d0_dst_line_stride
  ) begin
    reg2dp_dst_line_stride = dp2reg_consumer ? reg2dp_d1_dst_line_stride : reg2dp_d0_dst_line_stride;
end
always @(
  dp2reg_consumer
  or reg2dp_d1_dst_surface_stride
  or reg2dp_d0_dst_surface_stride
  ) begin
    reg2dp_dst_surface_stride = dp2reg_consumer ? reg2dp_d1_dst_surface_stride : reg2dp_d0_dst_surface_stride;
end


endmodule // NV_NVDLA_CDP_reg
