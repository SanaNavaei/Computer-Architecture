module inst_memory (address, inst);
    input [31:0] address;
    output [31:0] inst;
    
    reg [7:0] memory[0:65535];
    initial $readmemb("inst_mem.mem", memory);

    assign inst = {memory[address[15:0] + 0], memory[address[15:0] + 1], memory[address[15:0] + 2], memory[address[15:0] + 3]};

endmodule
