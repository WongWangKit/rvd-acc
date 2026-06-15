// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_cdp.v
module NV_NVDLA_cdp (
   //  input  dla_clk_ovr_on_sync,
   //  input  global_clk_ovr_on_sync,
   //  input  tmc2slcg_disable_clock_gating,
    input  nvdla_core_clk,
    input  nvdla_core_rstn,
    output cdp2csb_resp_valid, /* data valid */
    output [33:0] cdp2csb_resp_pd, /* pkt_id_width=1 pkt_widths=33,33  */
    output [1:0] cdp2glb_done_intr_pd,
    output cdp2mcif_rd_cdt_lat_fifo_pop,
    output cdp2mcif_rd_req_valid, /* data valid */
    input  cdp2mcif_rd_req_ready, /* data return handshake */
    output [47 -1:0] cdp2mcif_rd_req_pd,
    output cdp2mcif_wr_req_valid, /* data valid */
    input  cdp2mcif_wr_req_ready, /* data return handshake */
    output [66 -1:0] cdp2mcif_wr_req_pd, /* pkt_id_width=1 pkt_widths=78,514  */
    output cdp_rdma2csb_resp_valid, /* data valid */
    output [33:0] cdp_rdma2csb_resp_pd, /* pkt_id_width=1 pkt_widths=33,33  */
    input  csb2cdp_rdma_req_pvld, /* data valid */
    output csb2cdp_rdma_req_prdy, /* data return handshake */
    input  [62:0] csb2cdp_rdma_req_pd,
    input  csb2cdp_req_pvld, /* data valid */
    output csb2cdp_req_prdy, /* data return handshake */
    input  [62:0] csb2cdp_req_pd,
    input  mcif2cdp_rd_rsp_valid, /* data valid */
    output mcif2cdp_rd_rsp_ready, /* data return handshake */
    input  [65 -1:0] mcif2cdp_rd_rsp_pd,
    input  mcif2cdp_wr_rsp_complete,
    input  [31:0] pwrbus_ram_pd
);

//////////////////////////////////////////////////////////////////
 wire [67 -1:0] cdp_dp2wdma_pd;
 wire cdp_dp2wdma_ready;
 wire cdp_dp2wdma_valid;
 wire [67 -1:0] cdp_rdma2dp_pd;
 wire cdp_rdma2dp_ready;
 wire cdp_rdma2dp_valid;
 wire [31:0] dp2reg_d0_out_saturation;
 wire [31:0] dp2reg_d0_perf_lut_hybrid;
 wire [31:0] dp2reg_d0_perf_lut_le_hit;
 wire [31:0] dp2reg_d0_perf_lut_lo_hit;
 wire [31:0] dp2reg_d0_perf_lut_oflow;
 wire [31:0] dp2reg_d0_perf_lut_uflow;
 wire [31:0] dp2reg_d0_perf_write_stall;
 wire [31:0] dp2reg_d1_out_saturation;
 wire [31:0] dp2reg_d1_perf_lut_hybrid;
 wire [31:0] dp2reg_d1_perf_lut_le_hit;
 wire [31:0] dp2reg_d1_perf_lut_lo_hit;
 wire [31:0] dp2reg_d1_perf_lut_oflow;
 wire [31:0] dp2reg_d1_perf_lut_uflow;
 wire [31:0] dp2reg_d1_perf_write_stall;
 wire dp2reg_done;
 wire [31:0] dp2reg_inf_input_num;
 wire [15:0] dp2reg_lut_data;
 wire [31:0] dp2reg_nan_input_num;
 wire mon_op_en_neg;
 wire mon_op_en_pos;
 wire [1*8 +24:0] nan_preproc_pd;
 wire nan_preproc_prdy;
 wire nan_preproc_pvld;
 wire nvdla_op_gated_clk_core;
 wire nvdla_op_gated_clk_wdma;
 wire [31:0] reg2dp_cya;
 wire [15:0] reg2dp_datin_offset;
 wire [15:0] reg2dp_datin_scale;
 wire [4:0] reg2dp_datin_shifter;
 wire [31:0] reg2dp_datout_offset;
 wire [15:0] reg2dp_datout_scale;
 wire [5:0] reg2dp_datout_shifter;
 wire reg2dp_dma_en;
 wire [31:0] reg2dp_dst_base_addr_high;
 wire [31:0] reg2dp_dst_base_addr_low;
 wire [31:0] reg2dp_dst_line_stride;
 wire reg2dp_dst_ram_type;
 wire [31:0] reg2dp_dst_surface_stride;
 wire reg2dp_interrupt_ptr;
 wire reg2dp_lut_access_type;
 wire [9:0] reg2dp_lut_addr;
 wire [15:0] reg2dp_lut_data;
 wire reg2dp_lut_data_trigger;
 wire reg2dp_lut_en;
 wire reg2dp_lut_hybrid_priority;
 wire [5:0] reg2dp_lut_le_end_high;
 wire [31:0] reg2dp_lut_le_end_low;
 wire reg2dp_lut_le_function;
 wire [7:0] reg2dp_lut_le_index_offset;
 wire [7:0] reg2dp_lut_le_index_select;
 wire [15:0] reg2dp_lut_le_slope_oflow_scale;
 wire [4:0] reg2dp_lut_le_slope_oflow_shift;
 wire [15:0] reg2dp_lut_le_slope_uflow_scale;
 wire [4:0] reg2dp_lut_le_slope_uflow_shift;
 wire [5:0] reg2dp_lut_le_start_high;
 wire [31:0] reg2dp_lut_le_start_low;
 wire [5:0] reg2dp_lut_lo_end_high;
 wire [31:0] reg2dp_lut_lo_end_low;
 wire [7:0] reg2dp_lut_lo_index_select;
 wire [15:0] reg2dp_lut_lo_slope_oflow_scale;
 wire [4:0] reg2dp_lut_lo_slope_oflow_shift;
 wire [15:0] reg2dp_lut_lo_slope_uflow_scale;
 wire [4:0] reg2dp_lut_lo_slope_uflow_shift;
 wire [5:0] reg2dp_lut_lo_start_high;
 wire [31:0] reg2dp_lut_lo_start_low;
 wire reg2dp_lut_oflow_priority;
 wire reg2dp_lut_table_id;
 wire reg2dp_lut_uflow_priority;
 wire reg2dp_mul_bypass;
 wire reg2dp_nan_to_zero;
 wire [1:0] reg2dp_normalz_len;
 wire reg2dp_op_en;
 wire reg2dp_sqsum_bypass;
 wire [3:0] slcg_op_en;
 reg [31:0] mon_gap_between_layers;
 reg mon_layer_end_flg;
 reg mon_op_en_dly;
 reg mon_reg2dp_lut_le_function;
 reg mon_reg2dp_mul_bypass;
 reg mon_reg2dp_nan_to_zero;
 reg [1:0] mon_reg2dp_normalz_len;
 reg mon_reg2dp_sqsum_bypass;
