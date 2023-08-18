`timescale 1ns/1ns
module DIV150 #(parameter b = 0)(in_a, out_div);
    input [b-1 : 0] in_a;
    output [b-1 : 0] out_div;
    assign out_div = in_a / 8'b10010110;

endmodule
