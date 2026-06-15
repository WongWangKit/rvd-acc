// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_dual_reg.v
module NV_NVDLA_CDMA_dual_reg (
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
  ,data_bank
  ,weight_bank
  ,batches
  ,batch_stride
  ,conv_x_stride
  ,conv_y_stride
  ,cvt_en
  ,cvt_truncate
  ,cvt_offset
  ,cvt_scale
  ,cya
  ,datain_addr_high_0
  ,datain_addr_high_1
  ,datain_addr_low_0
  ,datain_addr_low_1
  ,line_packed
  ,surf_packed
  ,datain_ram_type
  ,datain_format
  ,pixel_format
  ,pixel_mapping
  ,pixel_sign_override
  ,datain_height
  ,datain_width
  ,datain_channel
  ,datain_height_ext
  ,datain_width_ext
  ,entries
  ,grains
  ,line_stride
  ,uv_line_stride
  ,mean_format
  ,mean_gu
  ,mean_ry
  ,mean_ax
  ,mean_bv
  ,conv_mode
  ,data_reuse
  ,in_precision
  ,proc_precision
  ,skip_data_rls
  ,skip_weight_rls
  ,weight_reuse
  ,nan_to_zero
  ,op_en_trigger
  ,dma_en
  ,pixel_x_offset
  ,pixel_y_offset
  ,rsv_per_line
  ,rsv_per_uv_line
  ,rsv_height
  ,rsv_y_index
  ,surf_stride
  ,weight_addr_high
  ,weight_addr_low
  ,weight_bytes
  ,weight_format
  ,weight_ram_type
  ,byte_per_kernel
  ,weight_kernel
  ,weight_kernel_dwc
  ,wgs_addr_high
  ,wgs_addr_low
  ,wmb_addr_high
  ,wmb_addr_low
  ,wmb_bytes
  ,pad_bottom
  ,pad_left
  ,pad_right
  ,pad_top
  ,pad_value
  ,inf_data_num
  ,inf_weight_num
  ,nan_data_num
  ,nan_weight_num
  ,op_en
  ,dat_rd_latency
  ,dat_rd_stall
  ,wt_rd_latency
  ,wt_rd_stall
  );
