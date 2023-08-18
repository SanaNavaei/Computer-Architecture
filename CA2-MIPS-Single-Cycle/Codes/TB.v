`timescale 1ns/1ns;
module mips_single_cycleTB();
    wire [31:0]Inst_address, Inst;
    reg clock, rst;
    wire [31:0] max, max_idx;
    
    mips_single_cycle CUT(rst, clock, Inst_address, Inst, max, max_idx);
    inst_mem my_inst_mem(Inst_address, Inst);
    
    initial begin
        rst = 1'b1;
        clock = 1'b0;
        #150 rst = 1'b0;
        #10000 $stop;
    end
    
    always begin
      #20 clock = ~clock;
    end
    
endmodule
