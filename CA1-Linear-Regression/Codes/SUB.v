`timescale 1ns/1ns
module SUB #(parameter b = 0)(in_a, in_b, out_sub);
    input [b - 1 : 0] in_a, in_b;
    output [b - 1 : 0] out_sub;

    assign out_sub = in_a - in_b;

endmodule
