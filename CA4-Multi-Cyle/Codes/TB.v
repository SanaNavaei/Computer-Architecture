`timescale 1ns/1ns;
module multicycleTB();
    reg clock, rst;
    wire [15:0] max, max_index;
    top_level CUT(clock, rst, max, max_index);
    
    always #20 clock = ~clock;
    initial begin
        rst = 1'b1;
        clock = 1'b0;
        #150 rst = 1'b0;
        #100000 $stop;
    end
 
endmodule
