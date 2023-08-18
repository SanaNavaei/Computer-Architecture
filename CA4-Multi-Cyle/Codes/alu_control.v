`timescale 1ns/1ns
module alu_control(alu_function, ALUop, ALUop_out);
    input [8:0] alu_function;
    input [2:0] ALUop;
    output reg [2:0] ALUop_out;

	parameter[2:0]Add = 9'b000000100, Sub = 9'b000001000, And = 9'b000010000, OR = 9'b000100000, Aout = 9'b000000001, Bout = 9'b000000010, Not_B = 9'b001000000;

	always@(alu_function, ALUop)begin
		ALUop_out = 3'd0;
		if(ALUop == 3'b100) ALUop_out = 3'b100;
	    else if(ALUop == 3'b101) ALUop_out = 3'b101;
        else if(ALUop == 3'b110) ALUop_out = 3'b110;
        else if(ALUop == 3'b111) ALUop_out = 3'b111;
		else if(ALUop == 3'b000)begin
			case(alu_function)
				Add:  ALUop_out = 3'b100;
	            Sub:  ALUop_out = 3'b101;
                And:  ALUop_out = 3'b110;
                OR:  ALUop_out = 3'b111;
                Aout:  ALUop_out = 3'b001;
                Bout:  ALUop_out = 3'b010;
                Not_B:  ALUop_out = 3'b011;
			endcase
		end
	end

endmodule
