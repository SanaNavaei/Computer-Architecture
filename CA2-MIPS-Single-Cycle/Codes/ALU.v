`timescale 1ns/1ns
module ALU (alu_operation, in_a, in_b, alu_result, zero);
    input [2:0] alu_operation;
    input [31:0] in_a, in_b;
    output [31:0] alu_result;
    output zero;

    wire [31:0] sub;
    assign sub = in_a - in_b;
    assign alu_result =
                        (alu_operation == 3'b000) ? (in_a & in_b) :
                        (alu_operation == 3'b001) ? (in_a | in_b) :
                        (alu_operation == 3'b010) ? (in_a + in_b) :
                        (alu_operation == 3'b011) ? sub : 1000;
    assign zero = (alu_result == 32'd0) ? 1'b1 : 1'b0;

endmodule
