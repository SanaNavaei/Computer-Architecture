module inst_mem (address, Inst);
    input [31:0] address;
    output [31:0] Inst;
    reg [7:0] memory[0:65535];

    initial begin
        $readmemb("inst_mem8.mem", memory);
    end
    
    assign Inst = {memory[address[15:0]], memory[address[15:0]+1], memory[address[15:0]+2], memory[address[15:0]+3]};
    
endmodule
