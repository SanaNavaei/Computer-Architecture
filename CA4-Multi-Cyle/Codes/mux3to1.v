module MUX3to1 #(parameter size = 0)(input0, input1, input2, select, Q);
	input [size - 1:0] input0, input1, input2;
    input [1:0] select;
    output reg [size - 1:0] Q;

    always@(select, input0, input1, input2)begin
        Q = 0;
        case(select)
            2'd0: Q = input0;
            2'd1: Q = input1;
            2'd2: Q = input2;
        endcase
    end

endmodule
