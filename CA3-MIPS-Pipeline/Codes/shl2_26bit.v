module shl2_26bit (in, out);
    input [25:0] in;
    output [27:0] out;

    assign out = {in, 2'b00};

endmodule