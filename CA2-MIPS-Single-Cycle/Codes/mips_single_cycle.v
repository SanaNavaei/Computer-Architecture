`timescale 1ns/1ns
module mips_single_cycle(rst, clock, Inst_address, Inst, max, max_index);
    input rst, clock;
    input  [31:0] Inst;
    output [31:0] Inst_address, max, max_index;
    
    wire Memread, Memwrite, write1, write2, regWrite, MemtoReg, ALUsrc, pcsrc, jmp1, jmp2, regDst1, regDst2, zero, bit31alu;
    wire [2:0]ALUopc, out_x;
    
    Datapath DP(out_x,clock, rst, write1, write2, regWrite, MemtoReg, ALUsrc, pcsrc, jmp1, jmp2, regDst1, regDst2,
                Inst, ALUopc, Inst_address, zero, bit31alu, Memread, Memwrite, max, max_index);
    
    Controller CU(bit31alu, Inst[31:26], Inst[5:0], zero, ALUopc, pcsrc, regWrite, Memread, Memwrite, ALUsrc, MemtoReg,
                jmp1, jmp2,regDst1, regDst2, write1, write2, out_x);
    
endmodule
