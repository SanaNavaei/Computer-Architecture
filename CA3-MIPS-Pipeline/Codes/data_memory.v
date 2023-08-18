module data_memory (address, write_data, mem_read, mem_write, clk, read_data, max, max_index);

    input mem_read, mem_write, clk;
    input [31:0] address, write_data;
    output [31:0] max_index, max;
    output reg[31:0] read_data;

    reg [7:0] memory[0:65535];

    initial $readmemb("data_mem.mem", memory);

    assign max = {memory[2000], memory[2001], memory[2002], memory[2003]};
    assign max_index = {memory[2004], memory[2005], memory[2006], memory[2007]};
    
    always @(posedge clk)
        if (mem_write == 1'b1) {memory[address+0], memory[address+1], memory[address+2], memory[address+3]} = write_data;

    always@(mem_read)begin
        read_data = 32'b0;
        if(mem_read)
            read_data = {memory[address+0], memory[address+1], memory[address+2], memory[address+3]};
        else
            read_data = 32'b0;
    end

endmodule
