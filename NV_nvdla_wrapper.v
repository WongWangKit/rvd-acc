`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2021 12:14:52 PM
// Design Name: 
// Module Name: NV_nvdla_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module NV_nvdla_wrapper(
    input core_clk,
    input csb_clk,
    input rstn,
    input csb_rstn,

    output dla_intr,
    // dbb AXI
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWVALID" *)
    output nvdla_core2dbb_aw_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWREADY" *)
    input nvdla_core2dbb_aw_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWID" *)
    output [7:0] nvdla_core2dbb_aw_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWLEN" *)
    output [3:0] nvdla_core2dbb_aw_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWSIZE" *)
    output [2:0] nvdla_core2dbb_aw_awsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWADDR" *)
    output [32 -1:0] nvdla_core2dbb_aw_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WVALID" *)
    output nvdla_core2dbb_w_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WREADY" *)
    input nvdla_core2dbb_w_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WDATA" *)
    output [64 -1:0] nvdla_core2dbb_w_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WSTRB" *)
    output [64/8-1:0] nvdla_core2dbb_w_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WLAST" *)
    output nvdla_core2dbb_w_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARVALID" *)
    output nvdla_core2dbb_ar_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARREADY" *)
    input nvdla_core2dbb_ar_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARID" *)
    output [7:0] nvdla_core2dbb_ar_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARLEN" *)
    output [3:0] nvdla_core2dbb_ar_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARSIZE" *)
    output [2:0] nvdla_core2dbb_ar_arsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARADDR" *)
    output [32 -1:0] nvdla_core2dbb_ar_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BVALID" *)
    input nvdla_core2dbb_b_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BREADY" *)
    output nvdla_core2dbb_b_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BID" *)
    input [7:0] nvdla_core2dbb_b_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RVALID" *)
    input nvdla_core2dbb_r_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RREADY" *)
    output nvdla_core2dbb_r_rready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RID" *)
    input [7:0] nvdla_core2dbb_r_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RLAST" *)
    input nvdla_core2dbb_r_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RDATA" *)
    input [64 -1:0] nvdla_core2dbb_r_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWBURST" *)
    output [1:0] m_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWLOCK" *)
    output  m_axi_awlock, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWCACHE" *)
    output [3:0] m_axi_awcache,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWPROT" *)
    output [2:0] m_axi_awprot, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWQOS" *)
    output [3:0] m_axi_awqos,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWUSER" *)
    output  m_axi_awuser, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WUSER" *)
    output  m_axi_wuser,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BRESP" *)
    input  [1:0] m_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BUSER" *)
    input   m_axi_buser,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARBURST" *)
    output [1:0] m_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARLOCK" *)
    output  m_axi_arlock, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARCACHE" *)
    output [3:0] m_axi_arcache,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARPROT" *)
    output [2:0] m_axi_arprot, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARQOS" *)
    output [3:0] m_axi_arqos,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARUSER" *)
    output  m_axi_aruser, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RRESP" *)
    input  [1:0] m_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RUSER" *)
    input   m_axi_ruser,

    // cfg AXI
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *)
    input s_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *)
    output s_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *)
    input [31:0] s_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWID" *)
    input [3:0] s_axi_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN" *)
    input [7:0] s_axi_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *)
    input [1:0] s_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *)
    input s_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *)
    output s_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *)
    input [31:0] s_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *)
    input [3:0] s_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST" *)
    input s_axi_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *)
    output s_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *)
    input s_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *)
    output [1:0] s_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID" *)
    output [3:0] s_axi_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *)
    input s_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *)
    output s_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *)
    input [31:0] s_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARID" *)
    input [3:0] s_axi_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN" *)
    input [7:0] s_axi_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *)
    input [1:0] s_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *)
    output s_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *)
    input s_axi_rready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *)
    output [31:0] s_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *)
    output [1:0] s_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID" *)
    output [3:0] s_axi_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST" *)
    output s_axi_rlast
    );

    wire        m_csb2nvdla_valid;
    wire        m_csb2nvdla_ready;
    wire [15:0] m_csb2nvdla_addr;
    wire [31:0] m_csb2nvdla_wdat;
    wire        m_csb2nvdla_write;
    wire        m_csb2nvdla_nposted;
    wire        m_nvdla2csb_valid;
    wire [31:0] m_nvdla2csb_data;
    wire        m_nvdla2csb_wr_complete;


    NV_NVDLA_axi2csb axi2csb (
        .clk_i                  (csb_clk)
        ,.rst_n_i               (csb_rstn)
        ,.axi_awvalid_i         (s_axi_awvalid)
        ,.axi_awaddr_i          (s_axi_awaddr)
        ,.axi_awid_i            (s_axi_awid)
        ,.axi_awlen_i           (s_axi_awlen)
        ,.axi_awburst_i         (s_axi_awburst)
        ,.axi_wvalid_i          (s_axi_wvalid)
        ,.axi_wdata_i           (s_axi_wdata)
        ,.axi_wstrb_i           (s_axi_wstrb)
        ,.axi_wlast_i           (s_axi_wlast)
        ,.axi_bready_i          (s_axi_bready)
        ,.axi_arvalid_i         (s_axi_arvalid)
        ,.axi_araddr_i          (s_axi_araddr)
        ,.axi_arid_i            (s_axi_arid)
        ,.axi_arlen_i           (s_axi_arlen)
        ,.axi_arburst_i         (s_axi_arburst)
        ,.axi_rready_i          (s_axi_rready)
        ,.axi_awready_o         (s_axi_awready)
        ,.axi_wready_o          (s_axi_wready)
        ,.axi_bvalid_o          (s_axi_bvalid)
        ,.axi_bresp_o           (s_axi_bresp)
        ,.axi_bid_o             (s_axi_bid)
        ,.axi_arready_o         (s_axi_arready)
        ,.axi_rvalid_o          (s_axi_rvalid)
        ,.axi_rdata_o           (s_axi_rdata)
        ,.axi_rresp_o           (s_axi_rresp)
        ,.axi_rid_o             (s_axi_rid)
        ,.axi_rlast_o           (s_axi_rlast)
        ,.csb2nvdla_ready       (m_csb2nvdla_ready)
        ,.nvdla2csb_data        (m_nvdla2csb_data)
        ,.nvdla2csb_valid       (m_nvdla2csb_valid)
        ,.nvdla2csb_wr_complete (m_nvdla2csb_wr_complete)
        ,.csb2nvdla_addr        (m_csb2nvdla_addr)
        ,.csb2nvdla_nposted     (m_csb2nvdla_nposted)
        ,.csb2nvdla_valid       (m_csb2nvdla_valid)
        ,.csb2nvdla_wdat        (m_csb2nvdla_wdat)
        ,.csb2nvdla_write       (m_csb2nvdla_write)
    );


    NV_nvdla nvdla_top (
        .dla_core_clk                    (core_clk)
        ,.dla_csb_clk                     (csb_clk)
        ,.global_clk_ovr_on               (1'b0)
        ,.tmc2slcg_disable_clock_gating   (1'b1)
        ,.dla_reset_rstn                  (rstn)
        ,.direct_reset_                   (1'b1)
        ,.test_mode                       (1'b0)
        ,.csb2nvdla_valid                 (m_csb2nvdla_valid)
        ,.csb2nvdla_ready                 (m_csb2nvdla_ready)
        ,.csb2nvdla_addr                  (m_csb2nvdla_addr)
        ,.csb2nvdla_wdat                  (m_csb2nvdla_wdat)
        ,.csb2nvdla_write                 (m_csb2nvdla_write)
        ,.csb2nvdla_nposted               (m_csb2nvdla_nposted)
        ,.nvdla2csb_valid                 (m_nvdla2csb_valid)
        ,.nvdla2csb_data                  (m_nvdla2csb_data)
        ,.nvdla2csb_wr_complete           (m_nvdla2csb_wr_complete)
        ,.nvdla_core2dbb_aw_awvalid       (nvdla_core2dbb_aw_awvalid)
        ,.nvdla_core2dbb_aw_awready       (nvdla_core2dbb_aw_awready)
        ,.nvdla_core2dbb_aw_awaddr        (nvdla_core2dbb_aw_awaddr)
        ,.nvdla_core2dbb_aw_awid          (nvdla_core2dbb_aw_awid)
        ,.nvdla_core2dbb_aw_awlen         (nvdla_core2dbb_aw_awlen)
        ,.nvdla_core2dbb_w_wvalid         (nvdla_core2dbb_w_wvalid)
        ,.nvdla_core2dbb_w_wready         (nvdla_core2dbb_w_wready)
        ,.nvdla_core2dbb_w_wdata          (nvdla_core2dbb_w_wdata)
        ,.nvdla_core2dbb_w_wstrb          (nvdla_core2dbb_w_wstrb)
        ,.nvdla_core2dbb_w_wlast          (nvdla_core2dbb_w_wlast)
        ,.nvdla_core2dbb_b_bvalid         (nvdla_core2dbb_b_bvalid)
        ,.nvdla_core2dbb_b_bready         (nvdla_core2dbb_b_bready)
        ,.nvdla_core2dbb_b_bid            (nvdla_core2dbb_b_bid)
        ,.nvdla_core2dbb_ar_arvalid       (nvdla_core2dbb_ar_arvalid)
        ,.nvdla_core2dbb_ar_arready       (nvdla_core2dbb_ar_arready)
        ,.nvdla_core2dbb_ar_araddr        (nvdla_core2dbb_ar_araddr)
        ,.nvdla_core2dbb_ar_arid          (nvdla_core2dbb_ar_arid)
        ,.nvdla_core2dbb_ar_arlen         (nvdla_core2dbb_ar_arlen)
        ,.nvdla_core2dbb_r_rvalid         (nvdla_core2dbb_r_rvalid)
        ,.nvdla_core2dbb_r_rready         (nvdla_core2dbb_r_rready)
        ,.nvdla_core2dbb_r_rid            (nvdla_core2dbb_r_rid)
        ,.nvdla_core2dbb_r_rlast          (nvdla_core2dbb_r_rlast)
        ,.nvdla_core2dbb_r_rdata          (nvdla_core2dbb_r_rdata)
        ,.dla_intr                        (dla_intr)
        ,.nvdla_pwrbus_ram_c_pd           (32'b0)
        ,.nvdla_pwrbus_ram_ma_pd          (32'b0)
        ,.nvdla_pwrbus_ram_mb_pd          (32'b0)
        ,.nvdla_pwrbus_ram_p_pd           (32'b0)
        ,.nvdla_pwrbus_ram_o_pd           (32'b0)
        ,.nvdla_pwrbus_ram_a_pd           (32'b0)
    ); // nvdla_top

assign nvdla_core2dbb_aw_awsize = 3'b011;
assign nvdla_core2dbb_ar_arsize = 3'b011;

assign m_axi_awburst = 2'b01;
assign m_axi_awlock  = 1'b0;
assign m_axi_awcache = 4'b0010;
assign m_axi_awprot  = 3'h0;
assign m_axi_awqos   = 4'h0;
assign m_axi_awuser  = 'b1;
assign m_axi_wuser   = 'b0;
assign m_axi_arburst = 2'b01;
assign m_axi_arlock  = 1'b0;
assign m_axi_arcache = 4'b0010;
assign m_axi_arprot  = 3'h0;
assign m_axi_arqos   = 4'h0;
assign m_axi_aruser  = 'b1;

endmodule
