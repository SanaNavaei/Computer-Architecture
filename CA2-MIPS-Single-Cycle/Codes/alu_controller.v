module ALU_Controller(func, ALU_in, ALU_operation);
	input[5:0] func;
	input[1:0] ALU_in;
	output reg[2:0] ALU_operation;

	parameter[1:0]Add = 6'b100000, Subtract = 6'b100011, And = 6'b100100, Or = 6'b100101;
	always@(func, ALU_in)begin
		ALU_operation = 3'd0;
		if(ALU_in == 2'd0) ALU_operation = 3'b010;
		else if(ALU_in == 2'd1) ALU_operation = 3'b011;
		else if(ALU_in == 2'd2)begin
			case(func)
				Add: ALU_operation = 3'b010;
                Subtract: ALU_operation = 3'b011;
                And: ALU_operation = 3'b000;
                Or: ALU_operation = 3'b001;
				default ALU_operation = 3'b011;
			endcase
		end
		else if(ALU_in == 2'd3) ALU_operation = 3'b011;
		else ALU_operation = 3'b111;
	end

endmodule
