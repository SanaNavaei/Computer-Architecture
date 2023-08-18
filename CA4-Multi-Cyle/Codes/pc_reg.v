module PC_Reg(clock, rst, load, reg_in, reg_out);
	input clock, rst, load;
	input[11:0] reg_in;
	output reg[11:0] reg_out;

	always@(posedge clock, posedge rst)begin
		if(rst) reg_out <= 12'd210;
		else if(load) reg_out <= reg_in;
	end

endmodule
