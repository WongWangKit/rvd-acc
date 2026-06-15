/////////////////////////////////////
//                                 
//  Caculate the 16x16 partial product   
//                                 
/////////////////////////////////////

module cal_pp_16_33 (
	input  [32:0] a_in,   // multiplicand
	input  [2:0]  b_in,   // 3bit of multiplier 
	output [33:0] res_out,
	output reg    res_inv	
);
	reg [33:0] res_reg;
	always @(*)
	begin
		case (b_in)
			3'b001  ,
			3'b010  : 
			begin
				res_reg = {a_in[32], a_in};
				res_inv = 1'b0;
			end
			3'b011  : 
			begin
				res_reg = {a_in[32], a_in[31:0], 1'b0};
				res_inv = 1'b0;
			end
			3'b100  : 
			begin
				res_reg = ~{a_in[32], a_in[31:0], 1'b0};
				res_inv = 1'b1;
			end
			3'b101  ,
			3'b110  : 
			begin
				res_reg = ~{a_in[32], a_in};
				res_inv = 1'b1;
			end
			default : 
			begin
				res_reg = 34'b0;
				res_inv = 1'b0;
			end
		endcase
	end

	assign res_out = res_reg;

endmodule