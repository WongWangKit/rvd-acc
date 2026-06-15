// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_REG_dual.v
module NV_NVDLA_CDP_REG_dual (
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
  ,dst_base_addr_high
  ,dst_base_addr_low
  ,dst_line_stride
  ,dst_surface_stride
  ,op_en_trigger
  ,op_en
  );
wire dst_compression_en;
wire [31:0] nvdla_cdp_d_cya_0_out;
wire [31:0] nvdla_cdp_d_data_format_0_out;
wire [31:0] nvdla_cdp_d_datin_offset_0_out;
wire [31:0] nvdla_cdp_d_datin_scale_0_out;
wire [31:0] nvdla_cdp_d_datin_shifter_0_out;
wire [31:0] nvdla_cdp_d_datout_offset_0_out;
wire [31:0] nvdla_cdp_d_datout_scale_0_out;
wire [31:0] nvdla_cdp_d_datout_shifter_0_out;
wire [31:0] nvdla_cdp_d_dst_base_addr_high_0_out;
wire [31:0] nvdla_cdp_d_dst_base_addr_low_0_out;
wire [31:0] nvdla_cdp_d_dst_compression_en_0_out;
wire [31:0] nvdla_cdp_d_dst_dma_cfg_0_out;
wire [31:0] nvdla_cdp_d_dst_line_stride_0_out;
wire [31:0] nvdla_cdp_d_dst_surface_stride_0_out;
wire [31:0] nvdla_cdp_d_func_bypass_0_out;
wire [31:0] nvdla_cdp_d_inf_input_num_0_out;
wire [31:0] nvdla_cdp_d_lrn_cfg_0_out;
wire [31:0] nvdla_cdp_d_nan_flush_to_zero_0_out;
wire [31:0] nvdla_cdp_d_nan_input_num_0_out;
wire [31:0] nvdla_cdp_d_nan_output_num_0_out;
wire [31:0] nvdla_cdp_d_op_enable_0_out;
wire [31:0] nvdla_cdp_d_out_saturation_0_out;
wire [31:0] nvdla_cdp_d_perf_enable_0_out;
wire [31:0] nvdla_cdp_d_perf_lut_hybrid_0_out;
wire [31:0] nvdla_cdp_d_perf_lut_le_hit_0_out;
wire [31:0] nvdla_cdp_d_perf_lut_lo_hit_0_out;
wire [31:0] nvdla_cdp_d_perf_lut_oflow_0_out;
wire [31:0] nvdla_cdp_d_perf_lut_uflow_0_out;
wire [31:0] nvdla_cdp_d_perf_write_stall_0_out;
wire [11:0] reg_offset_rd_int;
wire [31:0] reg_offset_wr;
// Register control interface
output [31:0] reg_rd_data;
input [11:0] reg_offset;
input [31:0] reg_wr_data; //(UNUSED_DEC)
input reg_wr_en;
input nvdla_core_clk;
input nvdla_core_rstn;
// Writable register flop/trigger outputs
output [31:0] dst_base_addr_high;
output [31:0] dst_base_addr_low;
output [31:0] dst_line_stride;
output [31:0] dst_surface_stride;
output op_en_trigger;
// Read-only register inputs
input op_en;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg [31:0] cya;
reg [15:0] datin_offset;
reg [15:0] datin_scale;
reg [4:0] datin_shifter;
reg [31:0] datout_offset;
reg [15:0] datout_scale;
reg [5:0] datout_shifter;
reg dma_en;
reg [31:0] dst_base_addr_high;
reg [31:0] dst_base_addr_low;
reg [31:0] dst_line_stride;
reg dst_ram_type;
reg [31:0] dst_surface_stride;
reg [1:0] input_data_type;
reg lut_en;
reg mul_bypass;
reg nan_to_zero;
reg [1:0] normalz_len;
reg [31:0] reg_rd_data;
reg sqsum_bypass;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire nvdla_cdp_d_dst_base_addr_high_0_wren = (reg_offset_wr == (32'hf054 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdp_d_dst_base_addr_low_0_wren = (reg_offset_wr == (32'hf050 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdp_d_dst_line_stride_0_wren = (reg_offset_wr == (32'hf058 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdp_d_dst_surface_stride_0_wren = (reg_offset_wr == (32'hf05c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdp_d_op_enable_0_wren = (reg_offset_wr == (32'hf048 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign dst_compression_en = 1'h0;
assign nvdla_cdp_d_dst_base_addr_high_0_out[31:0] = { dst_base_addr_high };
assign nvdla_cdp_d_dst_base_addr_low_0_out[31:0] = { dst_base_addr_low };
assign nvdla_cdp_d_dst_line_stride_0_out[31:0] = { dst_line_stride };
assign nvdla_cdp_d_dst_surface_stride_0_out[31:0] = { dst_surface_stride };
assign nvdla_cdp_d_op_enable_0_out[31:0] = { 31'b0, op_en };
assign op_en_trigger = nvdla_cdp_d_op_enable_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(*) begin
  case (reg_offset_rd_int)
     (32'hf054 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_d_dst_base_addr_high_0_out ;
                            end
     (32'hf050 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_d_dst_base_addr_low_0_out ;
                            end
     (32'hf058 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_d_dst_line_stride_0_out ;
                            end
     (32'hf05c & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_d_dst_surface_stride_0_out ;
                            end
     (32'hf048 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdp_d_op_enable_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dst_base_addr_high[31:0] <= 32'b00000000000000000000000000000000;
    dst_base_addr_low[31:0] <= 32'b00000000000000000000000000000000;
    dst_line_stride[31:0] <= 32'b00000000000000000000000000000000;
    dst_surface_stride[31:0] <= 32'b00000000000000000000000000000000;
  end else begin
// Register: NVDLA_CDP_D_DST_BASE_ADDR_HIGH_0 Field: dst_base_addr_high
  if (nvdla_cdp_d_dst_base_addr_high_0_wren) begin
    dst_base_addr_high[31:0] <= reg_wr_data[31:0];
  end
// Register: NVDLA_CDP_D_DST_BASE_ADDR_LOW_0 Field: dst_base_addr_low
  if (nvdla_cdp_d_dst_base_addr_low_0_wren) begin
    dst_base_addr_low[31:0] <= reg_wr_data[31:0];
  end
// Register: NVDLA_CDP_D_DST_LINE_STRIDE_0 Field: dst_line_stride
  if (nvdla_cdp_d_dst_line_stride_0_wren) begin
    dst_line_stride[31:0] <= reg_wr_data[31:0];
  end
// Register: NVDLA_CDP_D_DST_SURFACE_STRIDE_0 Field: dst_surface_stride
  if (nvdla_cdp_d_dst_surface_stride_0_wren) begin
    dst_surface_stride[31:0] <= reg_wr_data[31:0];
  end
  end
end

endmodule // NV_NVDLA_CDP_REG_dual
