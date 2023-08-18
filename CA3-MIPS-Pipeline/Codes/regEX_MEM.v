module regEX_MEM(clk, rst, mem_write_in, mem_read_in, mem_to_reg_in,reg_write_in, mem_write_out, mem_read_out, mem_to_reg_out, reg_write_out,
                  addPCin, alu_in, muxB_in, mux_reg_dst_in, addPCout, alu_out, muxB_out, mux_reg_dst_out);
    input clk, rst, reg_write_in, mem_read_in, mem_write_in;
    input [1:0] mem_to_reg_in;
    input [4:0] mux_reg_dst_in;
    input [31:0] addPCin, alu_in, muxB_in;
    output reg reg_write_out, mem_read_out, mem_write_out;
    output reg [1:0] mem_to_reg_out;
    output reg [4:0] mux_reg_dst_out;
    output reg [31:0] addPCout, alu_out, muxB_out;

    always @(posedge clk)
        if (rst)
            {mem_write_out, mem_read_out, mem_to_reg_out, reg_write_out, addPCout, alu_out, muxB_out, mux_reg_dst_out} <= 106'b0;
        else
            {mem_write_out, mem_read_out, mem_to_reg_out, reg_write_out, addPCout, alu_out, muxB_out, mux_reg_dst_out} <=
            {mem_write_in, mem_read_in, mem_to_reg_in, reg_write_in, addPCin, alu_in, muxB_in, mux_reg_dst_in};

endmodule
