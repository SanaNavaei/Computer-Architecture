module alu_control (aluop, func, operation);
    input [1:0] aluop;
    input [5:0] func;
    output reg [2:0] operation;

    parameter[2:0] Add = 3'b010, Sub = 3'b110, And = 3'b000, Or = 3'b001, Slt = 3'b111;
    always @(aluop, func)begin
        operation = 3'b000;
        if (aluop == 2'b00) operation = Add;
        else if (aluop == 2'b01) operation = Sub;
        else if (aluop == 2'b11) operation = Slt;
        else
            case (func)
                6'b100000: operation = Add;
                6'b100011: operation = Sub;
                6'b100100: operation = And;
                6'b100101: operation = Or;
                6'b101010: operation = Slt;
                default: operation = And;
            endcase
    end

endmodule
