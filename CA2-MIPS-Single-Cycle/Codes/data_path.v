module Datapath(in_x,clock, rst, write1, write2, regWrite, MemtoReg, ALUsrc, pcsrc, jmp1, jmp2, regDst1, regDst2, Inst, ALUopc,
				Inst_address, zero, bit31alu, Memread, Memwrite, max, max_index);
	input clock, rst, Memwrite, Memread, write1, write2, regWrite, MemtoReg, ALUsrc, pcsrc, jmp1, jmp2, regDst1, regDst2;
	input [2:0] ALUopc;
	input [31:0] in_x, Inst;
	output[31:0] max, max_index, Inst_address;
	output zero, bit31alu;

	wire[31:0] MUX3_out, MUX4_out, MUX5_out, MUX6_out, MUX7_out, MUX8_out, MUX9_out;
	wire[31:0] input0, adder1_out, read_data1, read_data2, pc_out, sign_out, ALU_out, adder2_out, shl2_out, Data_mem_in, Data_mem_out;
	wire[27:0] shift_out;
	wire[4:0] MUX1_out, MUX2_out;

	assign bit31alu = ALU_out[31];
	assign Inst_address = pc_out;
	Register PC(clock, rst, 1'b1, MUX8_out, pc_out);
	adder_32b adder1(pc_out, 32'd4, 1'b0, , adder1_out);
	MUX2to1#(5) MUX1(Inst[20:16], Inst[15:11], regDst1, MUX1_out);
	MUX2to1#(5) MUX2(MUX1_out, 5'b11111, regDst2, MUX2_out);
	MUX2to1#(32) MUX3(adder1_out, in_x, write1, MUX3_out);
	MUX2to1#(32) MUX4(MUX3_out, MUX6_out, write2, MUX4_out);
	Register_file regfile(Inst[25:21], Inst[20:16], MUX2_out, MUX4_out, regWrite, clock, rst, read_data1, read_data2);
	sign_extend#(16) sgn_extnd(Inst[15:0], sign_out);
	MUX2to1#(32) MUX5(read_data2, sign_out, ALUsrc, MUX5_out);
	ALU alu1(ALUopc, read_data1, MUX5_out, ALU_out, zero);
	Shift shift1(Inst[25:0], shift_out);
	Shl2 shl2_1(sign_out, shl2_out);
	adder_32b adder2(adder1_out, shl2_out, 1'b0, ,adder2_out);
	MUX2to1#(32) MUX7(adder1_out, adder2_out, pcsrc, MUX7_out);
	assign input0 = {adder1_out[31:28], shift_out};
	MUX2to1#(32) MUX9(input0, read_data1, jmp2, MUX9_out);
	MUX2to1#(32) MUX8(MUX9_out, MUX7_out, jmp1, MUX8_out);
	assign Data_mem_in = ALU_out;
	MUX2to1#(32) MUX6(ALU_out, Data_mem_out, MemtoReg, MUX6_out);
	data_mem my_mem(Data_mem_in, read_data2, Memread, Memwrite, clock, Data_mem_out, max, max_index);

endmodule
