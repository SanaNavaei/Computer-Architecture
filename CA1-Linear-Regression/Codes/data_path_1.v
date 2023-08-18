`timescale 1ns/1ns
module data_Path1(inx, iny, outx, outy, address1, address2, clk, reset, write_en_x, write_en_y);
    input [149:0][19:0] inx, iny;
    input [7:0]address1, address2;
    input clk, reset, write_en_x, write_en_y;
    output [19:0] outx, outy;

    reg co = 0;
    reg [7:0] count = 7'b1101010;
    Memory memory_x(inx, outx, address1, address2, clk, write_en_x);
    Memory memory_y(iny, outy, address1, address2, clk, write_en_y);

endmodule
