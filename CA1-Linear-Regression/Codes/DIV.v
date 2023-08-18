`timescale 1ns/1ns
module DIV #(parameter b = 0)(in_a, in_b, out_div);
    input [b-1 : 0] in_a, in_b;
    output [b-1 : 0] out_div;

    assign out_div = in_a / in_b;

endmodule
