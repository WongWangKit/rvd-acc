/////////////////////////////////////
//                                 
//        16x16 Multiplier         
//                                 
/////////////////////////////////////

module multi_16_33 (
	input	 		 clk,
	input			 rst_n,
	input    [32:0]  a_in,
	input    [15:0]  b_in,
	input            in_pvld,
	output   [48:0]  res_out,
	output   reg     res_pvld
);


//////////// partial products ////////////
wire  [36:0]  pp0,pp7;
wire  [37:0]  pp1,pp2,pp3,pp4,pp5,pp6; 
wire  [34:0]  pp8;

booth2_16_33 booth(
	.a_in(a_in),
	.b_in(b_in),
	.pp0 (pp0),
	.pp1 (pp1),
	.pp2 (pp2),
	.pp3 (pp3),
	.pp4 (pp4),
	.pp5 (pp5),
	.pp6 (pp6),
	.pp7 (pp7),
	.pp8 (pp8)
	);

reg  [36:0]  rpp0,rpp7;
reg  [37:0]  rpp1,rpp2,rpp3,rpp4,rpp5,rpp6; 
reg  [34:0]  rpp8;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rpp0 <= 'b0;
		rpp1 <= 'b0;
		rpp2 <= 'b0;
		rpp3 <= 'b0;
		rpp4 <= 'b0;
		rpp5 <= 'b0;
		rpp6 <= 'b0;
		rpp7 <= 'b0;
		rpp8 <= 'b0;
		
	end	else if (in_pvld) begin
		rpp0 <= pp0;
		rpp1 <= pp1;
		rpp2 <= pp2;
		rpp3 <= pp3;
		rpp4 <= pp4;
		rpp5 <= pp5;
		rpp6 <= pp6;
		rpp7 <= pp7;
		rpp8 <= pp8;
		
	end else begin
		rpp0 <= rpp0;
		rpp1 <= rpp1;
		rpp2 <= rpp2;
		rpp3 <= rpp3;
		rpp4 <= rpp4;
		rpp5 <= rpp5;
		rpp6 <= rpp6;
		rpp7 <= rpp7;
		rpp8 <= rpp8;
	end
end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		res_pvld <= 'b0;
	end else begin
		res_pvld <= in_pvld;
	end
end

///////////// wallace tree ////////////////
wire [48:0] adda;
wire [48:0] addb;


wallace_16_33 tree(
	.pp0 (rpp0),
	.pp1 (rpp1),
	.pp2 (rpp2),
	.pp3 (rpp3),
	.pp4 (rpp4),
	.pp5 (rpp5),
	.pp6 (rpp6),
	.pp7 (rpp7),
	.pp8 (rpp8),
	.adda(adda),
	.addb(addb)
	);

// wire [5*25-1:0] pp_in_l0n0 = {rpp4, rpp3, rpp2, rpp1, rpp0};
// wire [5*25-1:0] pp_in_l0n1 = {rpp9, rpp8, rpp7, rpp6, rpp5};
// wire [24:0] pp_out_l0n0_0;
// wire [24:0] pp_out_l0n0_1;
// wire [24:0] pp_out_l0n1_0;
// wire [24:0] pp_out_l0n1_1;

// NV_DW02_tree #(5, 25) u_tree_l0n0 (
// 	.INPUT    (pp_in_l0n0)   //|< r
// 	,.OUT0     (pp_out_l0n0_0[24:0]) //|> w
// 	,.OUT1     (pp_out_l0n0_1[24:0]) //|> w
// );
// NV_DW02_tree #(5, 25) u_tree_l0n1 (
// 	.INPUT    (pp_in_l0n1)   //|< r
// 	,.OUT0     (pp_out_l0n1_0[24:0]) //|> w
// 	,.OUT1     (pp_out_l0n1_1[24:0]) //|> w
// );

// wire [4*33-1:0] pp_in_l1n0 = 

// NV_DW02_tree #(4, 32) u_tree_l1n0 (
//    .INPUT    (pp_in_l1n0[127:0])   //|< r
//   ,.OUT0     (pp_out_l1n0_0[31:0]) //|> w
//   ,.OUT1     (pp_out_l1n0_1[31:0]) //|> w
//   );

///////////// 32+32 adder ////////////////

	wire [48:0] res_adda;
	
	adder49 adder(
		.a(adda),
		.b(addb),
		.sum(res_adda),
		.cout()
		);

	assign res_out = res_adda;

endmodule