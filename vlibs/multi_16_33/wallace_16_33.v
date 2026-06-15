/////////////////////////////////////
//                                 
//       16x16 Wallace Tree         
//                                 
/////////////////////////////////////

module wallace_16_33 (
	input    [36:0] pp0,
	input    [37:0] pp1,
	input    [37:0] pp2,
	input    [37:0] pp3,
	input    [37:0] pp4,
	input    [37:0] pp5,
	input    [37:0] pp6,
	input    [36:0] pp7,
	input    [34:0] pp8,
	output   [48:0] adda,
	output   [48:0] addb
);

///////////////// first stage ////////////////////
	wire [45:0] fir_sum_1;          // sum output of adder, layer 1
	wire [45:0] fir_cout_1;         // cout output of adder, layer 1
	fulladder firadd1_0  (.a(pp0[ 2]), .b(pp1[ 2]), .cin(pp2[ 0]), .sum(fir_sum_1[ 0]), .cout(fir_cout_1[ 0]));
	fulladder firadd1_1  (.a(pp0[ 3]), .b(pp1[ 3]), .cin(pp2[ 1]), .sum(fir_sum_1[ 1]), .cout(fir_cout_1[ 1]));
	fulladder firadd1_2  (.a(pp0[ 4]), .b(pp1[ 4]), .cin(pp2[ 2]), .sum(fir_sum_1[ 2]), .cout(fir_cout_1[ 2]));
	fulladder firadd1_3  (.a(pp0[ 5]), .b(pp1[ 5]), .cin(pp2[ 3]), .sum(fir_sum_1[ 3]), .cout(fir_cout_1[ 3]));
	fulladder firadd1_4  (.a(pp0[ 6]), .b(pp1[ 6]), .cin(pp2[ 4]), .sum(fir_sum_1[ 4]), .cout(fir_cout_1[ 4]));
	fulladder firadd1_5  (.a(pp0[ 7]), .b(pp1[ 7]), .cin(pp2[ 5]), .sum(fir_sum_1[ 5]), .cout(fir_cout_1[ 5]));
	fulladder firadd1_6  (.a(pp0[ 8]), .b(pp1[ 8]), .cin(pp2[ 6]), .sum(fir_sum_1[ 6]), .cout(fir_cout_1[ 6]));
	fulladder firadd1_7  (.a(pp0[ 9]), .b(pp1[ 9]), .cin(pp2[ 7]), .sum(fir_sum_1[ 7]), .cout(fir_cout_1[ 7]));
	fulladder firadd1_8  (.a(pp0[10]), .b(pp1[10]), .cin(pp2[ 8]), .sum(fir_sum_1[ 8]), .cout(fir_cout_1[ 8]));
	fulladder firadd1_9  (.a(pp0[11]), .b(pp1[11]), .cin(pp2[ 9]), .sum(fir_sum_1[ 9]), .cout(fir_cout_1[ 9]));
	fulladder firadd1_10 (.a(pp0[12]), .b(pp1[12]), .cin(pp2[10]), .sum(fir_sum_1[10]), .cout(fir_cout_1[10]));
	fulladder firadd1_11 (.a(pp0[13]), .b(pp1[13]), .cin(pp2[11]), .sum(fir_sum_1[11]), .cout(fir_cout_1[11]));
	fulladder firadd1_12 (.a(pp0[14]), .b(pp1[14]), .cin(pp2[12]), .sum(fir_sum_1[12]), .cout(fir_cout_1[12]));
	fulladder firadd1_13 (.a(pp0[15]), .b(pp1[15]), .cin(pp2[13]), .sum(fir_sum_1[13]), .cout(fir_cout_1[13]));
	fulladder firadd1_14 (.a(pp0[16]), .b(pp1[16]), .cin(pp2[14]), .sum(fir_sum_1[14]), .cout(fir_cout_1[14]));
	fulladder firadd1_15 (.a(pp0[17]), .b(pp1[17]), .cin(pp2[15]), .sum(fir_sum_1[15]), .cout(fir_cout_1[15]));
	fulladder firadd1_16 (.a(pp0[18]), .b(pp1[18]), .cin(pp2[16]), .sum(fir_sum_1[16]), .cout(fir_cout_1[16]));
	fulladder firadd1_17 (.a(pp0[19]), .b(pp1[19]), .cin(pp2[17]), .sum(fir_sum_1[17]), .cout(fir_cout_1[17]));
	fulladder firadd1_18 (.a(pp0[20]), .b(pp1[20]), .cin(pp2[18]), .sum(fir_sum_1[18]), .cout(fir_cout_1[18]));
	fulladder firadd1_19 (.a(pp0[21]), .b(pp1[21]), .cin(pp2[19]), .sum(fir_sum_1[19]), .cout(fir_cout_1[19]));
	fulladder firadd1_20 (.a(pp0[22]), .b(pp1[22]), .cin(pp2[20]), .sum(fir_sum_1[20]), .cout(fir_cout_1[20]));
	fulladder firadd1_21 (.a(pp0[23]), .b(pp1[23]), .cin(pp2[21]), .sum(fir_sum_1[21]), .cout(fir_cout_1[21]));
	fulladder firadd1_22 (.a(pp0[24]), .b(pp1[24]), .cin(pp2[22]), .sum(fir_sum_1[22]), .cout(fir_cout_1[22]));
	fulladder firadd1_23 (.a(pp0[25]), .b(pp1[25]), .cin(pp2[23]), .sum(fir_sum_1[23]), .cout(fir_cout_1[23]));
	fulladder firadd1_24 (.a(pp0[26]), .b(pp1[26]), .cin(pp2[24]), .sum(fir_sum_1[24]), .cout(fir_cout_1[24]));
	fulladder firadd1_25 (.a(pp0[27]), .b(pp1[27]), .cin(pp2[25]), .sum(fir_sum_1[25]), .cout(fir_cout_1[25]));
	fulladder firadd1_26 (.a(pp0[28]), .b(pp1[28]), .cin(pp2[26]), .sum(fir_sum_1[26]), .cout(fir_cout_1[26]));
	fulladder firadd1_27 (.a(pp0[29]), .b(pp1[29]), .cin(pp2[27]), .sum(fir_sum_1[27]), .cout(fir_cout_1[27]));
	fulladder firadd1_28 (.a(pp0[30]), .b(pp1[30]), .cin(pp2[28]), .sum(fir_sum_1[28]), .cout(fir_cout_1[28]));
	fulladder firadd1_29 (.a(pp0[31]), .b(pp1[31]), .cin(pp2[29]), .sum(fir_sum_1[29]), .cout(fir_cout_1[29]));
	fulladder firadd1_30 (.a(pp0[32]), .b(pp1[32]), .cin(pp2[30]), .sum(fir_sum_1[30]), .cout(fir_cout_1[30]));
	fulladder firadd1_31 (.a(pp0[33]), .b(pp1[33]), .cin(pp2[31]), .sum(fir_sum_1[31]), .cout(fir_cout_1[31]));
	fulladder firadd1_32 (.a(pp0[34]), .b(pp1[34]), .cin(pp2[32]), .sum(fir_sum_1[32]), .cout(fir_cout_1[32]));
	fulladder firadd1_33 (.a(pp0[35]), .b(pp1[35]), .cin(pp2[33]), .sum(fir_sum_1[33]), .cout(fir_cout_1[33]));
	fulladder firadd1_34 (.a(pp0[36]), .b(pp1[36]), .cin(pp2[34]), .sum(fir_sum_1[34]), .cout(fir_cout_1[34]));

	fulladder firadd1_35 (.a(pp1[37]), .b(pp2[35]), .cin(pp3[33]), .sum(fir_sum_1[35]), .cout(fir_cout_1[35]));

	fulladder firadd1_36 (.a(pp2[36]), .b(pp3[34]), .cin(pp4[32]), .sum(fir_sum_1[36]), .cout(fir_cout_1[36]));
	fulladder firadd1_37 (.a(pp2[37]), .b(pp3[35]), .cin(pp4[33]), .sum(fir_sum_1[37]), .cout(fir_cout_1[37]));

	fulladder firadd1_38 (.a(pp3[36]), .b(pp4[34]), .cin(pp5[32]), .sum(fir_sum_1[38]), .cout(fir_cout_1[38]));
	fulladder firadd1_39 (.a(pp3[37]), .b(pp4[35]), .cin(pp5[33]), .sum(fir_sum_1[39]), .cout(fir_cout_1[39]));

	fulladder firadd1_40 (.a(pp4[36]), .b(pp5[34]), .cin(pp6[32]), .sum(fir_sum_1[40]), .cout(fir_cout_1[40]));
	fulladder firadd1_41 (.a(pp4[37]), .b(pp5[35]), .cin(pp6[33]), .sum(fir_sum_1[41]), .cout(fir_cout_1[41]));

	fulladder firadd1_42 (.a(pp5[36]), .b(pp6[34]), .cin(pp7[32]), .sum(fir_sum_1[42]), .cout(fir_cout_1[42]));
	fulladder firadd1_43 (.a(pp5[37]), .b(pp6[35]), .cin(pp7[33]), .sum(fir_sum_1[43]), .cout(fir_cout_1[43]));

	fulladder firadd1_44 (.a(pp6[36]), .b(pp7[34]), .cin(pp8[32]), .sum(fir_sum_1[44]), .cout(fir_cout_1[44]));
	fulladder firadd1_45 (.a(pp6[37]), .b(pp7[35]), .cin(pp8[33]), .sum(fir_sum_1[45]), .cout(fir_cout_1[45]));


	wire [33:0] fir_sum_2;          // sum output of adder, layer 2
	wire [33:0] fir_cout_2;         // cout output of adder, layer 2
	fulladder firadd2_0  (.a(pp3[ 4]), .b(pp4[ 2]), .cin(pp5[ 0]), .sum(fir_sum_2[ 0]), .cout(fir_cout_2[ 0]));
	fulladder firadd2_1  (.a(pp3[ 5]), .b(pp4[ 3]), .cin(pp5[ 1]), .sum(fir_sum_2[ 1]), .cout(fir_cout_2[ 1]));
	fulladder firadd2_2  (.a(pp3[ 6]), .b(pp4[ 4]), .cin(pp5[ 2]), .sum(fir_sum_2[ 2]), .cout(fir_cout_2[ 2]));
	fulladder firadd2_3  (.a(pp3[ 7]), .b(pp4[ 5]), .cin(pp5[ 3]), .sum(fir_sum_2[ 3]), .cout(fir_cout_2[ 3]));
	fulladder firadd2_4  (.a(pp3[ 8]), .b(pp4[ 6]), .cin(pp5[ 4]), .sum(fir_sum_2[ 4]), .cout(fir_cout_2[ 4]));
	fulladder firadd2_5  (.a(pp3[ 9]), .b(pp4[ 7]), .cin(pp5[ 5]), .sum(fir_sum_2[ 5]), .cout(fir_cout_2[ 5]));
	fulladder firadd2_6  (.a(pp3[10]), .b(pp4[ 8]), .cin(pp5[ 6]), .sum(fir_sum_2[ 6]), .cout(fir_cout_2[ 6]));
	fulladder firadd2_7  (.a(pp3[11]), .b(pp4[ 9]), .cin(pp5[ 7]), .sum(fir_sum_2[ 7]), .cout(fir_cout_2[ 7]));
	fulladder firadd2_8  (.a(pp3[12]), .b(pp4[10]), .cin(pp5[ 8]), .sum(fir_sum_2[ 8]), .cout(fir_cout_2[ 8]));
	fulladder firadd2_9  (.a(pp3[13]), .b(pp4[11]), .cin(pp5[ 9]), .sum(fir_sum_2[ 9]), .cout(fir_cout_2[ 9]));
	fulladder firadd2_10 (.a(pp3[14]), .b(pp4[12]), .cin(pp5[10]), .sum(fir_sum_2[10]), .cout(fir_cout_2[10]));
	fulladder firadd2_11 (.a(pp3[15]), .b(pp4[13]), .cin(pp5[11]), .sum(fir_sum_2[11]), .cout(fir_cout_2[11]));
	fulladder firadd2_12 (.a(pp3[16]), .b(pp4[14]), .cin(pp5[12]), .sum(fir_sum_2[12]), .cout(fir_cout_2[12]));
	fulladder firadd2_13 (.a(pp3[17]), .b(pp4[15]), .cin(pp5[13]), .sum(fir_sum_2[13]), .cout(fir_cout_2[13]));
	fulladder firadd2_14 (.a(pp3[18]), .b(pp4[16]), .cin(pp5[14]), .sum(fir_sum_2[14]), .cout(fir_cout_2[14]));
	fulladder firadd2_15 (.a(pp3[19]), .b(pp4[17]), .cin(pp5[15]), .sum(fir_sum_2[15]), .cout(fir_cout_2[15]));
	fulladder firadd2_16 (.a(pp3[20]), .b(pp4[18]), .cin(pp5[16]), .sum(fir_sum_2[16]), .cout(fir_cout_2[16]));
	fulladder firadd2_17 (.a(pp3[21]), .b(pp4[19]), .cin(pp5[17]), .sum(fir_sum_2[17]), .cout(fir_cout_2[17]));
	fulladder firadd2_18 (.a(pp3[22]), .b(pp4[20]), .cin(pp5[18]), .sum(fir_sum_2[18]), .cout(fir_cout_2[18]));
	fulladder firadd2_19 (.a(pp3[23]), .b(pp4[21]), .cin(pp5[19]), .sum(fir_sum_2[19]), .cout(fir_cout_2[19]));
	fulladder firadd2_20 (.a(pp3[24]), .b(pp4[22]), .cin(pp5[20]), .sum(fir_sum_2[20]), .cout(fir_cout_2[20]));
	fulladder firadd2_21 (.a(pp3[25]), .b(pp4[23]), .cin(pp5[21]), .sum(fir_sum_2[21]), .cout(fir_cout_2[21]));
	fulladder firadd2_22 (.a(pp3[26]), .b(pp4[24]), .cin(pp5[22]), .sum(fir_sum_2[22]), .cout(fir_cout_2[22]));
	fulladder firadd2_23 (.a(pp3[27]), .b(pp4[25]), .cin(pp5[23]), .sum(fir_sum_2[23]), .cout(fir_cout_2[23]));
	fulladder firadd2_24 (.a(pp3[28]), .b(pp4[26]), .cin(pp5[24]), .sum(fir_sum_2[24]), .cout(fir_cout_2[24]));
	fulladder firadd2_25 (.a(pp3[29]), .b(pp4[27]), .cin(pp5[25]), .sum(fir_sum_2[25]), .cout(fir_cout_2[25]));
	fulladder firadd2_26 (.a(pp3[30]), .b(pp4[28]), .cin(pp5[26]), .sum(fir_sum_2[26]), .cout(fir_cout_2[26]));
	fulladder firadd2_27 (.a(pp3[31]), .b(pp4[29]), .cin(pp5[27]), .sum(fir_sum_2[27]), .cout(fir_cout_2[27]));
	fulladder firadd2_28 (.a(pp3[32]), .b(pp4[30]), .cin(pp5[28]), .sum(fir_sum_2[28]), .cout(fir_cout_2[28]));
	
	fulladder firadd2_29 (.a(pp4[31]), .b(pp5[29]), .cin(pp6[27]), .sum(fir_sum_2[29]), .cout(fir_cout_2[29]));

	fulladder firadd2_30 (.a(pp5[30]), .b(pp6[28]), .cin(pp7[26]), .sum(fir_sum_2[30]), .cout(fir_cout_2[30]));
	fulladder firadd2_31 (.a(pp5[31]), .b(pp6[29]), .cin(pp7[27]), .sum(fir_sum_2[31]), .cout(fir_cout_2[31]));

	fulladder firadd2_32 (.a(pp6[30]), .b(pp7[28]), .cin(pp8[26]), .sum(fir_sum_2[32]), .cout(fir_cout_2[32]));
	fulladder firadd2_33 (.a(pp6[31]), .b(pp7[29]), .cin(pp8[27]), .sum(fir_sum_2[33]), .cout(fir_cout_2[33]));


	wire [23:0] fir_sum_3;          // sum output of adder, layer 3
	wire [23:0] fir_cout_3;         // cout output of adder, layer 3
	fulladder firadd3_0  (.a(pp6[ 4]), .b(pp7[ 2]), .cin(pp8[ 0]), .sum(fir_sum_3[ 0]), .cout(fir_cout_3[ 0]));
	fulladder firadd3_1  (.a(pp6[ 5]), .b(pp7[ 3]), .cin(pp8[ 1]), .sum(fir_sum_3[ 1]), .cout(fir_cout_3[ 1]));
	fulladder firadd3_2  (.a(pp6[ 6]), .b(pp7[ 4]), .cin(pp8[ 2]), .sum(fir_sum_3[ 2]), .cout(fir_cout_3[ 2]));
	fulladder firadd3_3  (.a(pp6[ 7]), .b(pp7[ 5]), .cin(pp8[ 3]), .sum(fir_sum_3[ 3]), .cout(fir_cout_3[ 3]));
	fulladder firadd3_4  (.a(pp6[ 8]), .b(pp7[ 6]), .cin(pp8[ 4]), .sum(fir_sum_3[ 4]), .cout(fir_cout_3[ 4]));
	fulladder firadd3_5  (.a(pp6[ 9]), .b(pp7[ 7]), .cin(pp8[ 5]), .sum(fir_sum_3[ 5]), .cout(fir_cout_3[ 5]));
	fulladder firadd3_6   (.a(pp6[10]), .b(pp7[ 8]), .cin(pp8[ 6]), .sum(fir_sum_3[ 6]), .cout(fir_cout_3[ 6]));
	fulladder firadd3_7   (.a(pp6[11]), .b(pp7[ 9]), .cin(pp8[ 7]), .sum(fir_sum_3[ 7]), .cout(fir_cout_3[ 7]));
	fulladder firadd3_8   (.a(pp6[12]), .b(pp7[10]), .cin(pp8[ 8]), .sum(fir_sum_3[ 8]), .cout(fir_cout_3[ 8]));
	fulladder firadd3_9   (.a(pp6[13]), .b(pp7[11]), .cin(pp8[ 9]), .sum(fir_sum_3[ 9]), .cout(fir_cout_3[ 9]));
	fulladder firadd3_10  (.a(pp6[14]), .b(pp7[12]), .cin(pp8[10]), .sum(fir_sum_3[10]), .cout(fir_cout_3[10]));
	fulladder firadd3_11  (.a(pp6[15]), .b(pp7[13]), .cin(pp8[11]), .sum(fir_sum_3[11]), .cout(fir_cout_3[11]));
	fulladder firadd3_12  (.a(pp6[16]), .b(pp7[14]), .cin(pp8[12]), .sum(fir_sum_3[12]), .cout(fir_cout_3[12]));
	fulladder firadd3_13  (.a(pp6[17]), .b(pp7[15]), .cin(pp8[13]), .sum(fir_sum_3[13]), .cout(fir_cout_3[13]));
	fulladder firadd3_14  (.a(pp6[18]), .b(pp7[16]), .cin(pp8[14]), .sum(fir_sum_3[14]), .cout(fir_cout_3[14]));
	fulladder firadd3_15  (.a(pp6[19]), .b(pp7[17]), .cin(pp8[15]), .sum(fir_sum_3[15]), .cout(fir_cout_3[15]));
	fulladder firadd3_16  (.a(pp6[20]), .b(pp7[18]), .cin(pp8[16]), .sum(fir_sum_3[16]), .cout(fir_cout_3[16]));
	fulladder firadd3_17  (.a(pp6[21]), .b(pp7[19]), .cin(pp8[17]), .sum(fir_sum_3[17]), .cout(fir_cout_3[17]));
	fulladder firadd3_18  (.a(pp6[22]), .b(pp7[20]), .cin(pp8[18]), .sum(fir_sum_3[18]), .cout(fir_cout_3[18]));
	fulladder firadd3_19  (.a(pp6[23]), .b(pp7[21]), .cin(pp8[19]), .sum(fir_sum_3[19]), .cout(fir_cout_3[19]));
	fulladder firadd3_20  (.a(pp6[24]), .b(pp7[22]), .cin(pp8[20]), .sum(fir_sum_3[20]), .cout(fir_cout_3[20]));
	fulladder firadd3_21  (.a(pp6[25]), .b(pp7[23]), .cin(pp8[21]), .sum(fir_sum_3[21]), .cout(fir_cout_3[21]));
	fulladder firadd3_22  (.a(pp6[26]), .b(pp7[24]), .cin(pp8[22]), .sum(fir_sum_3[22]), .cout(fir_cout_3[22]));
  
	halfadder firadd3_23  (.a(pp7[25]), .b(pp8[23]), .sum(fir_sum_3[23]), .cout(fir_cout_3[23]));


