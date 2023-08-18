module MUX2to1 #(parameter size = 0)(input0, input1, select, Q);
	input [size - 1:0] input0, input1;
    input select;
    output [size - 1:0] Q;

    assign Q = select ? input1 : input0;

endmodule
