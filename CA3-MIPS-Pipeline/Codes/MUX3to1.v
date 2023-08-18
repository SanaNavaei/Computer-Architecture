module MUX3to1 #(parameter size = 0)(a, b, c, s, Q);
	input [size - 1:0] a, b, c;
    input [1:0] s;
    output reg [size - 1 : 0] Q;
    always@(s, a, b, c)begin
        Q = 0;
        case(s)
            2'd0: Q = a;
            2'd1: Q = b;
            2'd2: Q = c;
        endcase
    end

endmodule
