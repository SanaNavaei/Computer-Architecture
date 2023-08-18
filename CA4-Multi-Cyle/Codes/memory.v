`timescale 1ns/1ns
module Memory (address, write_data, Memread, Memwrite, clk, read_data, max, max_index);
    input Memread, Memwrite, clk;
    input [11:0] address;
    input [15:0] write_data;
    output [15:0] read_data, max_index, max;

    reg [15:0] memory[0:4095];
    initial begin
        $readmemb("memory.mem", memory);
    end
    
    always @(posedge clk)begin
        if (Memwrite == 1'b1) begin
            memory[address] = write_data;
        end
    end
    
    assign read_data = (Memread == 1'b1) ? memory[address] : 16'd0;
    assign max = memory[200];
    assign max_index = memory[204];

endmodule
