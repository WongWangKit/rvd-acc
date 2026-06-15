// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_wdma.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_define.h
///////////////////////////////////////////////////
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_CDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_CDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
`include "simulate_x_tick.vh"
module NV_NVDLA_CDP_wdma (
   nvdla_core_clk
  ,nvdla_core_clk_orig
  ,nvdla_core_rstn
  ,cdp2mcif_wr_req_ready
  ,cdp_dp2wdma_pd
  ,cdp_dp2wdma_valid
  ,mcif2cdp_wr_rsp_complete
  ,pwrbus_ram_pd
  ,reg2dp_dst_base_addr_high
  ,reg2dp_dst_base_addr_low
  ,reg2dp_dst_line_stride
  ,reg2dp_dst_surface_stride
  ,reg2dp_op_en
  ,cdp2glb_done_intr_pd
  ,cdp2mcif_wr_req_pd
  ,cdp2mcif_wr_req_valid
  ,cdp_dp2wdma_ready
  ,dp2reg_done
  );
////////////////////////////////////////////////////////////////////////////
//
input nvdla_core_clk;
input nvdla_core_rstn;
output cdp2mcif_wr_req_valid;
input cdp2mcif_wr_req_ready;
output [66 -1:0] cdp2mcif_wr_req_pd;
input mcif2cdp_wr_rsp_complete;
input cdp_dp2wdma_valid;
output cdp_dp2wdma_ready;
input [67 -1:0] cdp_dp2wdma_pd;
output [1:0] cdp2glb_done_intr_pd;
input nvdla_core_clk_orig;
input [31:0] pwrbus_ram_pd;
input [31:0] reg2dp_dst_base_addr_high;
input [31:0] reg2dp_dst_base_addr_low;
input [31:0] reg2dp_dst_line_stride;
input [31:0] reg2dp_dst_surface_stride;
input reg2dp_op_en;
output dp2reg_done;
////////////////////////////////////////////////////////////////////////////
reg ack_bot_id;
reg ack_bot_vld;
reg ack_top_id;
reg ack_top_vld;
reg [63:0] base_addr_c;
reg [63:0] base_addr_w;
reg [2:0] beat_cnt;
reg [1:0] cdp2glb_done_intr_pd;
reg [31:0] cdp_wr_stall_count;
reg cmd_en;
reg [2:0] cmd_fifo_rd_pos_w_reg;
reg cv_dma_wr_rsp_complete;
reg cv_pending;
reg dat_en;
reg [63:0] dma_req_addr;
wire dma_wr_rsp_complete;
reg [31:0] dp2reg_d0_perf_write_stall;
reg [31:0] dp2reg_d1_perf_write_stall;
//: my $jx = 8*8;
//: my $M = 64/$jx; ##atomic_m number per dma transaction
//: if($M == 1) { print "reg            is_beat_num_odd; \n";
//: print "wire     [0:0] dma_wr_dat_mask; \n";}
//: if($M == 2) { print "reg            is_beat_num_odd; \n";
//: print "wire     [1:0] dma_wr_dat_mask; \n";}
//: if($M == 4) { print "reg  [1:0]     is_beat_num_odd; \n";
//: print "wire     [3:0] dma_wr_dat_mask; \n";}
//: if($M == 8) { print "reg  [2:0]     is_beat_num_odd; \n";
//: print "wire     [7:0] dma_wr_dat_mask; \n";}
//: if($M == 16) { print "reg  [3:0]     is_beat_num_odd; \n";
//: print "wire    [15:0] dma_wr_dat_mask; \n";}
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg            is_beat_num_odd; 
wire     [0:0] dma_wr_dat_mask; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//reg is_beat_num_odd;
reg layer_flag;
reg mc_dma_wr_rsp_complete;
reg mc_pending;
reg mon_base_addr_c_c;
reg mon_base_addr_w_c;
reg mon_dma_req_addr_c;
reg mon_nan_in_count;
reg op_prcess;
reg reg_cube_last;
reg [4:0] req_chn_size;
reg stl_adv;
reg [31:0] stl_cnt_cur;
reg [33:0] stl_cnt_dec;
reg [33:0] stl_cnt_ext;
reg [33:0] stl_cnt_inc;
reg [33:0] stl_cnt_mod;
reg [33:0] stl_cnt_new;
reg [33:0] stl_cnt_nxt;
wire ack_bot_rdy;
wire ack_raw_id;
wire ack_raw_rdy;
wire ack_raw_vld;
wire ack_top_rdy;
wire cdp_wr_stall_count_dec;
wire cmd_accept;
wire cmd_fifo_rd_b_sync;
wire cmd_fifo_rd_b_sync_NC;
wire cmd_fifo_rd_last_c;
wire cmd_fifo_rd_last_h;
wire cmd_fifo_rd_last_w;
wire [16:0] cmd_fifo_rd_pd;
wire [4:0] cmd_fifo_rd_pos_c;
wire [3:0] cmd_fifo_rd_pos_w;
wire cmd_fifo_rd_prdy;
wire cmd_fifo_rd_pvld;
wire [3:0] cmd_fifo_rd_width;
wire [16:0] cmd_fifo_wr_pd;
wire cmd_fifo_wr_prdy;
wire cmd_fifo_wr_pvld;
wire cmd_rdy;
wire cmd_vld;
wire cnt_cen;
wire cnt_clr;
wire cnt_inc;
wire dat_accept;
wire [67 -1:0] dat_data;
wire dat_fifo_wr_rdy;
wire dat_rdy;
reg dat_vld;
wire [63:0] dma_wr_cmd_addr;
wire [32 +13:0] dma_wr_cmd_pd;
wire dma_wr_cmd_require_ack;
wire [12:0] dma_wr_cmd_size;
wire dma_wr_cmd_vld;
wire [67 -1:0] dma_wr_dat_data;
wire [66 -2:0] dma_wr_dat_pd;
reg [66 -1:0] dma_wr_req_pd;
wire dma_wr_dat_vld;
wire dma_wr_req_rdy;
wire dma_wr_req_type;
wire dma_wr_req_vld;
wire dp2wdma_b_sync;
wire [16:0] dp2wdma_cmd_pd;
wire [67 -1:0] dp2wdma_data;
wire dp2wdma_last_c;
wire dp2wdma_last_h;
wire dp2wdma_last_w;
wire [4:0] dp2wdma_pos_c;
wire [3:0] dp2wdma_pos_w;
wire dp2wdma_pos_w_bit0;
wire dp2wdma_rdy;
wire [3:0] dp2wdma_width;
wire intr_fifo_rd_pd;
wire intr_fifo_rd_prdy;
wire intr_fifo_rd_pvld;
wire intr_fifo_wr_pd;
wire intr_fifo_wr_pvld;
wire is_cube_last;
wire is_last_beat;
wire is_last_c;
wire is_last_h;
wire is_last_w;
wire op_done;
wire op_load;
wire [63:0] reg2dp_base_addr;
wire [31:0] reg2dp_line_stride;
wire [31:0] reg2dp_surf_stride;
wire releasing;
wire require_ack;
wire [3:0] width_size;
wire [3:0] width_size_use;
wire wr_req_rdyi;

wire in_fifo_full;
reg cmd_flag;
reg [28:0] cmd_cnt;
wire w_end;
wire c_end;
////////////////////////////////////////////////////////////////////////////
//==============
// Work Processing
//==============
assign op_load = reg2dp_op_en & !op_prcess;
// assign op_done = 1'b0; //reg_cube_last & is_last_beat & dat_accept;
assign dp2reg_done = op_done;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    op_prcess <= 1'b0;
  end else begin
    if (op_load) begin
        op_prcess <= 1'b1;
    end else if (op_done) begin
        op_prcess <= 1'b0;
    end
  end
end
//==============
// Data INPUT pipe and Unpack
//==============
//: my $k=64 +17;
//: &eperl::pipe(" -wid $k -is -do dp2wdma_pd -vo dp2wdma_vld -ri dp2wdma_rdy -di cdp_dp2wdma_pd -vi cdp_dp2wdma_valid -ro cdp_dp2wdma_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg cdp_dp2wdma_ready;
reg skid_flop_cdp_dp2wdma_ready;
reg skid_flop_cdp_dp2wdma_valid;
reg [67-1:0] skid_flop_cdp_dp2wdma_pd;
reg pipe_skid_cdp_dp2wdma_valid;
reg [67-1:0] pipe_skid_cdp_dp2wdma_pd;
// Wire
wire skid_cdp_dp2wdma_valid;
wire [67-1:0] skid_cdp_dp2wdma_pd;
wire skid_cdp_dp2wdma_ready;
wire pipe_skid_cdp_dp2wdma_ready;
wire dp2wdma_vld;
wire [67-1:0] dp2wdma_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdp_dp2wdma_ready <= 1'b1;
       skid_flop_cdp_dp2wdma_ready <= 1'b1;
   end else begin
       cdp_dp2wdma_ready <= skid_cdp_dp2wdma_ready;
       skid_flop_cdp_dp2wdma_ready <= skid_cdp_dp2wdma_ready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_cdp_dp2wdma_valid <= 1'b0;
    end else begin
        if (skid_flop_cdp_dp2wdma_ready) begin
            skid_flop_cdp_dp2wdma_valid <= cdp_dp2wdma_valid;
        end
   end
end
assign skid_cdp_dp2wdma_valid = (skid_flop_cdp_dp2wdma_ready) ? cdp_dp2wdma_valid : skid_flop_cdp_dp2wdma_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_cdp_dp2wdma_ready & cdp_dp2wdma_valid) begin
        skid_flop_cdp_dp2wdma_pd[67-1:0] <= cdp_dp2wdma_pd[67-1:0];
    end
end
assign skid_cdp_dp2wdma_pd[67-1:0] = (skid_flop_cdp_dp2wdma_ready) ? cdp_dp2wdma_pd[67-1:0] : skid_flop_cdp_dp2wdma_pd[67-1:0];


// PIPE READY
assign skid_cdp_dp2wdma_ready = pipe_skid_cdp_dp2wdma_ready || !pipe_skid_cdp_dp2wdma_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_cdp_dp2wdma_valid <= 1'b0;
    end else begin
        if (skid_cdp_dp2wdma_ready) begin
            pipe_skid_cdp_dp2wdma_valid <= skid_cdp_dp2wdma_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_cdp_dp2wdma_ready && skid_cdp_dp2wdma_valid) begin
        pipe_skid_cdp_dp2wdma_pd[67-1:0] <= skid_cdp_dp2wdma_pd[67-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_cdp_dp2wdma_ready = dp2wdma_rdy;
assign dp2wdma_vld = pipe_skid_cdp_dp2wdma_valid;
assign dp2wdma_pd = pipe_skid_cdp_dp2wdma_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp2wdma_data[67 -1:0] = dp2wdma_pd[67 -1:0];

assign dp2wdma_rdy = dp2wdma_vld & !in_fifo_full; //& (dp2wdma_b_sync ? (dat_fifo_wr_rdy & cmd_fifo_wr_prdy) : dat_fifo_wr_rdy);
//==============
// Input FIFO : DATA and its swizzle
//==============
wire in_fifo_empty;
wire dat_vld_w;

assign dat_vld_w = dat_en & dma_wr_req_rdy & !in_fifo_empty;
syncFIFO # (
    .DATA_WIDTH     (67                         ),
    .ADDR_WIDTH     (4                          ),
    .RAM_STYLE      (                           ),
    .FWFT_EN        (1                          )
) syncFIFO_u0 (
    .din            (dp2wdma_data               ),
    .wr_en          (dp2wdma_vld & dp2wdma_rdy  ),
    .full           (in_fifo_full               ),
    .almost_full    (                           ),
    .dout           (dat_data                   ),
    .rd_en          (dat_vld_w                  ),
    .empty          (in_fifo_empty              ),
    .almost_empty   (                           ),
    .clk            (nvdla_core_clk             ),
    .rst            (~nvdla_core_rstn           )
);

always@ (posedge nvdla_core_clk) begin
    dat_vld <= dat_vld_w;
end

// wire           dat0_vld; 
// //wire           dat0_rdy; 
// assign dat0_vld  = dat_en & dp2wdma_vld; //dat0_fifo_rd_pvld & !(is_last_beat & (is_beat_num_odd < 0)); 
// assign dat0_rdy  = dat_en & dat_rdy & !(is_last_beat & (is_beat_num_odd < 0)); 


// assign dat_rdy = dat_en & dma_wr_req_rdy;
assign dat_accept = dat_vld_w;// & dat_rdy;
assign cmd_accept = cmd_en & dma_wr_req_rdy;
assign cmd_vld = cmd_accept;

reg is_last;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmd_en <= 1'b0;
    dat_en <= 1'b0;
  end else begin
    if (dp2reg_done) begin
        cmd_en <= 1'b0;
        dat_en <= 1'b0;
    end else if (op_load || (is_last && dat_accept)) begin
        cmd_en <= 1'b1;
        dat_en <= 1'b0;
    end else if (cmd_accept) begin
        cmd_en <= 1'b0;
        dat_en <= 1'b1;
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        is_last <= 1'b0;
    end else if (op_load) begin
        is_last <= 1'b0;
    end else if (dat_accept) begin
        is_last <= ~is_last;
    end
end


//==============
// DMA REQ: DATA
//==============
//------------------------------------
// mode: 64 || mode: 32
// clk : 0 0 1 1 || clk : 0 0 1 1
// - - - - - - - -|| - - - - - - -
// fifo: 0 4 0 4 || fifo: 0 4 0 4
// fifo: 1 5 1 5 || fifo: 1 5 1 5
// fifo: 2 6 2 6 || fifo: 2 6 2 6
// fifo: 3 7 3 7 || fifo: 3 7 3 7
// - - - - - - - -|| - - - - - - -
// bus : L-H L-H || bus : L H-L H
//------------------------------------
//==============
// DMA REQ: ADDR
//==============
// rename for reuse between rdma and wdma
assign reg2dp_base_addr = {reg2dp_dst_base_addr_high,reg2dp_dst_base_addr_low};
assign reg2dp_line_stride = reg2dp_dst_line_stride;
assign reg2dp_surf_stride = reg2dp_dst_surface_stride;
//==============
// DMA Req : ADDR : Prepration
// DMA Req: go through the CUBE: W8->C->H
//==============
// Width: need be updated when move to next line
// Trigger Condition: (is_last_c & is_last_w)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        {mon_base_addr_w_c,base_addr_w} <= {65{1'b0}};
    end else begin
        if (op_load) begin
            base_addr_w <= reg2dp_base_addr + 32'd16;
        end else if (w_end) begin
            {mon_base_addr_w_c,base_addr_w} <= base_addr_w + reg2dp_line_stride[31:0] + 32'd16;
        end else if (c_end) begin
            {mon_base_addr_w_c,base_addr_w} <= base_addr_w + 32'd16;
        end
        // end
    end
end

// base_Chn: need be updated when move to next w.group
// Trigger Condition: (is_last_c)
// 1, jump to next line when is_last_w
// 2, jump to next w.group when !is_last_w
assign width_size_use[3:0] = width_size + 1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    base_addr_c <= {64{1'b0}};
    {mon_base_addr_c_c,base_addr_c} <= {65{1'b0}};
  end else begin
    if (op_load) begin
        base_addr_c <= reg2dp_base_addr + reg2dp_surf_stride;
    end else if (c_end) begin
        if (w_end) begin
            {mon_base_addr_c_c,base_addr_c} <= base_addr_w + reg2dp_surf_stride + reg2dp_line_stride;
        end else begin
            {mon_base_addr_c_c,base_addr_c} <= base_addr_w + reg2dp_surf_stride;
        end
    end else if (cmd_accept && cmd_flag == 1'b1) begin
        // if (c_end) begin
        //     {mon_base_addr_c_c,base_addr_c} <= base_addr_w;
        // end else begin
            {mon_base_addr_c_c,base_addr_c} <= base_addr_c + reg2dp_surf_stride;
        // end
    end
  end
end

//==============
// DMA Req : ADDR : Generation
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dma_req_addr <= {64{1'b0}};
    {mon_dma_req_addr_c,dma_req_addr} <= {65{1'b0}};
  end else begin
    if (op_load) begin
        dma_req_addr <= reg2dp_base_addr;
    end else if (cmd_accept) begin
        // if (w_end) begin
        //     {mon_dma_req_addr_c,dma_req_addr} <= base_addr_w;
        if (cmd_flag == 1'b1) begin
            {mon_dma_req_addr_c,dma_req_addr} <= base_addr_c;
        end else begin
            {mon_dma_req_addr_c,dma_req_addr} <= dma_req_addr + reg2dp_line_stride;
        end
    end else if (c_end) begin
        if (w_end) begin
            {mon_dma_req_addr_c,dma_req_addr} <= base_addr_w + reg2dp_line_stride[31:0];
        end else begin
            {mon_dma_req_addr_c,dma_req_addr} <= base_addr_w;
        end
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cmd_flag <= 1'b0;
    end else if (op_load) begin
        cmd_flag <= 1'b0;
    end else if (cmd_accept) begin
        cmd_flag <= ~cmd_flag;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cmd_cnt <= 'b0;
    end else if (op_load || (cmd_accept && w_end)) begin
        cmd_cnt <= 'b0;
    end else if (cmd_accept) begin
        cmd_cnt <= cmd_cnt + 1'b1;
    end
end
// assign w_end = cmd_cnt == reg2dp_line_stride[31:3] - 1'b1;

assign dma_wr_cmd_vld = cmd_vld;
assign dma_wr_cmd_addr = dma_req_addr;
assign dma_wr_cmd_size = 13'd1;
assign dma_wr_cmd_require_ack = 1'b0;
// PKT_PACK_WIRE( dma_write_cmd , dma_wr_cmd_ , dma_wr_cmd_pd )
assign dma_wr_cmd_pd[32 -1:0] = dma_wr_cmd_addr[32 -1:0];
assign dma_wr_cmd_pd[32 +12:32] = dma_wr_cmd_size[12:0];
assign dma_wr_cmd_pd[32 +13] = dma_wr_cmd_require_ack ;
// packet: data
assign dma_wr_dat_vld = dat_vld_w;
assign dma_wr_dat_data = dat_data;

assign dma_wr_dat_mask = 1'b1; 
assign       dma_wr_dat_pd[64-1:0] =     dma_wr_dat_data[64-1:0]; 
assign       dma_wr_dat_pd[64+1-1:64] =     dma_wr_dat_mask[1-1:0]; 
assign op_done = dma_wr_dat_vld & dma_wr_dat_data[64];
assign w_end = dma_wr_dat_vld & dma_wr_dat_data[65];
assign c_end = dma_wr_dat_vld & dma_wr_dat_data[66];
//============================
// pack cmd & dat
assign dma_wr_req_vld = dma_wr_cmd_vld | dma_wr_dat_vld;

always @(*) begin
// init to 0
    dma_wr_req_pd = 0;
// cmd or dat
    if (cmd_en) begin
        dma_wr_req_pd = {{(66 -32 -14){1'b0}},dma_wr_cmd_pd};
    end else begin
        dma_wr_req_pd = {1'b0,dma_wr_dat_pd};
    end

    dma_wr_req_pd[64+1] = cmd_en ? 1'd0   : 1'd1  ; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
end
//==============
// writting stall counter before DMA_if
//==============
// assign cnt_inc = 1'b1;
// assign cnt_clr = op_done;
// assign cnt_cen = (reg2dp_dma_en == 1'h1 ) & (dma_wr_req_vld & (~dma_wr_req_rdy));
//     assign cdp_wr_stall_count_dec = 1'b0;
// // stl adv logic
//     always @(
//       cnt_inc
//       or cdp_wr_stall_count_dec
//       ) begin
//       stl_adv = cnt_inc ^ cdp_wr_stall_count_dec;
//     end
// // stl cnt logic
//     always @(
//       stl_cnt_cur
//       or cnt_inc
//       or cdp_wr_stall_count_dec
//       or stl_adv
//       or cnt_clr
//       ) begin
// // VCS sop_coverage_off start
//       stl_cnt_ext[33:0] = {1'b0, 1'b0, stl_cnt_cur};
//       stl_cnt_inc[33:0] = stl_cnt_cur + 1'b1; // spyglass disable W164b
//       stl_cnt_dec[33:0] = stl_cnt_cur - 1'b1; // spyglass disable W164b
//       stl_cnt_mod[33:0] = (cnt_inc && !cdp_wr_stall_count_dec)? stl_cnt_inc : (!cnt_inc && cdp_wr_stall_count_dec)? stl_cnt_dec : stl_cnt_ext;
//       stl_cnt_new[33:0] = (stl_adv)? stl_cnt_mod[33:0] : stl_cnt_ext[33:0];
//       stl_cnt_nxt[33:0] = (cnt_clr)? 34'd0 : stl_cnt_new[33:0];
// // VCS sop_coverage_off end
//     end
// // stl flops
//     always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//       if (!nvdla_core_rstn) begin
//         stl_cnt_cur[31:0] <= 0;
//       end else begin
//       if (cnt_cen) begin
//       stl_cnt_cur[31:0] <= stl_cnt_nxt[31:0];
//       end
//       end
//     end
// // stl output logic
//     always @(
//       stl_cnt_cur
//       ) begin
//       cdp_wr_stall_count[31:0] = stl_cnt_cur[31:0];
//     end
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//   if (!nvdla_core_rstn) begin
//     layer_flag <= 1'b0;
//   end else begin
//   if ((cnt_clr) == 1'b1) begin
//     layer_flag <= ~layer_flag;
//   end
//   end
// end
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//   if (!nvdla_core_rstn) begin
//     dp2reg_d0_perf_write_stall <= {32{1'b0}};
//   end else begin
//   if ((cnt_clr & (~layer_flag)) == 1'b1) begin
//     dp2reg_d0_perf_write_stall <= cdp_wr_stall_count[31:0];
//   end
//   end
// end
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//   if (!nvdla_core_rstn) begin
//     dp2reg_d1_perf_write_stall <= {32{1'b0}};
//   end else begin
//   if ((cnt_clr & layer_flag ) == 1'b1) begin
//     dp2reg_d1_perf_write_stall <= cdp_wr_stall_count[31:0];
//   end
//   end
// end
//==============
// DMA Interface
//==============
NV_NVDLA_DMAIF_wr NV_NVDLA_CDP_WDMA_wr(
   .nvdla_core_clk (nvdla_core_clk_orig )
  ,.nvdla_core_rstn (nvdla_core_rstn )
  ,.reg2dp_dst_ram_type (1'b0 )
  ,.mcif_wr_req_pd (cdp2mcif_wr_req_pd )
  ,.mcif_wr_req_valid (cdp2mcif_wr_req_valid )
  ,.mcif_wr_req_ready (cdp2mcif_wr_req_ready )
  ,.mcif_wr_rsp_complete (mcif2cdp_wr_rsp_complete)
  ,.dmaif_wr_req_pd (dma_wr_req_pd )
  ,.dmaif_wr_req_pvld (dma_wr_req_vld )
  ,.dmaif_wr_req_prdy (dma_wr_req_rdy )
  ,.dmaif_wr_rsp_complete (dma_wr_rsp_complete )
);
////////////////////////////////////////////////////////

// always @(posedge nvdla_core_clk_orig or negedge nvdla_core_rstn) begin
//   if (!nvdla_core_rstn) begin
//     cdp2glb_done_intr_pd[0] <= 1'b0;
//   end else begin
//   cdp2glb_done_intr_pd[0] <= intr_fifo_rd_pvld & intr_fifo_rd_prdy & (intr_fifo_rd_pd==0);
//   end
// end
// always @(posedge nvdla_core_clk_orig or negedge nvdla_core_rstn) begin
//   if (!nvdla_core_rstn) begin
//     cdp2glb_done_intr_pd[1] <= 1'b0;
//   end else begin
//   cdp2glb_done_intr_pd[1] <= intr_fifo_rd_pvld & intr_fifo_rd_prdy & (intr_fifo_rd_pd==1);
//   end
// end

endmodule // NV_NVDLA_CDP_wdma

