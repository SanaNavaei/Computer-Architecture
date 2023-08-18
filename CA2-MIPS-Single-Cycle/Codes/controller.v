module Controller(x, opcode, func, zero, ALUoperation, pcsrc, regWrite, Memread, Memwrite, ALUsrc, MemtoReg, jmp1, jmp2,regDst1, regDst2, write1, write2,out_x);
	input xو zero;
	input[5:0] opcode, func;
	output[2:0] ALUoperation;
	output pcsrc;
	output reg regWrite, Memread, Memwrite, ALUsrc, MemtoReg, jmp1, jmp2, regDst1, regDst2, write1 ,write2;
	output reg [31:0]out_x;

	reg branch;
	reg[1:0] alu_in;
	parameter[3:0] Rtype = 6'b000000, Addi = 6'b001001, Lw = 6'b100011, Sw = 6'b101011, Jump = 6'b000010,
					Jr = 6'b000110, Jal = 6'b000011, beq = 6'b000100, slti = 6'b001010;
	ALU_Controller alucontroller(func, alu_in, ALUoperation);

	always@(opcode)begin
		alu_in = 2'd0; regWrite = 1'd0; Memread = 1'd0; Memwrite = 1'd0; ALUsrc = 1'd0; MemtoReg = 1'd0;
		jmp1 = 1'd0; jmp2 = 1'd0; regDst1 = 1'd0; regDst2 = 1'd0; write1 = 1'd0; write2 = 1'd0; branch = 1'd0;
		case(opcode)
			Rtype: begin{regDst1, regDst2, write1, ALUsrc, jmp1, alu_in, Memread, Memwrite, MemtoReg, regWrite, branch} = 12'b101011000010;write2 = func?1:0;end
			Addi: {regDst1, regDst2, write2, ALUsrc, jmp1, alu_in, Memread, Memwrite, MemtoReg, regWrite, branch} = 12'b001110000010;
			Lw: {regDst1, regDst2, write2, ALUsrc, jmp1, alu_in, Memread, Memwrite, MemtoReg, regWrite, branch} = 12'b001110010110;
			Sw: {ALUsrc, jmp1, alu_in, Memread, Memwrite, regWrite, branch} = 8'b11000100;
			Jump: {jmp2, jmp1, Memread, Memwrite, regWrite, branch} = 6'b000000;
			Jr: {jmp2, jmp1, Memread, Memwrite, regWrite, branch} = 6'b100000;
			Jal: {regDst2, write1, write2, jmp2, jmp1, Memread, Memwrite, regWrite, branch} = 9'b100000010;
			beq: {ALUsrc, jmp1, alu_in, Memread, Memwrite, regWrite, branch} = 8'b01010001;
			slti: {regDst1, regDst2, write1, write2, ALUsrc, jmp1, alu_in, Memread, Memwrite, regWrite, branch} = 12'b001011110010;
		endcase
	end
	assign pcsrc = branch&zero;
	assign out_x = {31'b0,x};

endmodule
