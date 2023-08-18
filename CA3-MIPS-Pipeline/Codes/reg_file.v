module reg_file (write_data, read_reg1, read_reg2, write_reg, reg_write, rst, clk, read_data1, read_data2);
    input[31:0] write_data;
    input[4:0] read_reg1, read_reg2, write_reg;
    input reg_write, rst, clk;
    output[31:0] read_data1, read_data2;
    reg[31:0] reg_mem[0:31];

    integer k;
    always @(posedge clk)begin
        if (rst)
            for (k = 0; k < 32 ; k = k + 1) reg_mem[k] <= 32'd0;
        else if (reg_write && write_reg != 5'd0)
            reg_mem[write_reg] <= write_data;
    end
    
    assign read_data1 = (read_reg1 == 5'b0) ? 32'd0 : reg_mem[read_reg1];
    assign read_data2 = (read_reg2 == 5'b0) ? 32'd0 : reg_mem[read_reg2];

endmodule
