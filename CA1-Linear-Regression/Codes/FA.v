`timescale 1ns/1ns
module FA#(parameter b = 0)(in_a  ,in_b, add_out);
    input [b-1:0] in_a, in_b;
    output [b-1:0] add_out;
    
    assign add_out = in_a + in_b;

endmodule
