`timescale 1ns/1ns
module ALU (alu_operation, in_a, in_b, alu_result, zero);
    input [2:0] alu_operation;
    input [15:0] in_a, in_b;
    output [15:0] alu_result;
    output zero;

    wire [15:0] sub;
    assign sub = in_a - in_b;
    assign alu_result =
                        (alu_operation == 3'b000) ? 0 :
                        (alu_operation == 3'b001) ? in_a :
                        (alu_operation == 3'b010) ? in_b :
                        (alu_operation == 3'b011) ? ~in_b :
                        (alu_operation == 3'b100) ? in_a + in_b :
                        (alu_operation == 3'b101) ? sub :
                        (alu_operation == 3'b110) ? (in_a & in_b) :
                        (alu_operation == 3'b111) ? (in_a | in_b):0;
    assign zero = (alu_result == 16'd0) ? 1'b1 : 1'b0;

endmodule
