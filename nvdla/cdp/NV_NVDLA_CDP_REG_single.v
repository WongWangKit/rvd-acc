// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_REG_single.v
module NV_NVDLA_CDP_REG_single (
   reg_rd_data
  ,reg_offset
// verilint 498 off
// leda UNUSED_DEC off
  ,reg_wr_data
// verilint 498 on
// leda UNUSED_DEC on
  ,reg_wr_en
  ,nvdla_core_clk
  ,nvdla_core_rstn
  ,producer
  ,consumer
  ,status_0
  ,status_1
  );
wire [31:0] nvdla_cdp_s_lut_access_cfg_0_out;
wire [31:0] nvdla_cdp_s_lut_access_data_0_out;
wire [31:0] nvdla_cdp_s_lut_cfg_0_out;
wire [31:0] nvdla_cdp_s_lut_info_0_out;
wire [31:0] nvdla_cdp_s_lut_le_end_high_0_out;
wire [31:0] nvdla_cdp_s_lut_le_end_low_0_out;
wire [31:0] nvdla_cdp_s_lut_le_slope_scale_0_out;
wire [31:0] nvdla_cdp_s_lut_le_slope_shift_0_out;
wire [31:0] nvdla_cdp_s_lut_le_start_high_0_out;
wire [31:0] nvdla_cdp_s_lut_le_start_low_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_end_high_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_end_low_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_slope_scale_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_slope_shift_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_start_high_0_out;
wire [31:0] nvdla_cdp_s_lut_lo_start_low_0_out;
wire [31:0] nvdla_cdp_s_pointer_0_out;
wire [31:0] nvdla_cdp_s_status_0_out;
wire [11:0] reg_offset_rd_int;
wire [31:0] reg_offset_wr;
// Register control interface
output [31:0] reg_rd_data;
input [11:0] reg_offset;
input [31:0] reg_wr_data; //(UNUSED_DEC)
input reg_wr_en;
input nvdla_core_clk;
input nvdla_core_rstn;
output producer;
// Read-only register inputs
input consumer;
input [1:0] status_0;
input [1:0] status_1;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg lut_access_type;
reg lut_hybrid_priority;
reg [5:0] lut_le_end_high;
reg [31:0] lut_le_end_low;
reg lut_le_function;
reg [7:0] lut_le_index_offset;
reg [7:0] lut_le_index_select;
reg [15:0] lut_le_slope_oflow_scale;
reg [4:0] lut_le_slope_oflow_shift;
reg [15:0] lut_le_slope_uflow_scale;
reg [4:0] lut_le_slope_uflow_shift;
reg [5:0] lut_le_start_high;
reg [31:0] lut_le_start_low;
reg [5:0] lut_lo_end_high;
reg [31:0] lut_lo_end_low;
reg [7:0] lut_lo_index_select;
reg [15:0] lut_lo_slope_oflow_scale;
reg [4:0] lut_lo_slope_oflow_shift;
reg [15:0] lut_lo_slope_uflow_scale;
reg [4:0] lut_lo_slope_uflow_shift;
reg [5:0] lut_lo_start_high;
reg [31:0] lut_lo_start_low;
reg lut_oflow_priority;
reg lut_table_id;
reg lut_uflow_priority;
reg producer;
reg [31:0] reg_rd_data;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire nvdla_cdp_s_pointer_0_wren = (reg_offset_wr == (32'hf004 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdp_s_status_0_wren = (reg_offset_wr == (32'hf000 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)

assign nvdla_cdp_s_pointer_0_out[31:0] = { 15'b0, consumer, 15'b0, producer };
assign nvdla_cdp_s_status_0_out[31:0] = { 14'b0, status_1, 14'b0, status_0 };
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(*) begin
  case (reg_offset_rd_int)
     (32'hf004 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_s_pointer_0_out ;
                            end
     (32'hf000 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_s_status_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    producer <= 1'b0;
  end else begin
  if (nvdla_cdp_s_pointer_0_wren) begin
    producer <= reg_wr_data[0];
  end
  end
end

endmodule // NV_NVDLA_CDP_REG_single
