// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_RDMA_REG_single.v
module NV_NVDLA_SDP_RDMA_REG_single (
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
wire [31:0] nvdla_sdp_rdma_s_pointer_0_out;
wire [31:0] nvdla_sdp_rdma_s_status_0_out;
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
reg producer;
reg [31:0] reg_rd_data;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire nvdla_sdp_rdma_s_pointer_0_wren = (reg_offset_wr == (32'h8004 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_sdp_rdma_s_status_0_wren = (reg_offset_wr == (32'h8000 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign nvdla_sdp_rdma_s_pointer_0_out[31:0] = { 15'b0, consumer, 15'b0, producer };
assign nvdla_sdp_rdma_s_status_0_out[31:0] = { 14'b0, status_1, 14'b0, status_0 };
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or nvdla_sdp_rdma_s_pointer_0_out
  or nvdla_sdp_rdma_s_status_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h8004 & 32'h00000fff): begin
                            reg_rd_data = nvdla_sdp_rdma_s_pointer_0_out ;
                            end
     (32'h8000 & 32'h00000fff): begin
                            reg_rd_data = nvdla_sdp_rdma_s_status_0_out ;
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
// Not generating flops for read-only field NVDLA_SDP_RDMA_S_POINTER_0::consumer
// Register: NVDLA_SDP_RDMA_S_POINTER_0 Field: producer
  if (nvdla_sdp_rdma_s_pointer_0_wren) begin
    producer <= reg_wr_data[0];
  end
// Not generating flops for read-only field NVDLA_SDP_RDMA_S_STATUS_0::status_0
// Not generating flops for read-only field NVDLA_SDP_RDMA_S_STATUS_0::status_1
  end
end

endmodule // NV_NVDLA_SDP_RDMA_REG_single
