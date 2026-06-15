// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_HLS_prelu.v
module NV_NVDLA_SDP_HLS_prelu (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,cfg_prelu_en
  ,data_in
  ,op_in
  ,mul_pvld
  ,data_out
  ,res_pvld
  );
localparam IN_WIDTH = 33;
localparam OP_WIDTH = 16;
localparam OUT_WIDTH = 49;

input nvdla_core_clk;
input nvdla_core_rstn;
input cfg_prelu_en;
input [IN_WIDTH-1:0] data_in;
input [OP_WIDTH-1:0] op_in;
input mul_pvld;
output [OUT_WIDTH-1:0] data_out;
output res_pvld;
reg [OUT_WIDTH-1:0] data_out;
wire data_in_sign;

wire [32:0] mul_a_in;
wire [15:0] mul_b_in;
wire [48:0] mul_res_out;

reg [32:0] data_in_d0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (~nvdla_core_rstn) begin
      data_in_d0 <= 33'b0;
      // res_pvld <= 1'b0;
   end
   else begin
      data_in_d0 <= data_in;
      // res_pvld <= mul_pvld;
   end
end

assign data_in_sign = data_in_d0[IN_WIDTH-1];
always @(*) begin
   if (cfg_prelu_en & !data_in_sign)
      data_out[((OUT_WIDTH) - 1):0] = {{(OUT_WIDTH-IN_WIDTH){1'b0}},data_in_d0[IN_WIDTH-1:0]};
   else
      data_out[((OUT_WIDTH) - 1):0] = mul_res_out;
end


assign mul_a_in = data_in;
assign mul_b_in = op_in;
multi_16_33 u_multi_16_33(
	.clk     (nvdla_core_clk),
	.rst_n   (nvdla_core_rstn),
	.a_in    (mul_a_in),
	.b_in    (mul_b_in),
   .in_pvld (mul_pvld),
	.res_out (mul_res_out),
   .res_pvld(res_pvld)
);
endmodule // NV_NVDLA_SDP_HLS_prelu
