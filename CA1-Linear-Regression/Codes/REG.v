`timescale 1ns/1ns
module REG#(parameter size = 0)(r_in ,clk ,rst, load, init, r_out);
	input [size - 1 : 0] r_in;
	input clk, load, init, rst;
	output reg [size - 1 : 0] r_out;

	always @(posedge clk, posedge rst)begin
		if (rst)
			r_out <= 0;
		else if (init)
			r_out <= 0;
		else if(load)
			r_out <= r_in;
	end

endmodule