///////////////// second stage ////////////////////
	wire [42:0] sec_sum_1;          // sum output of adder, layer 1
	wire [41:0] sec_cout_1;         // cout output of adder, layer 1
	fulladder secadd1_0  (.a(fir_sum_1[ 2]), .b(fir_cout_1[ 1]), .cin(pp3[ 0]), .sum(sec_sum_1[ 0]), .cout(sec_cout_1[ 0]));
	fulladder secadd1_1  (.a(fir_sum_1[ 3]), .b(fir_cout_1[ 2]), .cin(pp3[ 1]), .sum(sec_sum_1[ 1]), .cout(sec_cout_1[ 1]));
	fulladder secadd1_2  (.a(fir_sum_1[ 4]), .b(fir_cout_1[ 3]), .cin(pp3[ 2]), .sum(sec_sum_1[ 2]), .cout(sec_cout_1[ 2]));
	fulladder secadd1_3  (.a(fir_sum_1[ 5]), .b(fir_cout_1[ 4]), .cin(pp3[ 3]), .sum(sec_sum_1[ 3]), .cout(sec_cout_1[ 3]));
  
	fulladder secadd1_4  (.a(fir_sum_1[ 6]), .b(fir_cout_1[ 5]), .cin(fir_sum_2[ 0]), .sum(sec_sum_1[ 4]), .cout(sec_cout_1[ 4]));
	fulladder secadd1_5  (.a(fir_sum_1[ 7]), .b(fir_cout_1[ 6]), .cin(fir_sum_2[ 1]), .sum(sec_sum_1[ 5]), .cout(sec_cout_1[ 5]));
	fulladder secadd1_6  (.a(fir_sum_1[ 8]), .b(fir_cout_1[ 7]), .cin(fir_sum_2[ 2]), .sum(sec_sum_1[ 6]), .cout(sec_cout_1[ 6]));
	fulladder secadd1_7  (.a(fir_sum_1[ 9]), .b(fir_cout_1[ 8]), .cin(fir_sum_2[ 3]), .sum(sec_sum_1[ 7]), .cout(sec_cout_1[ 7]));
	fulladder secadd1_8  (.a(fir_sum_1[10]), .b(fir_cout_1[ 9]), .cin(fir_sum_2[ 4]), .sum(sec_sum_1[ 8]), .cout(sec_cout_1[ 8]));
	fulladder secadd1_9  (.a(fir_sum_1[11]), .b(fir_cout_1[10]), .cin(fir_sum_2[ 5]), .sum(sec_sum_1[ 9]), .cout(sec_cout_1[ 9]));
	fulladder secadd1_10 (.a(fir_sum_1[12]), .b(fir_cout_1[11]), .cin(fir_sum_2[ 6]), .sum(sec_sum_1[10]), .cout(sec_cout_1[10]));
	fulladder secadd1_11 (.a(fir_sum_1[13]), .b(fir_cout_1[12]), .cin(fir_sum_2[ 7]), .sum(sec_sum_1[11]), .cout(sec_cout_1[11]));
	fulladder secadd1_12 (.a(fir_sum_1[14]), .b(fir_cout_1[13]), .cin(fir_sum_2[ 8]), .sum(sec_sum_1[12]), .cout(sec_cout_1[12]));
	fulladder secadd1_13 (.a(fir_sum_1[15]), .b(fir_cout_1[14]), .cin(fir_sum_2[ 9]), .sum(sec_sum_1[13]), .cout(sec_cout_1[13]));
	fulladder secadd1_14 (.a(fir_sum_1[16]), .b(fir_cout_1[15]), .cin(fir_sum_2[10]), .sum(sec_sum_1[14]), .cout(sec_cout_1[14]));
	fulladder secadd1_15 (.a(fir_sum_1[17]), .b(fir_cout_1[16]), .cin(fir_sum_2[11]), .sum(sec_sum_1[15]), .cout(sec_cout_1[15]));
	fulladder secadd1_16 (.a(fir_sum_1[18]), .b(fir_cout_1[17]), .cin(fir_sum_2[12]), .sum(sec_sum_1[16]), .cout(sec_cout_1[16]));
	fulladder secadd1_17 (.a(fir_sum_1[19]), .b(fir_cout_1[18]), .cin(fir_sum_2[13]), .sum(sec_sum_1[17]), .cout(sec_cout_1[17]));
	fulladder secadd1_18 (.a(fir_sum_1[20]), .b(fir_cout_1[19]), .cin(fir_sum_2[14]), .sum(sec_sum_1[18]), .cout(sec_cout_1[18]));
	fulladder secadd1_19 (.a(fir_sum_1[21]), .b(fir_cout_1[20]), .cin(fir_sum_2[15]), .sum(sec_sum_1[19]), .cout(sec_cout_1[19]));
	fulladder secadd1_20 (.a(fir_sum_1[22]), .b(fir_cout_1[21]), .cin(fir_sum_2[16]), .sum(sec_sum_1[20]), .cout(sec_cout_1[20]));
	fulladder secadd1_21 (.a(fir_sum_1[23]), .b(fir_cout_1[22]), .cin(fir_sum_2[17]), .sum(sec_sum_1[21]), .cout(sec_cout_1[21]));
	fulladder secadd1_22 (.a(fir_sum_1[24]), .b(fir_cout_1[23]), .cin(fir_sum_2[18]), .sum(sec_sum_1[22]), .cout(sec_cout_1[22]));
	fulladder secadd1_23 (.a(fir_sum_1[25]), .b(fir_cout_1[24]), .cin(fir_sum_2[19]), .sum(sec_sum_1[23]), .cout(sec_cout_1[23]));
	fulladder secadd1_24 (.a(fir_sum_1[26]), .b(fir_cout_1[25]), .cin(fir_sum_2[20]), .sum(sec_sum_1[24]), .cout(sec_cout_1[24]));
	fulladder secadd1_25 (.a(fir_sum_1[27]), .b(fir_cout_1[26]), .cin(fir_sum_2[21]), .sum(sec_sum_1[25]), .cout(sec_cout_1[25]));
	fulladder secadd1_26 (.a(fir_sum_1[28]), .b(fir_cout_1[27]), .cin(fir_sum_2[22]), .sum(sec_sum_1[26]), .cout(sec_cout_1[26]));
	fulladder secadd1_27 (.a(fir_sum_1[29]), .b(fir_cout_1[28]), .cin(fir_sum_2[23]), .sum(sec_sum_1[27]), .cout(sec_cout_1[27]));
	fulladder secadd1_28 (.a(fir_sum_1[30]), .b(fir_cout_1[29]), .cin(fir_sum_2[24]), .sum(sec_sum_1[28]), .cout(sec_cout_1[28]));
	fulladder secadd1_29 (.a(fir_sum_1[31]), .b(fir_cout_1[30]), .cin(fir_sum_2[25]), .sum(sec_sum_1[29]), .cout(sec_cout_1[29]));
	fulladder secadd1_30 (.a(fir_sum_1[32]), .b(fir_cout_1[31]), .cin(fir_sum_2[26]), .sum(sec_sum_1[30]), .cout(sec_cout_1[30]));
	fulladder secadd1_31 (.a(fir_sum_1[33]), .b(fir_cout_1[32]), .cin(fir_sum_2[27]), .sum(sec_sum_1[31]), .cout(sec_cout_1[31]));
	fulladder secadd1_32 (.a(fir_sum_1[34]), .b(fir_cout_1[33]), .cin(fir_sum_2[28]), .sum(sec_sum_1[32]), .cout(sec_cout_1[32]));
	fulladder secadd1_33 (.a(fir_sum_1[35]), .b(fir_cout_1[34]), .cin(fir_sum_2[29]), .sum(sec_sum_1[33]), .cout(sec_cout_1[33]));
	fulladder secadd1_34 (.a(fir_sum_1[36]), .b(fir_cout_1[35]), .cin(fir_sum_2[30]), .sum(sec_sum_1[34]), .cout(sec_cout_1[34]));
	fulladder secadd1_35 (.a(fir_sum_1[37]), .b(fir_cout_1[36]), .cin(fir_sum_2[31]), .sum(sec_sum_1[35]), .cout(sec_cout_1[35]));
	fulladder secadd1_36 (.a(fir_sum_1[38]), .b(fir_cout_1[37]), .cin(fir_sum_2[32]), .sum(sec_sum_1[36]), .cout(sec_cout_1[36]));
	fulladder secadd1_37 (.a(fir_sum_1[39]), .b(fir_cout_1[38]), .cin(fir_sum_2[33]), .sum(sec_sum_1[37]), .cout(sec_cout_1[37]));

	fulladder secadd1_38 (.a(fir_sum_1[40]), .b(fir_cout_1[39]), .cin(pp7[30]), .sum(sec_sum_1[38]), .cout(sec_cout_1[38]));
	fulladder secadd1_39 (.a(fir_sum_1[41]), .b(fir_cout_1[40]), .cin(pp7[31]), .sum(sec_sum_1[39]), .cout(sec_cout_1[39]));

	fulladder secadd1_40 (.a(fir_sum_1[42]), .b(fir_cout_1[41]), .cin(pp8[30]), .sum(sec_sum_1[40]), .cout(sec_cout_1[40]));
	fulladder secadd1_41 (.a(fir_sum_1[43]), .b(fir_cout_1[42]), .cin(pp8[31]), .sum(sec_sum_1[41]), .cout(sec_cout_1[41]));

	fulladder secadd1_42 (.a(pp7[36]), .b(pp8[34]), .cin(fir_cout_1[45]), .sum(sec_sum_1[42]), .cout());


	wire [27:0] sec_sum_2;          // sum output of adder, layer 2
	wire [27:0] sec_cout_2;         // cout output of adder, layer 2
	fulladder secadd2_0  (.a(pp6[ 2]), .b(pp7[ 0]), .cin(fir_cout_2[ 3]), .sum(sec_sum_2[ 0]), .cout(sec_cout_2[ 0]));
	fulladder secadd2_1  (.a(pp6[ 3]), .b(pp7[ 1]), .cin(fir_cout_2[ 4]), .sum(sec_sum_2[ 1]), .cout(sec_cout_2[ 1]));

	halfadder secadd2_2  (.a(fir_sum_3[ 0]), .b(fir_cout_2[ 5]), .sum(sec_sum_2[ 2]), .cout(sec_cout_2[ 2]));

	fulladder secadd2_3  (.a(fir_sum_3[ 1]), .b(fir_cout_3[ 0]), .cin(fir_cout_2[ 6]), .sum(sec_sum_2[ 3]), .cout(sec_cout_2[ 3]));
	fulladder secadd2_4  (.a(fir_sum_3[ 2]), .b(fir_cout_3[ 1]), .cin(fir_cout_2[ 7]), .sum(sec_sum_2[ 4]), .cout(sec_cout_2[ 4]));
	fulladder secadd2_5  (.a(fir_sum_3[ 3]), .b(fir_cout_3[ 2]), .cin(fir_cout_2[ 8]), .sum(sec_sum_2[ 5]), .cout(sec_cout_2[ 5]));
	fulladder secadd2_6  (.a(fir_sum_3[ 4]), .b(fir_cout_3[ 3]), .cin(fir_cout_2[ 9]), .sum(sec_sum_2[ 6]), .cout(sec_cout_2[ 6]));
	fulladder secadd2_7  (.a(fir_sum_3[ 5]), .b(fir_cout_3[ 4]), .cin(fir_cout_2[10]), .sum(sec_sum_2[ 7]), .cout(sec_cout_2[ 7]));
	fulladder secadd2_8  (.a(fir_sum_3[ 6]), .b(fir_cout_3[ 5]), .cin(fir_cout_2[11]), .sum(sec_sum_2[ 8]), .cout(sec_cout_2[ 8]));
	fulladder secadd2_9  (.a(fir_sum_3[ 7]), .b(fir_cout_3[ 6]), .cin(fir_cout_2[12]), .sum(sec_sum_2[ 9]), .cout(sec_cout_2[ 9]));
	fulladder secadd2_10 (.a(fir_sum_3[ 8]), .b(fir_cout_3[ 7]), .cin(fir_cout_2[13]), .sum(sec_sum_2[10]), .cout(sec_cout_2[10]));
	fulladder secadd2_11 (.a(fir_sum_3[ 9]), .b(fir_cout_3[ 8]), .cin(fir_cout_2[14]), .sum(sec_sum_2[11]), .cout(sec_cout_2[11]));
	fulladder secadd2_12 (.a(fir_sum_3[10]), .b(fir_cout_3[ 9]), .cin(fir_cout_2[15]), .sum(sec_sum_2[12]), .cout(sec_cout_2[12]));
	fulladder secadd2_13 (.a(fir_sum_3[11]), .b(fir_cout_3[10]), .cin(fir_cout_2[16]), .sum(sec_sum_2[13]), .cout(sec_cout_2[13]));
	fulladder secadd2_14 (.a(fir_sum_3[12]), .b(fir_cout_3[11]), .cin(fir_cout_2[17]), .sum(sec_sum_2[14]), .cout(sec_cout_2[14]));
	fulladder secadd2_15 (.a(fir_sum_3[13]), .b(fir_cout_3[12]), .cin(fir_cout_2[18]), .sum(sec_sum_2[15]), .cout(sec_cout_2[15]));
	fulladder secadd2_16 (.a(fir_sum_3[14]), .b(fir_cout_3[13]), .cin(fir_cout_2[19]), .sum(sec_sum_2[16]), .cout(sec_cout_2[16]));
	fulladder secadd2_17 (.a(fir_sum_3[15]), .b(fir_cout_3[14]), .cin(fir_cout_2[20]), .sum(sec_sum_2[17]), .cout(sec_cout_2[17]));
	fulladder secadd2_18 (.a(fir_sum_3[16]), .b(fir_cout_3[15]), .cin(fir_cout_2[21]), .sum(sec_sum_2[18]), .cout(sec_cout_2[18]));
	fulladder secadd2_19 (.a(fir_sum_3[17]), .b(fir_cout_3[16]), .cin(fir_cout_2[22]), .sum(sec_sum_2[19]), .cout(sec_cout_2[19]));
	fulladder secadd2_20 (.a(fir_sum_3[18]), .b(fir_cout_3[17]), .cin(fir_cout_2[23]), .sum(sec_sum_2[20]), .cout(sec_cout_2[20]));
	fulladder secadd2_21 (.a(fir_sum_3[19]), .b(fir_cout_3[18]), .cin(fir_cout_2[24]), .sum(sec_sum_2[21]), .cout(sec_cout_2[21]));
	fulladder secadd2_22 (.a(fir_sum_3[20]), .b(fir_cout_3[19]), .cin(fir_cout_2[25]), .sum(sec_sum_2[22]), .cout(sec_cout_2[22]));
	fulladder secadd2_23 (.a(fir_sum_3[21]), .b(fir_cout_3[20]), .cin(fir_cout_2[26]), .sum(sec_sum_2[23]), .cout(sec_cout_2[23]));
	fulladder secadd2_24 (.a(fir_sum_3[22]), .b(fir_cout_3[21]), .cin(fir_cout_2[27]), .sum(sec_sum_2[24]), .cout(sec_cout_2[24]));
	fulladder secadd2_25 (.a(fir_sum_3[23]), .b(fir_cout_3[22]), .cin(fir_cout_2[28]), .sum(sec_sum_2[25]), .cout(sec_cout_2[25]));

	fulladder secadd2_43  (.a(pp8[24]), .b(fir_cout_3[23]), .cin(fir_cout_2[29]), .sum(sec_sum_2[26]), .cout(sec_cout_2[26]));

	halfadder secadd2_27 (.a(pp8[25]), .b(fir_cout_2[30]), .sum(sec_sum_2[27]), .cout(sec_cout_2[27]));




