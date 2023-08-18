module register(in, rst, load, clk, out);
    input clk, rst, load;
    input [31:0] in;
    output reg [31:0] out;

    always @(posedge clk)
        if (rst) out <= 32'b0;
        else if (load) out <= in;

endmodule
