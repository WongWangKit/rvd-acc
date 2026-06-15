/////////////////////////////////////////////////
//                                             //
//   The partial products generator based on   //
//         Booth2 algorithm 16x16              //
//                                             //
/////////////////////////////////////////////////

module booth2_16_33(
	input    [32:0]  a_in,        // multiplicand
	input    [15:0]  b_in,        // multiplier
	output   [36:0]  pp0,         // partial peoduct 0
	output   [37:0]  pp1,         // partial peoduct 1
	output   [37:0]  pp2,         // partial peoduct 2
	output   [37:0]  pp3,         // partial peoduct 3
	output   [37:0]  pp4,         // partial peoduct 4
	output   [37:0]  pp5,         // partial peoduct 5
	output   [37:0]  pp6,         // partial peoduct 6
	output   [36:0]  pp7,         // partial peoduct 7
	output   [34:0]  pp8

);
	wire    [33:0] sel_data_0;
	wire    [33:0] sel_data_1;
	wire    [33:0] sel_data_2;
	wire    [33:0] sel_data_3;
	wire    [33:0] sel_data_4;
	wire    [33:0] sel_data_5;
	wire    [33:0] sel_data_6;
	wire    [33:0] sel_data_7;
	wire           sel_inv_0;
	wire           sel_inv_1;
	wire           sel_inv_2;
	wire           sel_inv_3;
	wire           sel_inv_4;
	wire           sel_inv_5;
	wire           sel_inv_6;
	wire           sel_inv_7;

	wire [2:0] part [7:0];       // part of multiplier, 0 is added at LSB 
	assign part[0] = {b_in[1:0],1'b0};
	assign part[1] = {b_in[3:1]};
	assign part[2] = {b_in[5:3]};
	assign part[3] = {b_in[7:5]};
	assign part[4] = {b_in[9:7]};
	assign part[5] = {b_in[11:9]};
	assign part[6] = {b_in[13:11]};
	assign part[7] = {b_in[15:13]};

	wire [7:0] sign;
	assign sign[0] = ((&part[0]) | ~(|part[0]))?    1 :
					 ~(b_in[1] ^ a_in[32]);
	assign sign[1] = ((&part[1]) | ~(|part[1]))?    1 :
					 ~(b_in[3] ^ a_in[32]);
	assign sign[2] = ((&part[2]) | ~(|part[2]))?    1 :
					 ~(b_in[5] ^ a_in[32]);
	assign sign[3] = ((&part[3]) | ~(|part[3]))?    1 :
					 ~(b_in[7] ^ a_in[32]);
	assign sign[4] = ((&part[4]) | ~(|part[4]))?    1 :
					 ~(b_in[9] ^ a_in[32]);
	assign sign[5] = ((&part[5]) | ~(|part[5]))?    1 :
					 ~(b_in[11] ^ a_in[32]);
	assign sign[6] = ((&part[6]) | ~(|part[6]))?    1 :
					 ~(b_in[13] ^ a_in[32]);
	assign sign[7] = ((&part[7]) | ~(|part[7]))?    1 :
					 ~(b_in[15] ^ a_in[32]);

///////////// caculate pp ////////////////
	cal_pp_16_33 pp0_cal(
		.a_in(a_in),
		.b_in(part[0]),
		.res_out(sel_data_0),
		.res_inv(sel_inv_0)
		);
	cal_pp_16_33 pp1_cal(
		.a_in(a_in),
		.b_in(part[1]),
		.res_out(sel_data_1),
		.res_inv(sel_inv_1)
		);
	cal_pp_16_33 pp2_cal(
		.a_in(a_in),
		.b_in(part[2]),
		.res_out(sel_data_2),
		.res_inv(sel_inv_2)
		);
	cal_pp_16_33 pp3_cal(
		.a_in(a_in),
		.b_in(part[3]),
		.res_out(sel_data_3),
		.res_inv(sel_inv_3)
		);
	cal_pp_16_33 pp4_cal(
		.a_in(a_in),
		.b_in(part[4]),
		.res_out(sel_data_4),
		.res_inv(sel_inv_4)
		);
	cal_pp_16_33 pp5_cal(
		.a_in(a_in),
		.b_in(part[5]),
		.res_out(sel_data_5),
		.res_inv(sel_inv_5)
		);
	cal_pp_16_33 pp6_cal(
		.a_in(a_in),
		.b_in(part[6]),
		.res_out(sel_data_6),
		.res_inv(sel_inv_6)
		);
	cal_pp_16_33 pp7_cal(
		.a_in(a_in),
		.b_in(part[7]),
		.res_out(sel_data_7),
		.res_inv(sel_inv_7)
		);


	assign pp0 = {sign[0],~sign[0],~sign[0], sel_data_0};
	assign pp1 = {1'b1, sign[1], sel_data_1, 1'b0, sel_inv_0};
	assign pp2 = {1'b1, sign[2], sel_data_2, 1'b0, sel_inv_1};
	assign pp3 = {1'b1, sign[3], sel_data_3, 1'b0, sel_inv_2};
	// assign pp4 = {17'b0, sel_inv_3, 6'b0};

	assign pp4 = {1'b1, sign[4], sel_data_4, 1'b0, sel_inv_3};
	assign pp5 = {1'b1, sign[5], sel_data_5, 1'b0, sel_inv_4};
	assign pp6 = {1'b1, sign[6], sel_data_6, 1'b0, sel_inv_5};
	assign pp7 = {sign[7], sel_data_7, 1'b0, sel_inv_6};
	assign pp8 = {34'b0, sel_inv_7};

endmodule