///////////////// third stage ////////////////////
	wire [37:0] thr_sum;          // sum output of adder
	wire [37:0] thr_cout;         // cout output of adder
	fulladder thradd0  (.a(sec_sum_1[ 2]), .b(sec_cout_1[ 1]), .cin(pp4[ 0]), .sum(thr_sum[ 0]), .cout(thr_cout[ 0]));
	fulladder thradd1  (.a(sec_sum_1[ 3]), .b(sec_cout_1[ 2]), .cin(pp4[ 1]), .sum(thr_sum[ 1]), .cout(thr_cout[ 1]));

	fulladder thradd2  (.a(sec_sum_1[ 5]), .b(sec_cout_1[ 4]), .cin(fir_cout_2[ 0]), .sum(thr_sum[ 2]), .cout(thr_cout[ 2]));

	fulladder thradd3  (.a(sec_sum_1[ 6]), .b(sec_cout_1[ 5]), .cin(pp6[ 0]), .sum(thr_sum[ 3]), .cout(thr_cout[ 3]));
	fulladder thradd4  (.a(sec_sum_1[ 7]), .b(sec_cout_1[ 6]), .cin(pp6[ 1]), .sum(thr_sum[ 4]), .cout(thr_cout[ 4]));

	fulladder thradd5  (.a(sec_sum_1[ 8]), .b(sec_cout_1[ 7]), .cin(sec_sum_2[ 0]), .sum(thr_sum[ 5]), .cout(thr_cout[ 5]));
	fulladder thradd6  (.a(sec_sum_1[ 9]), .b(sec_cout_1[ 8]), .cin(sec_sum_2[ 1]), .sum(thr_sum[ 6]), .cout(thr_cout[ 6]));
	fulladder thradd7  (.a(sec_sum_1[10]), .b(sec_cout_1[ 9]), .cin(sec_sum_2[ 2]), .sum(thr_sum[ 7]), .cout(thr_cout[ 7]));
	fulladder thradd8  (.a(sec_sum_1[11]), .b(sec_cout_1[10]), .cin(sec_sum_2[ 3]), .sum(thr_sum[ 8]), .cout(thr_cout[ 8]));
	fulladder thradd9  (.a(sec_sum_1[12]), .b(sec_cout_1[11]), .cin(sec_sum_2[ 4]), .sum(thr_sum[ 9]), .cout(thr_cout[ 9]));
	fulladder thradd10 (.a(sec_sum_1[13]), .b(sec_cout_1[12]), .cin(sec_sum_2[ 5]), .sum(thr_sum[10]), .cout(thr_cout[10]));
	fulladder thradd11 (.a(sec_sum_1[14]), .b(sec_cout_1[13]), .cin(sec_sum_2[ 6]), .sum(thr_sum[11]), .cout(thr_cout[11]));
	fulladder thradd12 (.a(sec_sum_1[15]), .b(sec_cout_1[14]), .cin(sec_sum_2[ 7]), .sum(thr_sum[12]), .cout(thr_cout[12]));
	fulladder thradd13 (.a(sec_sum_1[16]), .b(sec_cout_1[15]), .cin(sec_sum_2[ 8]), .sum(thr_sum[13]), .cout(thr_cout[13]));
	fulladder thradd14 (.a(sec_sum_1[17]), .b(sec_cout_1[16]), .cin(sec_sum_2[ 9]), .sum(thr_sum[14]), .cout(thr_cout[14]));
	fulladder thradd15 (.a(sec_sum_1[18]), .b(sec_cout_1[17]), .cin(sec_sum_2[10]), .sum(thr_sum[15]), .cout(thr_cout[15]));
	fulladder thradd16 (.a(sec_sum_1[19]), .b(sec_cout_1[18]), .cin(sec_sum_2[11]), .sum(thr_sum[16]), .cout(thr_cout[16]));
	fulladder thradd17 (.a(sec_sum_1[20]), .b(sec_cout_1[19]), .cin(sec_sum_2[12]), .sum(thr_sum[17]), .cout(thr_cout[17]));
	fulladder thradd18 (.a(sec_sum_1[21]), .b(sec_cout_1[20]), .cin(sec_sum_2[13]), .sum(thr_sum[18]), .cout(thr_cout[18]));
	fulladder thradd19 (.a(sec_sum_1[22]), .b(sec_cout_1[21]), .cin(sec_sum_2[14]), .sum(thr_sum[19]), .cout(thr_cout[19]));
	fulladder thradd20 (.a(sec_sum_1[23]), .b(sec_cout_1[22]), .cin(sec_sum_2[15]), .sum(thr_sum[20]), .cout(thr_cout[20]));
	fulladder thradd21 (.a(sec_sum_1[24]), .b(sec_cout_1[23]), .cin(sec_sum_2[16]), .sum(thr_sum[21]), .cout(thr_cout[21]));
	fulladder thradd22 (.a(sec_sum_1[25]), .b(sec_cout_1[24]), .cin(sec_sum_2[17]), .sum(thr_sum[22]), .cout(thr_cout[22]));
	fulladder thradd23 (.a(sec_sum_1[26]), .b(sec_cout_1[25]), .cin(sec_sum_2[18]), .sum(thr_sum[23]), .cout(thr_cout[23]));
	fulladder thradd24 (.a(sec_sum_1[27]), .b(sec_cout_1[26]), .cin(sec_sum_2[19]), .sum(thr_sum[24]), .cout(thr_cout[24]));
	fulladder thradd25 (.a(sec_sum_1[28]), .b(sec_cout_1[27]), .cin(sec_sum_2[20]), .sum(thr_sum[25]), .cout(thr_cout[25]));
	fulladder thradd26 (.a(sec_sum_1[29]), .b(sec_cout_1[28]), .cin(sec_sum_2[21]), .sum(thr_sum[26]), .cout(thr_cout[26]));
	fulladder thradd27 (.a(sec_sum_1[30]), .b(sec_cout_1[29]), .cin(sec_sum_2[22]), .sum(thr_sum[27]), .cout(thr_cout[27]));
	fulladder thradd28 (.a(sec_sum_1[31]), .b(sec_cout_1[30]), .cin(sec_sum_2[23]), .sum(thr_sum[28]), .cout(thr_cout[28]));
	fulladder thradd29 (.a(sec_sum_1[32]), .b(sec_cout_1[31]), .cin(sec_sum_2[24]), .sum(thr_sum[29]), .cout(thr_cout[29]));
	fulladder thradd30 (.a(sec_sum_1[33]), .b(sec_cout_1[32]), .cin(sec_sum_2[25]), .sum(thr_sum[30]), .cout(thr_cout[30]));
	fulladder thradd31 (.a(sec_sum_1[34]), .b(sec_cout_1[33]), .cin(sec_sum_2[26]), .sum(thr_sum[31]), .cout(thr_cout[31]));
	fulladder thradd32 (.a(sec_sum_1[35]), .b(sec_cout_1[34]), .cin(sec_sum_2[27]), .sum(thr_sum[32]), .cout(thr_cout[32]));

	fulladder thradd33 (.a(sec_sum_1[36]), .b(sec_cout_1[35]), .cin(fir_cout_2[31]), .sum(thr_sum[33]), .cout(thr_cout[33]));
	fulladder thradd34 (.a(sec_sum_1[37]), .b(sec_cout_1[36]), .cin(fir_cout_2[32]), .sum(thr_sum[34]), .cout(thr_cout[34]));

	fulladder thradd35 (.a(sec_sum_1[38]), .b(sec_cout_1[37]), .cin(pp8[28]), .sum(thr_sum[35]), .cout(thr_cout[35]));
	fulladder thradd36 (.a(sec_sum_1[39]), .b(sec_cout_1[38]), .cin(pp8[29]), .sum(thr_sum[36]), .cout(thr_cout[36]));

	fulladder thradd37 (.a(fir_sum_1[44]), .b(fir_cout_1[43]), .cin(sec_cout_1[41]), .sum(thr_sum[37]), .cout(thr_cout[37]));



