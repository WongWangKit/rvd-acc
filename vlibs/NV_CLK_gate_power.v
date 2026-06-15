// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_CLK_gate_power.v
module NV_CLK_gate_power (clk, reset_, clk_en, clk_gated);
input clk, reset_, clk_en;
output clk_gated;
`ifdef VLIB_BYPASS_POWER_CG
assign clk_gated = clk;
`else
CKLNQD12 p_clkgate (.TE(1'b0), .CP(clk), .E(clk_en), .Q(clk_gated));
`endif // VLIB_BYPASS_POWER_CG
endmodule // NV_CLK_gate
