// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC_regfile.v
`include "simulate_x_tick.vh"
module NV_NVDLA_CACC_regfile (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,csb2cacc_req_pd //|< i
  ,csb2cacc_req_pvld //|< i
  ,dp2reg_done //|< i
  ,cdma2reg_consumer //|< i
  ,cdma2reg_d0_op_en //|< i
  ,cdma2reg_d1_op_en //|< i
  ,cdma2reg_op_en //|< i
  ,cdma2reg_producer //|< i
  ,dp2reg_sat_count //|< i
  ,cacc2csb_resp_pd //|> o
  ,cacc2csb_resp_valid //|> o
  ,csb2cacc_req_prdy //|> o
  ,reg2dp_batches //|> o
  ,reg2dp_clip_truncate //|> o
  ,reg2dp_conv_mode //|> o
  ,reg2dp_cya //|> o
  ,reg2dp_dataout_addr //|> o
  ,reg2dp_dataout_channel //|> o
  ,reg2dp_dataout_height //|> o
  ,reg2dp_dataout_width //|> o
  ,reg2dp_line_packed //|> o
  ,reg2dp_line_stride //|> o
  ,reg2dp_op_en //|> o
  ,reg2dp_proc_precision //|> o
  ,reg2dp_surf_packed //|> o
  ,reg2dp_surf_stride //|> o
  ,slcg_op_en //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [62:0] csb2cacc_req_pd;
input csb2cacc_req_pvld;
input dp2reg_done;
input cdma2reg_consumer;
input cdma2reg_d0_op_en;
input cdma2reg_d1_op_en;
input cdma2reg_op_en;
input cdma2reg_producer;
input [31:0] dp2reg_sat_count;
output [33:0] cacc2csb_resp_pd;
output cacc2csb_resp_valid;
output csb2cacc_req_prdy;
output [4:0] reg2dp_batches;
output [4:0] reg2dp_clip_truncate;
output reg2dp_conv_mode;
output [31:0] reg2dp_cya;
output [31:0] reg2dp_dataout_addr;
output [12:0] reg2dp_dataout_channel;
output [12:0] reg2dp_dataout_height;
output [12:0] reg2dp_dataout_width;
output reg2dp_line_packed;
output [23:0] reg2dp_line_stride;
output reg2dp_op_en;
output [1:0] reg2dp_proc_precision;
output reg2dp_surf_packed;
output [23:0] reg2dp_surf_stride;
output [6:0] slcg_op_en;
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
wire [4:0] reg2dp_d0_batches;
wire [4:0] reg2dp_d0_clip_truncate;
wire reg2dp_d0_conv_mode;
wire [31:0] reg2dp_d0_cya;
wire [31:0] reg2dp_d0_dataout_addr;
wire [12:0] reg2dp_d0_dataout_channel;
wire [12:0] reg2dp_d0_dataout_height;
wire [12:0] reg2dp_d0_dataout_width;
wire reg2dp_d0_line_packed;
wire [23:0] reg2dp_d0_line_stride;
wire reg2dp_d0_op_en_trigger;
wire [1:0] reg2dp_d0_proc_precision;
wire reg2dp_d0_surf_packed;
wire [23:0] reg2dp_d0_surf_stride;
wire [4:0] reg2dp_d1_batches;
wire [4:0] reg2dp_d1_clip_truncate;
wire reg2dp_d1_conv_mode;
wire [31:0] reg2dp_d1_cya;
wire [31:0] reg2dp_d1_dataout_addr;
wire [12:0] reg2dp_d1_dataout_channel;
wire [12:0] reg2dp_d1_dataout_height;
wire [12:0] reg2dp_d1_dataout_width;
wire reg2dp_d1_line_packed;
wire [23:0] reg2dp_d1_line_stride;
wire reg2dp_d1_op_en_trigger;
wire [1:0] reg2dp_d1_proc_precision;
wire reg2dp_d1_surf_packed;
wire [23:0] reg2dp_d1_surf_stride;
wire [2:0] reg2dp_op_en_reg_w;
wire reg2dp_producer;
wire [23:0] reg_offset;
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
wire [6:0] slcg_op_en_d0;
reg [33:0] cacc2csb_resp_pd;
reg cacc2csb_resp_valid;
reg dp2reg_d0_clr;
reg dp2reg_d0_reg;
reg [31:0] dp2reg_d0_sat_count;
reg [31:0] dp2reg_d0_sat_count_w;
reg dp2reg_d0_set;
reg dp2reg_d1_clr;
reg dp2reg_d1_reg;
reg [31:0] dp2reg_d1_sat_count;
reg [31:0] dp2reg_d1_sat_count_w;
reg dp2reg_d1_set;
reg [1:0] dp2reg_status_0;
reg [1:0] dp2reg_status_1;
reg [4:0] reg2dp_batches;
reg [4:0] reg2dp_clip_truncate;
reg reg2dp_conv_mode;
reg [31:0] reg2dp_cya;
wire reg2dp_d0_op_en_w;
wire reg2dp_d1_op_en_w;
reg [31:0] reg2dp_dataout_addr;
reg [12:0] reg2dp_dataout_channel;
reg [12:0] reg2dp_dataout_height;
reg [12:0] reg2dp_dataout_width;
reg reg2dp_line_packed;
reg [23:0] reg2dp_line_stride;
reg reg2dp_op_en_ori;
reg [2:0] reg2dp_op_en_reg;
reg [1:0] reg2dp_proc_precision;
reg reg2dp_surf_packed;
reg [23:0] reg2dp_surf_stride;
reg [62:0] req_pd;
reg req_pvld;
reg [6:0] slcg_op_en_d1;
reg [6:0] slcg_op_en_d2;
reg [6:0] slcg_op_en_d3;
//Instance single register group
NV_NVDLA_CACC_single_reg u_single_reg (
   .reg_rd_data (s_reg_rd_data[31:0]) //|> w
  ,.reg_offset (s_reg_offset[11:0]) //|< w
  ,.reg_wr_data (s_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (s_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.producer (reg2dp_producer) //|> w
  ,.consumer (cdma2reg_consumer) //|< r
  ,.status_0 (dp2reg_status_0[1:0]) //|< r
  ,.status_1 (dp2reg_status_1[1:0]) //|< r
  );
//Instance two duplicated register groups
NV_NVDLA_CACC_dual_reg u_dual_reg_d0 (
   .reg_rd_data (d0_reg_rd_data[31:0]) //|> w
  ,.reg_offset (d0_reg_offset[11:0]) //|< w
  ,.reg_wr_data (d0_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (d0_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.batches (reg2dp_d0_batches[4:0]) //|> w
  ,.clip_truncate (reg2dp_d0_clip_truncate[4:0]) //|> w
  ,.cya (reg2dp_d0_cya[31:0]) //|> w
  ,.dataout_addr (reg2dp_d0_dataout_addr[31:0]) //|> w
  ,.line_packed (reg2dp_d0_line_packed) //|> w
  ,.surf_packed (reg2dp_d0_surf_packed) //|> w
  ,.dataout_height (reg2dp_d0_dataout_height[12:0]) //|> w
  ,.dataout_width (reg2dp_d0_dataout_width[12:0]) //|> w
  ,.dataout_channel (reg2dp_d0_dataout_channel[12:0]) //|> w
  ,.line_stride (reg2dp_d0_line_stride[23:0]) //|> w
  ,.conv_mode (reg2dp_d0_conv_mode) //|> w
  ,.proc_precision (reg2dp_d0_proc_precision[1:0]) //|> w
  ,.op_en_trigger (reg2dp_d0_op_en_trigger) //|> w
  ,.surf_stride (reg2dp_d0_surf_stride[23:0]) //|> w
  ,.op_en (cdma2reg_d0_op_en) //|< r
  ,.sat_count (dp2reg_d0_sat_count[31:0]) //|< r
  );
NV_NVDLA_CACC_dual_reg u_dual_reg_d1 (
   .reg_rd_data (d1_reg_rd_data[31:0]) //|> w
  ,.reg_offset (d1_reg_offset[11:0]) //|< w
  ,.reg_wr_data (d1_reg_wr_data[31:0]) //|< w
  ,.reg_wr_en (d1_reg_wr_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.batches (reg2dp_d1_batches[4:0]) //|> w
  ,.clip_truncate (reg2dp_d1_clip_truncate[4:0]) //|> w
  ,.cya (reg2dp_d1_cya[31:0]) //|> w
  ,.dataout_addr (reg2dp_d1_dataout_addr[31:0]) //|> w
  ,.line_packed (reg2dp_d1_line_packed) //|> w
  ,.surf_packed (reg2dp_d1_surf_packed) //|> w
  ,.dataout_height (reg2dp_d1_dataout_height[12:0]) //|> w
  ,.dataout_width (reg2dp_d1_dataout_width[12:0]) //|> w
  ,.dataout_channel (reg2dp_d1_dataout_channel[12:0]) //|> w
  ,.line_stride (reg2dp_d1_line_stride[23:0]) //|> w
  ,.conv_mode (reg2dp_d1_conv_mode) //|> w
  ,.proc_precision (reg2dp_d1_proc_precision[1:0]) //|> w
  ,.op_en_trigger (reg2dp_d1_op_en_trigger) //|> w
  ,.surf_stride (reg2dp_d1_surf_stride[23:0]) //|> w
  ,.op_en (cdma2reg_d1_op_en) //|< r
  ,.sat_count (dp2reg_d1_sat_count[31:0]) //|< r
  );
////////////////////////////////////////////////////////////////////////
// //
// CDMA drives the shared consumer pointer for CDMA/CSC/CMAC/CACC //
// //
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// //
// GENERATE TWO STATUS FIELDS IN GENERAL SINGLE REGISTER GROUP //
// //
////////////////////////////////////////////////////////////////////////
always @(
  cdma2reg_d0_op_en
  or cdma2reg_consumer
  ) begin
    dp2reg_status_0 = (cdma2reg_d0_op_en == 1'h0 ) ? 2'h0 :
                      (cdma2reg_consumer == 1'h1 ) ? 2'h2 :
                      2'h1 ;
end
always @(
  cdma2reg_d1_op_en
  or cdma2reg_consumer
  ) begin
    dp2reg_status_1 = (cdma2reg_d1_op_en == 1'h0 ) ? 2'h0 :
                      (cdma2reg_consumer == 1'h0 ) ? 2'h2 :
                      2'h1 ;
end
////////////////////////////////////////////////////////////////////////
// //
// CDMA drives shared op_en for CDMA/CSC/CMAC/CACC //
// //
////////////////////////////////////////////////////////////////////////
assign reg2dp_d0_op_en_w = cdma2reg_d0_op_en;
assign reg2dp_d1_op_en_w = cdma2reg_d1_op_en;
assign reg2dp_op_en = cdma2reg_op_en;
assign slcg_op_en = {7{cdma2reg_op_en}};
////////////////////////////////////////////////////////////////////////
// //
// GENERATE ACCESS LOGIC TO EACH REGISTER GROUP //
// //
////////////////////////////////////////////////////////////////////////
//EACH subunit has 4KB address space
assign select_s = (reg_offset[11:0] < (32'h7040 & 32'hfff)) ? 1'b1: 1'b0;
assign select_d0 = (reg_offset[11:0] >= (32'h7040 & 32'hfff)) & (cdma2reg_producer == 1'h0 );
assign select_d1 = (reg_offset[11:0] >= (32'h7040 & 32'hfff)) & (cdma2reg_producer == 1'h1 );
assign s_reg_wr_en = reg_wr_en & select_s;
assign d0_reg_wr_en = reg_wr_en & select_d0 & ~cdma2reg_d0_op_en;
assign d1_reg_wr_en = reg_wr_en & select_d1 & ~cdma2reg_d1_op_en;
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
  req_pvld <= csb2cacc_req_pvld;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    req_pd <= {63{1'b0}};
  end else begin
  if ((csb2cacc_req_pvld) == 1'b1) begin
    req_pd <= csb2cacc_req_pd;
// VCS coverage off
  end else if ((csb2cacc_req_pvld) == 1'b0) begin
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
assign csb2cacc_req_prdy = 1'b1;
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
    cacc2csb_resp_pd <= {34{1'b0}};
  end else begin
    if(reg_rd_en)
    begin
        cacc2csb_resp_pd <= csb_rresp_pd_w;
    end
    else if(reg_wr_en & req_nposted)
    begin
        cacc2csb_resp_pd <= csb_wresp_pd_w;
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cacc2csb_resp_valid <= 1'b0;
  end else begin
    cacc2csb_resp_valid <= (reg_wr_en & req_nposted) | reg_rd_en;
  end
end
////////////////////////////////////////////////////////////////////////
// //
// GENERATE OUTPUT REGISTER FILED FROM DUPLICATED REGISTER GROUPS //
// //
////////////////////////////////////////////////////////////////////////
always @(
  cdma2reg_consumer
  or reg2dp_d1_batches
  or reg2dp_d0_batches
  ) begin
    reg2dp_batches = cdma2reg_consumer ? reg2dp_d1_batches : reg2dp_d0_batches;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_clip_truncate
  or reg2dp_d0_clip_truncate
  ) begin
    reg2dp_clip_truncate = cdma2reg_consumer ? reg2dp_d1_clip_truncate : reg2dp_d0_clip_truncate;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_cya
  or reg2dp_d0_cya
  ) begin
    reg2dp_cya = cdma2reg_consumer ? reg2dp_d1_cya : reg2dp_d0_cya;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_dataout_addr
  or reg2dp_d0_dataout_addr
  ) begin
    reg2dp_dataout_addr = cdma2reg_consumer ? reg2dp_d1_dataout_addr : reg2dp_d0_dataout_addr;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_line_packed
  or reg2dp_d0_line_packed
  ) begin
    reg2dp_line_packed = cdma2reg_consumer ? reg2dp_d1_line_packed : reg2dp_d0_line_packed;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_surf_packed
  or reg2dp_d0_surf_packed
  ) begin
    reg2dp_surf_packed = cdma2reg_consumer ? reg2dp_d1_surf_packed : reg2dp_d0_surf_packed;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_dataout_height
  or reg2dp_d0_dataout_height
  ) begin
    reg2dp_dataout_height = cdma2reg_consumer ? reg2dp_d1_dataout_height : reg2dp_d0_dataout_height;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_dataout_width
  or reg2dp_d0_dataout_width
  ) begin
    reg2dp_dataout_width = cdma2reg_consumer ? reg2dp_d1_dataout_width : reg2dp_d0_dataout_width;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_dataout_channel
  or reg2dp_d0_dataout_channel
  ) begin
    reg2dp_dataout_channel = cdma2reg_consumer ? reg2dp_d1_dataout_channel : reg2dp_d0_dataout_channel;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_line_stride
  or reg2dp_d0_line_stride
  ) begin
    reg2dp_line_stride = cdma2reg_consumer ? reg2dp_d1_line_stride : reg2dp_d0_line_stride;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_conv_mode
  or reg2dp_d0_conv_mode
  ) begin
    reg2dp_conv_mode = cdma2reg_consumer ? reg2dp_d1_conv_mode : reg2dp_d0_conv_mode;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_proc_precision
  or reg2dp_d0_proc_precision
  ) begin
    reg2dp_proc_precision = cdma2reg_consumer ? reg2dp_d1_proc_precision : reg2dp_d0_proc_precision;
end
always @(
  cdma2reg_consumer
  or reg2dp_d1_surf_stride
  or reg2dp_d0_surf_stride
  ) begin
    reg2dp_surf_stride = cdma2reg_consumer ? reg2dp_d1_surf_stride : reg2dp_d0_surf_stride;
end
////////////////////////////////////////////////////////////////////////
// //
// PASTE ADDIFITON LOGIC HERE FROM EXTRA FILE //
// //
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// for general counting register //
////////////////////////////////////////////////////////////////////////
always @(
  cdma2reg_d0_op_en
  or reg2dp_d0_op_en_w
  ) begin
    dp2reg_d0_set = cdma2reg_d0_op_en & ~reg2dp_d0_op_en_w;
    dp2reg_d0_clr = ~cdma2reg_d0_op_en & reg2dp_d0_op_en_w;
    dp2reg_d0_reg = cdma2reg_d0_op_en ^ reg2dp_d0_op_en_w;
end
always @(
  cdma2reg_d1_op_en
  or reg2dp_d1_op_en_w
  ) begin
    dp2reg_d1_set = cdma2reg_d1_op_en & ~reg2dp_d1_op_en_w;
    dp2reg_d1_clr = ~cdma2reg_d1_op_en & reg2dp_d1_op_en_w;
    dp2reg_d1_reg = cdma2reg_d1_op_en ^ reg2dp_d1_op_en_w;
end
////////////////////////////////////////////////////////////////////////
// for output saturation register //
////////////////////////////////////////////////////////////////////////
//////// group 0 ////////
always @(
  dp2reg_d0_set
  or dp2reg_sat_count
  or dp2reg_d0_clr
  or dp2reg_d0_sat_count
  ) begin
    dp2reg_d0_sat_count_w = (dp2reg_d0_set) ? dp2reg_sat_count :
                            (dp2reg_d0_clr) ? 32'b0 :
                            dp2reg_d0_sat_count;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_sat_count <= {32{1'b0}};
  end else begin
  if ((dp2reg_d0_reg) == 1'b1) begin
    dp2reg_d0_sat_count <= dp2reg_d0_sat_count_w;
// VCS coverage off
  end else if ((dp2reg_d0_reg) == 1'b0) begin
  end else begin
    dp2reg_d0_sat_count <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
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
//////// group 1 ////////
always @(
  dp2reg_d1_set
  or dp2reg_sat_count
  or dp2reg_d1_clr
  or dp2reg_d1_sat_count
  ) begin
    dp2reg_d1_sat_count_w = (dp2reg_d1_set) ? dp2reg_sat_count :
                            (dp2reg_d1_clr) ? 32'b0 :
                            dp2reg_d1_sat_count;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_sat_count <= {32{1'b0}};
  end else begin
  if ((dp2reg_d1_reg) == 1'b1) begin
    dp2reg_d1_sat_count <= dp2reg_d1_sat_count_w;
// VCS coverage off
  end else if ((dp2reg_d1_reg) == 1'b0) begin
  end else begin
    dp2reg_d1_sat_count <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
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
endmodule // NV_NVDLA_CACC_regfile
