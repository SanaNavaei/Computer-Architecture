module alu(A, B, alu_operation, alu_out, Zero);
    input [31:0] A, B;
    input [2:0] alu_operation;
    output reg[31:0] alu_out;
    output Zero;

    wire [31:0] SUB;
    assign SUB = A - B;

    always@(alu_operation, SUB)begin
        case(alu_operation)
            3'b000: alu_out = A & B;
            3'b001: alu_out = A | B;
            3'b010: alu_out = A + B;
            3'b110: alu_out = A - B;
            3'b111: begin  alu_out = (SUB[31]) ? 32'd1 : 32'b0; end
            default alu_out = A - B;
        endcase
    end

    assign Zero = (alu_out == 32'd0) ? 1'b1 : 1'b0;
    
endmodule
