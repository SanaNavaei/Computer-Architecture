`timescale 1ns/1ns
module controller(clock, rst, inst, Zero_out, pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRWrite, RegDst1, MemToReg, RegWrite1,
				  ALUsrc_A, RegDst2, RegWrite2, ALUop2, ALUsrc_B, pcSRC, IRwrite);
	input clock, rst, Zero_out;
	input [15:0] inst;
	output reg pcWrite, pcWriteCtrl, Zero_in, IorD, MemWrite, MemRead, IRWrite, RegDst1, MemToReg, RegWrite1, ALUsrc_A, RegDst2, RegWrite2, IRwrite;
	output reg[1:0] ALUsrc_B, pcSRC;
	output [2:0] ALUop2;

	parameter[3:0] IF = 4'b0000, ID = 4'b0001, JUMP = 4'b0010, STORE = 4'b0011, LOAD1 = 4'b0100, LOAD2 = 4'b0101, BRANCH = 4'b0110,
				   DTYPE = 4'b0111, D1 = 4'b1000, CTYPE = 4'b1001, CTYPE1 = 4'b1010;
	parameter[1:0] Atype=2'b00, Btype=2'b01, Ctype=2'b10, Dtype=2'b11;
	parameter[1:0] Load=2'b00, Store=2'b01, Jump=2'b10;
	
	reg [2:0] ALUop;
	reg [3:0] ps, ns, opcode;
	alu_control alu_c(inst[8:0], ALUop, ALUop2);
	assign opcode = inst[15:12];

	always@(ps, inst[7], opcode, Zero_out, inst[0])begin
		{IorD, MemRead, IRwrite, RegDst1, RegWrite1, MemToReg, MemWrite, pcSRC, pcWrite, ALUsrc_A, ALUsrc_B, ALUop, pcWriteCtrl, Zero_in,
        RegWrite2, RegDst2}=20'd0;

		case(ps)
			IF: begin ns = ID; IorD = 0; MemRead = 1; IRwrite = 1; ALUsrc_A = 0; ALUsrc_B = 2'b10; ALUop = 3'b100; pcSRC = 2'b00; pcWrite = 1;end
			ID: begin case(opcode[3:2])
				Atype:begin
					case(opcode[1:0])
						Load: ns = LOAD1;
						Store: ns = STORE;
						Jump: ns = JUMP;
					endcase
				end
				Btype: ns = BRANCH;
				Ctype: ns = inst[7] ? IF : CTYPE;
				Dtype: ns = DTYPE;
				endcase
			end
			LOAD1: begin ns = LOAD2; IorD = 1; MemRead = 1;end
			LOAD2: begin ns = IF; RegDst1 = 0; RegWrite1 = 1; MemToReg = 1;end
			STORE: begin ns = IF; IorD = 1; MemWrite = 1;end
			JUMP: begin ns = IF; pcSRC = 2'b10; pcWrite = 1;end
			BRANCH: begin ns = IF; ALUsrc_A = 1; ALUsrc_B = 2'b00; ALUop = 3'b101; pcWriteCtrl = 1; pcSRC = 2'b01; Zero_in = Zero_out;end
			CTYPE: begin ns = CTYPE1; ALUsrc_A = 1; ALUsrc_B = 2'b00; ALUop = 3'b000;end
			CTYPE1: begin ns = IF; MemToReg = 0; RegWrite2 = 1; RegDst2 = inst[0];end
			DTYPE: begin ns = D1; ALUsrc_B = 2'b01; ALUsrc_A = 1; ALUop = opcode[2:0];end
			D1: begin ns = IF; RegDst1 = 0; MemToReg = 0; RegWrite1 = 1;end
		endcase
	end

	always@(posedge clock, posedge rst)begin
		if(rst)
			ps <= IF;
		else
			ps <= ns;
	end
	
endmodule