//////////////////////////////////////////////////////////////////
//=======================================
//RDMA
//---------------------------------------
 NV_NVDLA_CDP_rdma u_rdma (
    .nvdla_core_clk (nvdla_core_clk)
   ,.nvdla_core_rstn (nvdla_core_rstn)
   ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2mcif_rd_cdt_lat_fifo_pop)
   ,.cdp2mcif_rd_req_valid (cdp2mcif_rd_req_valid)
   ,.cdp2mcif_rd_req_ready (cdp2mcif_rd_req_ready)
   ,.cdp2mcif_rd_req_pd (cdp2mcif_rd_req_pd)
   ,.cdp_rdma2csb_resp_valid (cdp_rdma2csb_resp_valid)
   ,.cdp_rdma2csb_resp_pd (cdp_rdma2csb_resp_pd[33:0])
   ,.cdp_rdma2dp_valid (cdp_rdma2dp_valid)
   ,.cdp_rdma2dp_ready (cdp_rdma2dp_ready)
   ,.cdp_rdma2dp_pd (cdp_rdma2dp_pd)
   ,.csb2cdp_rdma_req_pvld (csb2cdp_rdma_req_pvld)
   ,.csb2cdp_rdma_req_prdy (csb2cdp_rdma_req_prdy)
   ,.csb2cdp_rdma_req_pd (csb2cdp_rdma_req_pd[62:0])
   ,.mcif2cdp_rd_rsp_valid (mcif2cdp_rd_rsp_valid)
   ,.mcif2cdp_rd_rsp_ready (mcif2cdp_rd_rsp_ready)
   ,.mcif2cdp_rd_rsp_pd (mcif2cdp_rd_rsp_pd)
   ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
   // ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
   // ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
   // ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
   );
