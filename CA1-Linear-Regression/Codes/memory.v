`timescale 1ns/1ns
module Memory(in_a, out_a, R_address, W_address, clk, write_en);
    input[19:0] in_a;
    input [7:0] W_address, R_address;
    input clk, write_en;
    output [19:0] out_a;
    
    reg [19:0] memory [0:149];
    reg [7:0] w_addr, r_addr;
    assign w_addr = W_address - 8'd106;
    assign r_addr = R_address - 8'd106;
    assign out_a = memory[r_addr];

    always @(posedge clk) begin
        if (write_en)
            memory[w_addr] <= in_a;
    end

endmodule
