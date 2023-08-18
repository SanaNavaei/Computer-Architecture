`timescale 1ns/1ns
module data_mem (address, write_data, Memread, Memwrite, clk, read_data, max, max_index);
    input [31:0] address, write_data;
    input Memread, Memwrite, clk;
    output [31:0] read_data, max_index, max;
    
    reg [7:0] memory[0:65535];
    
    initial begin
        $readmemb("data_mem.mem", memory);
    end
    
    always @(posedge clk)
        if (Memwrite == 1'b1) begin
            {memory[address+3], memory[address+2], memory[address+1], memory[address]} = write_data;
        end
    
    assign read_data = (Memread == 1'b1) ? {memory[address], memory[address+1], memory[address+2], memory[address+3]} : 32'd0;
    assign max = {memory[2003], memory[2002], memory[2001], memory[2000]};
    assign max_index = {memory[2007], memory[2006], memory[2005], memory[2004]};

endmodule
