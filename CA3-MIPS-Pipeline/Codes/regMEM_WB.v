module regMEM_WB(clk, rst, mem_to_reg_in, reg_write_in, mem_to_reg_out, reg_write_out,
                  read_data_in, alu_in, mux_reg_dst_in, addPCin, read_data_out, alu_out, mux_reg_dst_out, addPCout);
    input clk, rst, reg_write_in;
    input [1:0] mem_to_reg_in;
    input [4:0] mux_reg_dst_in;
    input [31:0] read_data_in, alu_in, addPCin;
    output reg reg_write_out;
    output reg [1:0] mem_to_reg_out;
    output reg [4:0] mux_reg_dst_out;
    output reg [31:0] read_data_out, addPCout, alu_out;
    
    always @(posedge clk)
        if (rst) {mem_to_reg_out, reg_write_out, read_data_out, alu_out, mux_reg_dst_out, addPCout} <= 104'b0;
        else
                 {mem_to_reg_out, reg_write_out, read_data_out, alu_out, mux_reg_dst_out, addPCout} <=
                 {mem_to_reg_in, reg_write_in, read_data_in, alu_in, mux_reg_dst_in, addPCin};

endmodule