///////////////// forth stage ////////////////////
	wire [37:0] for_sum;          // sum output of adder
	wire [37:0] for_cout;         // cout output of adder
	fulladder foradd0  (.a(sec_sum_1[ 4]), .b(sec_cout_1[ 3]), .cin(thr_cout[ 1]), .sum(for_sum[ 0]), .cout(for_cout[ 0]));

	fulladder foradd1  (.a(thr_sum[ 3]), .b(thr_cout[ 2]), .cin(fir_cout_2[ 1]), .sum(for_sum[ 1]), .cout(for_cout[ 1]));
	fulladder foradd2  (.a(thr_sum[ 4]), .b(thr_cout[ 3]), .cin(fir_cout_2[ 2]), .sum(for_sum[ 2]), .cout(for_cout[ 2]));

	halfadder foradd3  (.a(thr_sum[ 5]), .b(thr_cout[ 4]), .sum(for_sum[ 3]), .cout(for_cout[ 3]));

	fulladder foradd4  (.a(thr_sum[ 6]), .b(thr_cout[ 5]), .cin(sec_cout_2[ 0]), .sum(for_sum[ 4]), .cout(for_cout[ 4]));
	fulladder foradd5  (.a(thr_sum[ 7]), .b(thr_cout[ 6]), .cin(sec_cout_2[ 1]), .sum(for_sum[ 5]), .cout(for_cout[ 5]));
	fulladder foradd6  (.a(thr_sum[ 8]), .b(thr_cout[ 7]), .cin(sec_cout_2[ 2]), .sum(for_sum[ 6]), .cout(for_cout[ 6]));
	fulladder foradd7  (.a(thr_sum[ 9]), .b(thr_cout[ 8]), .cin(sec_cout_2[ 3]), .sum(for_sum[ 7]), .cout(for_cout[ 7]));
	fulladder foradd8  (.a(thr_sum[10]), .b(thr_cout[ 9]), .cin(sec_cout_2[ 4]), .sum(for_sum[ 8]), .cout(for_cout[ 8]));
	fulladder foradd9  (.a(thr_sum[11]), .b(thr_cout[10]), .cin(sec_cout_2[ 5]), .sum(for_sum[ 9]), .cout(for_cout[ 9]));
	fulladder foradd10 (.a(thr_sum[12]), .b(thr_cout[11]), .cin(sec_cout_2[ 6]), .sum(for_sum[10]), .cout(for_cout[10]));
	fulladder foradd11 (.a(thr_sum[13]), .b(thr_cout[12]), .cin(sec_cout_2[ 7]), .sum(for_sum[11]), .cout(for_cout[11]));
	fulladder foradd12 (.a(thr_sum[14]), .b(thr_cout[13]), .cin(sec_cout_2[ 8]), .sum(for_sum[12]), .cout(for_cout[12]));
	fulladder foradd13 (.a(thr_sum[15]), .b(thr_cout[14]), .cin(sec_cout_2[ 9]), .sum(for_sum[13]), .cout(for_cout[13]));
	fulladder foradd14 (.a(thr_sum[16]), .b(thr_cout[15]), .cin(sec_cout_2[10]), .sum(for_sum[14]), .cout(for_cout[14]));
	fulladder foradd15 (.a(thr_sum[17]), .b(thr_cout[16]), .cin(sec_cout_2[11]), .sum(for_sum[15]), .cout(for_cout[15]));
	fulladder foradd16 (.a(thr_sum[18]), .b(thr_cout[17]), .cin(sec_cout_2[12]), .sum(for_sum[16]), .cout(for_cout[16]));
	fulladder foradd17 (.a(thr_sum[19]), .b(thr_cout[18]), .cin(sec_cout_2[13]), .sum(for_sum[17]), .cout(for_cout[17]));
	fulladder foradd18 (.a(thr_sum[20]), .b(thr_cout[19]), .cin(sec_cout_2[14]), .sum(for_sum[18]), .cout(for_cout[18]));
	fulladder foradd19 (.a(thr_sum[21]), .b(thr_cout[20]), .cin(sec_cout_2[15]), .sum(for_sum[19]), .cout(for_cout[19]));
	fulladder foradd20 (.a(thr_sum[22]), .b(thr_cout[21]), .cin(sec_cout_2[16]), .sum(for_sum[20]), .cout(for_cout[20]));
	fulladder foradd21 (.a(thr_sum[23]), .b(thr_cout[22]), .cin(sec_cout_2[17]), .sum(for_sum[21]), .cout(for_cout[21]));
	fulladder foradd22 (.a(thr_sum[24]), .b(thr_cout[23]), .cin(sec_cout_2[18]), .sum(for_sum[22]), .cout(for_cout[22]));
	fulladder foradd23 (.a(thr_sum[25]), .b(thr_cout[24]), .cin(sec_cout_2[19]), .sum(for_sum[23]), .cout(for_cout[23]));
	fulladder foradd24 (.a(thr_sum[26]), .b(thr_cout[25]), .cin(sec_cout_2[20]), .sum(for_sum[24]), .cout(for_cout[24]));
	fulladder foradd25 (.a(thr_sum[27]), .b(thr_cout[26]), .cin(sec_cout_2[21]), .sum(for_sum[25]), .cout(for_cout[25]));
	fulladder foradd26 (.a(thr_sum[28]), .b(thr_cout[27]), .cin(sec_cout_2[22]), .sum(for_sum[26]), .cout(for_cout[26]));
	fulladder foradd27 (.a(thr_sum[29]), .b(thr_cout[28]), .cin(sec_cout_2[23]), .sum(for_sum[27]), .cout(for_cout[27]));
	fulladder foradd28 (.a(thr_sum[30]), .b(thr_cout[29]), .cin(sec_cout_2[24]), .sum(for_sum[28]), .cout(for_cout[28]));
	fulladder foradd29 (.a(thr_sum[31]), .b(thr_cout[30]), .cin(sec_cout_2[25]), .sum(for_sum[29]), .cout(for_cout[29]));
	fulladder foradd30 (.a(thr_sum[32]), .b(thr_cout[31]), .cin(sec_cout_2[26]), .sum(for_sum[30]), .cout(for_cout[30]));
	fulladder foradd31 (.a(thr_sum[33]), .b(thr_cout[32]), .cin(sec_cout_2[27]), .sum(for_sum[31]), .cout(for_cout[31]));

	halfadder foradd32 (.a(thr_sum[34]), .b(thr_cout[33]), .sum(for_sum[32]), .cout(for_cout[32]));

	fulladder foradd33 (.a(thr_sum[35]), .b(thr_cout[34]), .cin(fir_cout_2[33]), .sum(for_sum[33]), .cout(for_cout[33]));

	halfadder foradd34 (.a(thr_sum[36]), .b(thr_cout[35]), .sum(for_sum[34]), .cout(for_cout[34]));

	fulladder foradd35 (.a(sec_sum_1[40]), .b(thr_cout[36]), .cin(sec_cout_1[39]), .sum(for_sum[35]), .cout(for_cout[35]));

	halfadder foradd36 (.a(sec_sum_1[41]), .b(sec_cout_1[40]), .sum(for_sum[36]), .cout(for_cout[36]));

	fulladder foradd37 (.a(fir_sum_1[45]), .b(fir_cout_1[44]), .cin(thr_cout[37]), .sum(for_sum[37]), .cout(for_cout[37]));



	assign adda = {sec_sum_1[42],for_sum[37],thr_sum[37],for_sum[36:1],thr_sum[ 2],for_sum[ 0],thr_sum[1:0],sec_sum_1[1:0],fir_sum_1[1:0],pp0[1:0]};
	assign addb = {for_cout[37],1'b0,for_cout[36:1],1'b0,for_cout[ 0],1'b0,thr_cout[ 0],1'b0,sec_cout_1[ 0],1'b0,fir_cout_1[ 0],1'b0,pp1[1:0]};

endmodule