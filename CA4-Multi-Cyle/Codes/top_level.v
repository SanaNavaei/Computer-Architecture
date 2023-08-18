`timescale 1ns/1ns
module top_level(clock, rst, max, max_index);
	input clock, rst;
	output [15:0] max, max_index;

	wire[15:0] inst;
	wire Zero_out, Zero_in;
	wire pcWrite, pcWriteCtrl, IorD, MemWrite, MemRead, IRwrite, RegDst1, RegDst2, MemToReg, RegWrite1, RegWrite2, ALUsrc_A;
	wire[1:0] ALUsrc_B, pcSRC;
	wire[2:0] ALUop2;

	controller CU(clock, rst, inst, Zero_out, pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRWrite, RegDst1, MemToReg,
				RegWrite1, ALUsrc_A, RegDst2, RegWrite2, ALUop2, ALUsrc_B, pcSRC, IRwrite);
	data_path DataPath(clock, rst, pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRwrite, pcSRC, RegDst1, RegDst2, MemToReg,
				RegWrite1, RegWrite2, ALUsrc_A, ALUsrc_B, ALUop2, Zero_out, max, max_index, inst);

endmodule
