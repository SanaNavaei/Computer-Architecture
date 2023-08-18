`timescale 1ns/1ns
module MULTI #(parameter a = 0, b = 0)(in_a, in_b, out_multi);
    input [a - 1:0] in_a;
    input [b - 1:0] in_b;
    output [b + a - 1:0] out_multi;
    
    assign out_multi = in_a * in_b;

endmodule
