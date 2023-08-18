module sign_extend#(parameter size = 0)(in, out);
	input [size - 1:0] in;
	output [31:0] out;

    assign out = {{(31 - size){in[size - 1]}}, in};

endmodule
