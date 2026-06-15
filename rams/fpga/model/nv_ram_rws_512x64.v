// `define SRAM
module nv_ram_rws_512x64 (
  clk,
  ra,
  re,
  dout,
  wa,
  we,
  di,
  pwrbus_ram_pd
);
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
// port list
input clk;
input [8:0] ra;
input re;
output [63:0] dout;
input [8:0] wa;
input we;
input [63:0] di;
input [31:0] pwrbus_ram_pd;

`ifndef SRAM

reg [8:0] ra_d;
wire [63:0] dout;
reg [63:0] M [511:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
    else if (re)
       ra_d <= ra;
end

assign dout = M[ra_d];

`else

wire cen = ~(re|we);
wire [63:0] wen = {64{~we}};
wire [8:0] a = we ? wa : re ? ra : 9'b0;

sram_64_512 u_sram_0(
  .Q			  ( dout ), 
  .CLK		  ( clk ), 
  .CEN		  ( cen ), 
  .WEN		  ( wen ), 
  .A			  ( a ), 
  .D			  ( di ),
  .EMA		  ( 3'd3 ), 
  .EMAW     ( 2'b1 ), 
  .EMAS 	  ( 1'b0 ),
  .GWEN 	  ( 1'b1 ), 
  .RET1N	  ( 1'b1 )
);

`endif

endmodule
