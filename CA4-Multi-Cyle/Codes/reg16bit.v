module Reg16bit(clock, rst, reg_in, reg_out);
	input clock, rst;
	input[15:0] reg_in;
	output reg[15:0] reg_out;

	always@(posedge clock, posedge rst)begin
		if(rst) reg_out <= 16'd0;
		else reg_out <= reg_in;
	end

endmodule
