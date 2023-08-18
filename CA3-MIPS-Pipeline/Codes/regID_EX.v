module regID_EX(clk, rst, alu_function_in, alu_src_in, reg_write_in, reg_dst_in, mem_read_in, mem_write_in, mem_to_reg_in,
                 alu_function_out, alu_src_out, reg_write_out, reg_dst_out, mem_read_out, mem_write_out, mem_to_reg_out,
                 read_data1, read_data2, sign_extend, rt, rd, rs, addPCin, read_data1_out, read_data2_out, sign_extend_out,
                 rt_out, rd_out, rs_out, addPCout);

    input clk, rst, mem_read_in, mem_write_in, alu_src_in, reg_write_in;
    input [1:0] reg_dst_in,mem_to_reg_in;
    input [2:0] alu_function_in;
    input [4:0] rt, rd, rs;
    input [31:0] read_data1, read_data2, sign_extend, addPCin;
    output reg alu_src_out, mem_read_out, mem_write_out, reg_write_out;
    output reg [1:0] reg_dst_out, mem_to_reg_out;
    output reg [2:0] alu_function_out;
    output reg [4:0] rt_out, rd_out, rs_out;
    output reg [31:0] read_data1_out, read_data2_out, sign_extend_out, addPCout;

    always @(posedge clk) begin
        if (rst)
            {read_data1_out, read_data2_out, sign_extend_out, addPCout, rt_out, rd_out, rs_out,
             alu_function_out, alu_src_out, reg_write_out, reg_dst_out, mem_read_out, mem_write_out, mem_to_reg_out} <= 154'b0;
        else
            {read_data1_out, read_data2_out, sign_extend_out, addPCout, rt_out, rd_out, rs_out,
             alu_function_out, alu_src_out, reg_write_out, reg_dst_out, mem_read_out, mem_write_out, mem_to_reg_out} <=
            {read_data1, read_data2, sign_extend, addPCin,rt, rd, rs, alu_function_in, alu_src_in, reg_write_in,
             reg_dst_in, mem_read_in, mem_write_in, mem_to_reg_in};
    end

endmodule
