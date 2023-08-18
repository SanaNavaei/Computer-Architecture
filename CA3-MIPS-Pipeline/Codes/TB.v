`timescale 1ns/1ns
module TB();
    reg clk = 0;
    reg rst;
    wire [31:0] max, max_index;
    top_module CUT(clk, rst, max, max_index);
    
    always #20 clk = ~clk;
    initial begin
        rst = 1;
        #150 rst = 0;
        #100000 $stop;
    end

endmodule
