`timescale 1ns/1ns
module data_path(clock, rst, pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRWrite, pcSRC, RegDst1, RegDst2, MemToReg, RegWrite1,
                 RegWrite2, ALUsrc_A, ALUsrc_B, ALUop2, Zero_out, max, max_index, IR_outt);
      input clock, rst, pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRWrite, RegDst1, RegDst2, MemToReg, RegWrite1, RegWrite2, ALUsrc_A;
	input [1:0] ALUsrc_B, pcSRC;
      input [2:0] ALUop2;
      output [15:0] max, max_index, IR_outt;
      output Zero_out;

      wire pc_load;
      wire [11:0] pc_mux_out, pc_out, address_in;
      wire [15:0] IR_out, mdr_out, read_data_out, write_reg_mux_out, alu_out, alu_in, a_out, a_in, b_out, b_in, write_data_mux_out, A_mux_out, B_mux_out,
                  sign_extend_out, pc_extend;

      assign IR_outt = IR_out;
      assign pc_load = (pcWriteCtrl & Zero_in) || pcWrite;
      PC_Reg REG1(clock, rst, pc_load, pc_mux_out, pc_out);
      IR_Reg REG2(clock, rst, IRWrite, read_data_out, IR_out);
      Reg16bit mdr_reg(clock, rst, read_data_out, mdr_out);
      Reg16bit a_reg(clock, rst, a_in, a_out);
      Reg16bit b_reg(clock, rst, b_in, b_out);
      Reg16bit Alu_out_reg(clock, rst, alu_in, alu_out);
      MUX2to1 #(12) IorDmux(pc_out, IR_out[11:0], IorD, address_in);
      MUX2to1 #(16) write_reg_mux(3'b000, IR_out[11:9], (RegDst1 || RegDst2), write_reg_mux_out);
      MUX2to1 #(16) write_data_mux(alu_out, mdr_out, MemToReg, write_data_mux_out);
      assign pc_extend = {4'b0000,pc_out};
      MUX2to1 #(16) A_mux(pc_extend, a_out, ALUsrc_A, A_mux_out);
      MUX3to1 #(16) B_mux(b_out, sign_extend_out, 16'd1, ALUsrc_B, B_mux_out);
      wire [11:0] pc_mux_input1;
      assign pc_mux_input1 = {pc_out[11:9], IR_out[8:0]};
      MUX3to1 #(12)pc_mux(alu_in[11:0], pc_mux_input1, IR_out[11:0], pcSRC, pc_mux_out);
      Memory my_memory(address_in,a_out, MemRead, MemWrite,clock, read_data_out,max,max_index);
      Reg_file my_register_file(3'b000, IR_out[11:9], write_reg_mux_out, write_data_mux_out, (RegWrite1 || RegWrite2), clock, rst, a_in, b_in);
	ALU my_alu(ALUop2, A_mux_out, B_mux_out, alu_in, Zero_out);
	sign_extend Sign_extend(IR_out[11:0], sign_extend_out);

endmodule
