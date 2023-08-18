module MUX4to1(a, b, c, d, s, Q);
	input [31:0] a, b, c, d;
    input [1:0] s;
    output reg [31:0] Q;

    always@(s, a, b, c, d)begin
        Q = 0;
        case(s)
            2'd0: Q = a;
            2'd1: Q = b;
            2'd2: Q = c;
            2'd3: Q = d;
        endcase
    end

endmodule