wire [31:0] nvdla_cdma_d_bank_0_out;
wire [31:0] nvdla_cdma_d_conv_stride_0_out;
wire [31:0] nvdla_cdma_d_dain_addr_low_0_0_out;
wire [31:0] nvdla_cdma_d_dain_map_0_out;
wire [31:0] nvdla_cdma_d_datain_size_0_0_out;
wire [31:0] nvdla_cdma_d_datain_size_1_0_out;
wire [31:0] nvdla_cdma_d_datain_size_ext_0_0_out;
wire [31:0] nvdla_cdma_d_entry_per_slice_0_out;
wire [31:0] nvdla_cdma_d_line_stride_0_out;
wire [31:0] nvdla_cdma_d_misc_cfg_0_out;
wire [31:0] nvdla_cdma_d_op_enable_0_out;
wire [31:0] nvdla_cdma_d_surf_stride_0_out;
wire [31:0] nvdla_cdma_d_weight_addr_low_0_out;
wire [31:0] nvdla_cdma_d_weight_bytes_0_out;
wire [31:0] nvdla_cdma_d_weight_size_0_0_out;
wire [31:0] nvdla_cdma_d_weight_size_1_0_out;
wire [31:0] nvdla_cdma_d_zero_padding_0_out;
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
output [4:0] data_bank;
output [4:0] weight_bank;
output [4:0] batches;
output [31:0] batch_stride;
output [2:0] conv_x_stride;
output [2:0] conv_y_stride;
output cvt_en;
output [5:0] cvt_truncate;
output [15:0] cvt_offset;
output [15:0] cvt_scale;
output [31:0] cya;
output [31:0] datain_addr_high_0;
output [31:0] datain_addr_high_1;
output [31:0] datain_addr_low_0;
output [31:0] datain_addr_low_1;
output line_packed;
output surf_packed;
output datain_ram_type;
output datain_format;
output [5:0] pixel_format;
output pixel_mapping;
output pixel_sign_override;
output [12:0] datain_height;
output [12:0] datain_width;
output [12:0] datain_channel;
output [12:0] datain_height_ext;
output [12:0] datain_width_ext;
output [13:0] entries;
output [11:0] grains;
output [31:0] line_stride;
output [31:0] uv_line_stride;
output mean_format;
output [15:0] mean_gu;
output [15:0] mean_ry;
output [15:0] mean_ax;
output [15:0] mean_bv;
output conv_mode;
output data_reuse;
output [1:0] in_precision;
output [1:0] proc_precision;
output skip_data_rls;
output skip_weight_rls;
output weight_reuse;
output nan_to_zero;
output op_en_trigger;
output dma_en;
output [4:0] pixel_x_offset;
output [2:0] pixel_y_offset;
output [9:0] rsv_per_line;
output [9:0] rsv_per_uv_line;
output [2:0] rsv_height;
output [4:0] rsv_y_index;
output [31:0] surf_stride;
output [31:0] weight_addr_high;
output [31:0] weight_addr_low;
output [31:0] weight_bytes;
output weight_format;
output weight_ram_type;
output [17:0] byte_per_kernel;
output [12:0] weight_kernel;
output [12:0] weight_kernel_dwc;
output [31:0] wgs_addr_high;
output [31:0] wgs_addr_low;
output [31:0] wmb_addr_high;
output [31:0] wmb_addr_low;
output [27:0] wmb_bytes;
output [5:0] pad_bottom;
output [4:0] pad_left;
output [5:0] pad_right;
output [4:0] pad_top;
output [15:0] pad_value;
// Read-only register inputs
input [31:0] inf_data_num;
input [31:0] inf_weight_num;
input [31:0] nan_data_num;
input [31:0] nan_weight_num;
input op_en;
input [31:0] dat_rd_latency;
input [31:0] dat_rd_stall;
input [31:0] wt_rd_latency;
input [31:0] wt_rd_stall;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg [17:0] byte_per_kernel;
reg conv_mode;
reg [2:0] conv_x_stride;
reg [2:0] conv_y_stride;
reg [4:0] data_bank;
reg data_reuse;
reg [31:0] datain_addr_low_0;
reg [12:0] datain_channel;
reg [12:0] datain_height;
reg [12:0] datain_height_ext;
reg [12:0] datain_width;
reg [12:0] datain_width_ext;
reg [13:0] entries;
reg [1:0] in_precision;
reg line_packed;
reg [31:0] line_stride;
reg [5:0] pad_bottom;
reg [4:0] pad_left;
reg [5:0] pad_right;
reg [4:0] pad_top;
reg [1:0] proc_precision;
reg [31:0] reg_rd_data;
reg skip_data_rls;
reg skip_weight_rls;
reg surf_packed;
reg [31:0] surf_stride;
reg [31:0] weight_addr_low;
reg [4:0] weight_bank;
reg [31:0] weight_bytes;
reg [12:0] weight_kernel;
reg [12:0] weight_kernel_dwc;
reg weight_reuse;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire nvdla_cdma_d_bank_0_wren = (reg_offset_wr == (32'h307c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_conv_stride_0_wren = (reg_offset_wr == (32'h3074 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_dain_addr_low_0_0_wren = (reg_offset_wr == (32'h3050 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_dain_map_0_wren = (reg_offset_wr == (32'h305c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_datain_size_0_0_wren = (reg_offset_wr == (32'h3044 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_datain_size_1_0_wren = (reg_offset_wr == (32'h3048 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_datain_size_ext_0_0_wren = (reg_offset_wr == (32'h304c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_entry_per_slice_0_wren = (reg_offset_wr == (32'h3060 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_line_stride_0_wren = (reg_offset_wr == (32'h3054 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_misc_cfg_0_wren = (reg_offset_wr == (32'h3040 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_op_enable_0_wren = (reg_offset_wr == (32'h3080 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_surf_stride_0_wren = (reg_offset_wr == (32'h3058 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_weight_addr_low_0_wren = (reg_offset_wr == (32'h306c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_weight_bytes_0_wren = (reg_offset_wr == (32'h3070 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_weight_size_0_0_wren = (reg_offset_wr == (32'h3064 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_weight_size_1_0_wren = (reg_offset_wr == (32'h3068 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_cdma_d_zero_padding_0_wren = (reg_offset_wr == (32'h3078 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign nvdla_cdma_d_bank_0_out[31:0] = { 11'b0, weight_bank, 11'b0, data_bank };
assign nvdla_cdma_d_conv_stride_0_out[31:0] = { 13'b0, conv_y_stride, 13'b0, conv_x_stride };
assign nvdla_cdma_d_dain_addr_low_0_0_out[31:0] = { datain_addr_low_0 };
assign nvdla_cdma_d_dain_map_0_out[31:0] = { 15'b0, surf_packed, 15'b0, line_packed };
assign nvdla_cdma_d_datain_size_0_0_out[31:0] = { 3'b0, datain_height, 3'b0, datain_width };
assign nvdla_cdma_d_datain_size_1_0_out[31:0] = { 19'b0, datain_channel };
assign nvdla_cdma_d_datain_size_ext_0_0_out[31:0] = { 3'b0, datain_height_ext, 3'b0, datain_width_ext };
assign nvdla_cdma_d_entry_per_slice_0_out[31:0] = { 18'b0, entries };
assign nvdla_cdma_d_line_stride_0_out[31:0] = { line_stride };
assign nvdla_cdma_d_misc_cfg_0_out[31:0] = { 3'b0, skip_weight_rls, 3'b0, skip_data_rls, 3'b0, weight_reuse, 3'b0, data_reuse, 2'b0, proc_precision, 2'b0, in_precision, 7'b0, conv_mode };
assign nvdla_cdma_d_op_enable_0_out[31:0] = { 31'b0, op_en };
assign nvdla_cdma_d_surf_stride_0_out[31:0] = { surf_stride };
assign nvdla_cdma_d_weight_addr_low_0_out[31:0] = { weight_addr_low };
assign nvdla_cdma_d_weight_bytes_0_out[31:0] = { weight_bytes };
assign nvdla_cdma_d_weight_size_0_0_out[31:0] = { 14'b0, byte_per_kernel };
assign nvdla_cdma_d_weight_size_1_0_out[31:0] = { 3'b0, weight_kernel_dwc, 3'b0, weight_kernel };
assign nvdla_cdma_d_zero_padding_0_out[31:0] = { 2'b0, pad_bottom, 3'b0, pad_top, 2'b0, pad_right, 3'b0, pad_left };
assign op_en_trigger = nvdla_cdma_d_op_enable_0_wren; //(W563)
assign batches = 5'b00000;
assign batch_stride = 32'b00000000000000000000000000000000;
assign cvt_en = 1'b0;
assign cvt_truncate = 6'b000000;
assign cvt_offset = 16'b0000000000000000;
assign cvt_scale = 16'b0000000000000000;
assign cya = 32'b00000000000000000000000000000000;
assign datain_addr_high_0 = 32'b00000000000000000000000000000000;
assign datain_addr_high_1 = 32'b00000000000000000000000000000000;
assign datain_addr_low_1 = 32'b00000000000000000000000000000000;
assign datain_ram_type = 1'b0;
assign datain_format = 1'b0;
assign pixel_format = 6'b001100;
assign pixel_mapping = 1'b0;
assign pixel_sign_override = 1'b0;
assign grains = 12'b000000000000;
assign uv_line_stride = 32'b00000000000000000000000000000000;
assign mean_format = 1'b0;
assign mean_gu = 16'b0000000000000000;
assign mean_ry = 16'b0000000000000000;
assign mean_ax = 16'b0000000000000000;
assign mean_bv = 16'b0000000000000000;
assign nan_to_zero = 1'b0;
assign dma_en = 1'b0;
assign pixel_x_offset = 5'b00000;
assign pixel_y_offset = 3'b000;
assign rsv_per_line = 10'b0000000000;
assign rsv_per_uv_line = 10'b0000000000;
assign rsv_height = 3'b000;
assign rsv_y_index = 5'b00000;
assign weight_addr_high = 32'b00000000000000000000000000000000;
assign weight_format = 1'b0;
assign weight_ram_type = 1'b0;
assign wgs_addr_high = 32'b00000000000000000000000000000000;
assign wgs_addr_low = 32'b00000000000000000000000000000000;
assign wmb_addr_high = 32'b00000000000000000000000000000000;
assign wmb_addr_low = 32'b00000000000000000000000000000000;
assign wmb_bytes = 28'b0000000000000000000000000000;
assign pad_value = 16'b0000000000000000;
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(*) begin
  case (reg_offset_rd_int)
     (32'h307c & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_bank_0_out ;
                            end
     (32'h3074 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_conv_stride_0_out ;
                            end
     (32'h3050 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_dain_addr_low_0_0_out ;
                            end
     (32'h305c & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_dain_map_0_out ;
                            end
     (32'h3044 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_datain_size_0_0_out ;
                            end
     (32'h3048 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_datain_size_1_0_out ;
                            end
     (32'h304c & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_datain_size_ext_0_0_out ;
                            end
     (32'h3060 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_entry_per_slice_0_out ;
                            end
     (32'h3054 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_line_stride_0_out ;
                            end
     (32'h3040 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_misc_cfg_0_out ;
                            end
     (32'h3080 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_op_enable_0_out ;
                            end
     (32'h3058 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_surf_stride_0_out ;
                            end
     (32'h306c & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_weight_addr_low_0_out ;
                            end
     (32'h3070 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_weight_bytes_0_out ;
                            end
     (32'h3064 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_weight_size_0_0_out ;
                            end
     (32'h3068 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_weight_size_1_0_out ;
                            end
     (32'h3078 & 32'h00000fff): begin
                            reg_rd_data = nvdla_cdma_d_zero_padding_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    data_bank[4:0] <= 5'b00000;
    weight_bank[4:0] <= 5'b00000;
    conv_x_stride[2:0] <= 3'b000;
    conv_y_stride[2:0] <= 3'b000;
    datain_addr_low_0[31:0] <= 32'b00000000000000000000000000000000;
    line_packed <= 1'b0;
    surf_packed <= 1'b0;
    datain_height[12:0] <= 13'b0000000000000;
    datain_width[12:0] <= 13'b0000000000000;
    datain_channel[12:0] <= 13'b0000000000000;
    datain_height_ext[12:0] <= 13'b0000000000000;
    datain_width_ext[12:0] <= 13'b0000000000000;
    entries[13:0] <= 14'b00000000000000;
    line_stride[31:0] <= 32'b00000000000000000000000000000000;
    conv_mode <= 1'b0;
    data_reuse <= 1'b0;
    in_precision[1:0] <= 2'b01;
    proc_precision[1:0] <= 2'b01;
    skip_data_rls <= 1'b0;
    skip_weight_rls <= 1'b0;
    weight_reuse <= 1'b0;
    surf_stride[31:0] <= 32'b00000000000000000000000000000000;
    weight_addr_low[31:0] <= 32'b00000000000000000000000000000000;
    weight_bytes[31:0] <= 32'b00000000000000000000000000000000;
    byte_per_kernel[17:0] <= 18'b000000000000000000;
    weight_kernel[12:0] <= 13'b0000000000000;
    weight_kernel_dwc[12:0] <= 13'b0000000000000;
    pad_bottom[5:0] <= 6'b000000;
    pad_left[4:0] <= 5'b00000;
    pad_right[5:0] <= 6'b000000;
    pad_top[4:0] <= 5'b00000;
  end else begin
    if (nvdla_cdma_d_bank_0_wren) begin
      data_bank[4:0] <= reg_wr_data[4:0];
      weight_bank[4:0] <= reg_wr_data[20:16];
    end
    if (nvdla_cdma_d_conv_stride_0_wren) begin
      conv_x_stride[2:0] <= reg_wr_data[2:0];
      conv_y_stride[2:0] <= reg_wr_data[18:16];
    end
    if (nvdla_cdma_d_dain_addr_low_0_0_wren) begin
      datain_addr_low_0[31:0] <= reg_wr_data[31:0];
    end
    if (nvdla_cdma_d_dain_map_0_wren) begin
      line_packed <= reg_wr_data[0];
      surf_packed <= reg_wr_data[16];
    end
    if (nvdla_cdma_d_datain_size_0_0_wren) begin
      datain_height[12:0] <= reg_wr_data[28:16];
      datain_width[12:0] <= reg_wr_data[12:0];
    end
    if (nvdla_cdma_d_datain_size_1_0_wren) begin
      datain_channel[12:0] <= reg_wr_data[12:0];
    end
    if (nvdla_cdma_d_datain_size_ext_0_0_wren) begin
      datain_height_ext[12:0] <= reg_wr_data[28:16];
      datain_width_ext[12:0] <= reg_wr_data[12:0];
    end
    if (nvdla_cdma_d_entry_per_slice_0_wren) begin
      entries[13:0] <= reg_wr_data[13:0];
    end
    if (nvdla_cdma_d_line_stride_0_wren) begin
      line_stride[31:0] <= reg_wr_data[31:0];
    end
    if (nvdla_cdma_d_misc_cfg_0_wren) begin
      conv_mode <= reg_wr_data[0];
      data_reuse <= reg_wr_data[16];
      in_precision[1:0] <= reg_wr_data[9:8];
      proc_precision[1:0] <= reg_wr_data[13:12];
      skip_data_rls <= reg_wr_data[24];
      skip_weight_rls <= reg_wr_data[28];
      weight_reuse <= reg_wr_data[20];
    end
    if (nvdla_cdma_d_surf_stride_0_wren) begin
      surf_stride[31:0] <= reg_wr_data[31:0];
    end
    if (nvdla_cdma_d_weight_addr_low_0_wren) begin
      weight_addr_low[31:0] <= reg_wr_data[31:0];
    end
    if (nvdla_cdma_d_weight_bytes_0_wren) begin
      weight_bytes[31:0] <= reg_wr_data[31:0];
    end
    if (nvdla_cdma_d_weight_size_0_0_wren) begin
      byte_per_kernel[17:0] <= reg_wr_data[17:0];
    end
    if (nvdla_cdma_d_weight_size_1_0_wren) begin
      weight_kernel[12:0] <= reg_wr_data[12:0];
      weight_kernel_dwc[12:0] <= reg_wr_data[28:16];
    end
    if (nvdla_cdma_d_zero_padding_0_wren) begin
      pad_bottom[5:0] <= reg_wr_data[29:24];
      pad_left[4:0] <= reg_wr_data[4:0];
      pad_right[5:0] <= reg_wr_data[13:8];
      pad_top[4:0] <= reg_wr_data[20:16];
    end
  end
end


endmodule // NV_NVDLA_CDMA_dual_reg