//=======================================
// SLCG gen unit
//---------------------------------------
//  NV_NVDLA_CDP_slcg u_slcg_core (
//     .dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
//    ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
//    ,.nvdla_core_clk (nvdla_core_clk)
//    ,.nvdla_core_rstn (nvdla_core_rstn)
//    ,.slcg_en_src (slcg_op_en[0])
//    ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
//    ,.nvdla_core_gated_clk (nvdla_op_gated_clk_core)
//    );
//  NV_NVDLA_CDP_slcg u_slcg_wdma (
//     .dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
//    ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
//    ,.nvdla_core_clk (nvdla_core_clk)
//    ,.nvdla_core_rstn (nvdla_core_rstn)
//    ,.slcg_en_src (slcg_op_en[1])
//    ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
//    ,.nvdla_core_gated_clk (nvdla_op_gated_clk_wdma)
//    );
//=======================================
//NaN preproc
//---------------------------------------
//  NV_NVDLA_CDP_DP_nan u_DP_nan (
//     .nvdla_core_clk (nvdla_op_gated_clk_core)
//    ,.nvdla_core_rstn (nvdla_core_rstn)
//    ,.cdp_rdma2dp_pd (cdp_rdma2dp_pd)
//    ,.cdp_rdma2dp_valid (cdp_rdma2dp_valid)
//    ,.dp2reg_done (dp2reg_done)
//    ,.nan_preproc_prdy (nan_preproc_prdy)
// //,.reg2dp_input_data_type (reg2dp_input_data_type[1:0])
//    ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
//    ,.reg2dp_op_en (reg2dp_op_en)
//    ,.cdp_rdma2dp_ready (cdp_rdma2dp_ready)
//    ,.dp2reg_inf_input_num (dp2reg_inf_input_num[31:0])
//    ,.dp2reg_nan_input_num (dp2reg_nan_input_num[31:0])
//    ,.nan_preproc_pd (nan_preproc_pd)
//    ,.nan_preproc_pvld (nan_preproc_pvld)
//    );
//assign nan_preproc_pd = cdp_rdma2dp_pd;
//assign nan_preproc_pvld = cdp_rdma2dp_valid;
//assign cdp_rdma2dp_ready = nan_preproc_prdy;
//assign dp2reg_inf_input_num = 32'd0;
//assign dp2reg_nan_input_num = 32'd0;
//=======================================
//WDMA
//---------------------------------------
 NV_NVDLA_CDP_wdma u_wdma (
    .nvdla_core_clk (nvdla_core_clk)
   ,.nvdla_core_rstn (nvdla_core_rstn)
   ,.cdp2mcif_wr_req_valid (cdp2mcif_wr_req_valid)
   ,.cdp2mcif_wr_req_ready (cdp2mcif_wr_req_ready)
   ,.cdp2mcif_wr_req_pd (cdp2mcif_wr_req_pd)
   ,.mcif2cdp_wr_rsp_complete (mcif2cdp_wr_rsp_complete)
   ,.cdp_dp2wdma_valid (cdp_dp2wdma_valid)
   ,.cdp_dp2wdma_ready (cdp_dp2wdma_ready)
   ,.cdp_dp2wdma_pd (cdp_dp2wdma_pd)
   ,.cdp2glb_done_intr_pd (cdp2glb_done_intr_pd[1:0])
   ,.nvdla_core_clk_orig (nvdla_core_clk)
   ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
   ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:0] )
   ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:0] )
   ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:0])
   ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
   ,.reg2dp_op_en (reg2dp_op_en)
   ,.dp2reg_done (dp2reg_done)
   );
//========================================
//CDP core instance
//----------------------------------------
NV_NVDLA_CDP_dp u_dp(
    .dp2reg_done            ( dp2reg_done           ),
    .nvdla_core_clk         ( nvdla_core_clk        ),
    .nvdla_core_rstn        ( nvdla_core_rstn       ),
    .cdp_rdma2dp_valid      ( cdp_rdma2dp_valid     ),
    .cdp_rdma2dp_ready      ( cdp_rdma2dp_ready     ),
    .cdp_rdma2dp_pd         ( cdp_rdma2dp_pd        ),
    .cdp_dp2wdma_valid      ( cdp_dp2wdma_valid     ),
    .cdp_dp2wdma_ready      ( cdp_dp2wdma_ready     ),
    .cdp_dp2wdma_pd         ( cdp_dp2wdma_pd        )
);
//=======================================
//CONFIG instance
//rdma has seperate config register, while wdma share with core
//---------------------------------------
 NV_NVDLA_CDP_reg u_reg (
    .nvdla_core_clk (nvdla_core_clk)
   ,.nvdla_core_rstn (nvdla_core_rstn)
   ,.csb2cdp_req_pd (csb2cdp_req_pd[62:0])
   ,.csb2cdp_req_pvld (csb2cdp_req_pvld)
   ,.dp2reg_done (dp2reg_done)
   ,.cdp2csb_resp_pd (cdp2csb_resp_pd[33:0])
   ,.cdp2csb_resp_valid (cdp2csb_resp_valid)
   ,.csb2cdp_req_prdy (csb2cdp_req_prdy)
   ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
   ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:0])
   ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:0])
   ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:0])
   ,.reg2dp_op_en (reg2dp_op_en)
   ,.slcg_op_en (slcg_op_en[3:0])
   );

endmodule // NV_NVDLA_cdp
