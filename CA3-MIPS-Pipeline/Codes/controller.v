module controller(inst, reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop_out, Flush, Equal);
    input Equal;
    wire[5:0] opcode, func;
    input[31:0] inst;
    assign opcode = inst[31:26];
    assign func = inst[5:0];
    output reg reg_write, alu_src, mem_read, mem_write, Flush;
    output reg [1:0] pcsrc, mem_to_reg, reg_dst;
    output [2:0] aluop_out;

    reg [1:0] aluop;
    always @(opcode)begin
        {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush} = {2'b00, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 1'b0};
        case (opcode)
            6'b000000 : {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b01, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00, 2'b10, 1'b0};
            6'b100011 : {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b01, 1'b1, 1'b1, 1'b1, 1'b0, 2'b00, 2'b00, 1'b0};
            6'b101011 : {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b0, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 1'b0};
            6'b000100 : {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, {1'b0,Equal}, 2'b00, Equal};
            6'b001001: {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 2'b00, 1'b0};
            6'b000010: {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 2'b00, 1'b1};
            6'b000011:{reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b10, 2'b10, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 2'b00, 1'b0};
            6'b000110: {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b11, 2'b00, 1'b0};
            6'b001010:{reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pcsrc, aluop, Flush}
                       = {2'b00, 2'b00, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 2'b11, 1'b0};
            6'b111111: pcsrc = 2'b00;
        endcase
    end

    alu_control alu_c(aluop, func, aluop_out);

endmodule
