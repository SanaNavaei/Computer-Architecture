module data_path (clk, rst, reg_dst, mem_to_reg, alu_src, pc_src, alu_ctrl, reg_write, flush, mem_read, mem_write, selA, selB,
                 pc_load, IF_ID_load, sel_signal, instt, equal, mem_read_idex, rt_forwarding, rt_hazard, rs_hazard, rs_forwarding,
                 reg_write_exmem, rd_forward_exmem, reg_write_memwb, rd_forward_memwb, max, max_index);
    
    input  clk, rst, alu_src, reg_write, flush, mem_read, mem_write, pc_load, IF_ID_load, sel_signal;
    input [1:0] mem_to_reg, pc_src, selA, selB, reg_dst;
    input  [2:0] alu_ctrl;
    output equal, mem_read_idex, reg_write_exmem, reg_write_memwb;
    output [4:0] rt_forwarding, rt_hazard, rs_hazard, rs_forwarding, rd_forward_exmem, rd_forward_memwb;
    output [31:0] instt, max, max_index;

    wire reg_write_out3, reg_write_out1, mem_read_out1, mem_write_out1, alu_src_out1, alu_src_in1, reg_write_in1,mem_read_in1,
         mem_write_in1, mem_write_out2, mem_read_out2, reg_write_out2;
    wire [1:0] reg_dst_out1, mem_to_reg_out1, reg_dst_in1, mem_to_reg_in1, mem_to_reg_out2, mem_to_reg_out3;
    wire [2:0] aluop_out1, aluop_in1;
    wire [4:0] mux_reg_dst_out3, rt_out1, rd_out1, rs_out1, mux_reg_dst_out, mux_reg_dst_out2;
    wire [10:0] control_mux_out;
    wire [27:0] shift_out2;
    wire [31:0] pc_in, pc_out, addPCout, inst_out, inst, addPCout2, pc_2, read_data1, se_out, shift_out1, mem_to_reg_mux_out,
                read_data2, read_data1_out, read_data2_out, se_out2, addPCout3, alu_src_mux_in0, B, addr_in_mem, A, alu_result,
                addPCout4, write_data_mem, read_data_mem, mem_to_reg_mux_in0, alu_result2, addPCout5;

    register PC(pc_in, rst, pc_load, clk, pc_out);
    adder pc_adder(pc_out , 32'd4, addPCout);
    inst_memory inst_mem(pc_out, inst_out);
    regIF_ID IF_ID(clk, rst, IF_ID_load, flush, inst_out, addPCout, inst, addPCout2);
    assign instt = inst;
    assign rt_hazard = inst[20:16];
    assign rs_hazard = inst[25:21];
    MUX4to1 pcsrc_mux(addPCout, pc_2, {addPCout2[31:28], shift_out2}, read_data1, pc_src, pc_in);
    reg_file regfile(mem_to_reg_mux_out, inst[25:21], inst[20:16], mux_reg_dst_out3, reg_write_out3, rst, clk, read_data1, read_data2);
    assign equal = (read_data1 == read_data2);
    sign_extend se(inst[15:0], se_out);
    shl2 shifter1(se_out, shift_out1);
    adder pc_adder2(shift_out1, addPCout2, pc_2);
    shl2_26bit shifter2(inst[25:0], shift_out2);
    MUX2to1 #11 control_mux(11'b0, {alu_ctrl, alu_src, reg_write, reg_dst, mem_read, mem_write, mem_to_reg}, sel_signal, control_mux_out); 
    assign {aluop_in1, alu_src_in1, reg_write_in1, reg_dst_in1, mem_read_in1, mem_write_in1, mem_to_reg_in1} = control_mux_out;
    regID_EX ID_EX(clk, rst, aluop_in1, alu_src_in1, reg_write_in1, reg_dst_in1, mem_read_in1, mem_write_in1, mem_to_reg_in1,
                aluop_out1, alu_src_out1, reg_write_out1, reg_dst_out1, mem_read_out1, mem_write_out1, mem_to_reg_out1,
                read_data1, read_data2, se_out, inst[20:16], inst[15:11], inst[25:21], addPCout2,
                read_data1_out, read_data2_out, se_out2, rt_out1, rd_out1, rs_out1, addPCout3);
    assign rt_forwarding = rt_out1;
    assign rs_forwarding = rs_out1;
    assign mem_read_idex = mem_read_out1;
    MUX3to1 #32 Amux(read_data1_out, mem_to_reg_mux_out, addr_in_mem, selA, A);
    MUX3to1 #32 Bmux(read_data2_out, mem_to_reg_mux_out, addr_in_mem, selB, alu_src_mux_in0);
    MUX2to1 #32 alusrc_mux(alu_src_mux_in0, se_out2, alu_src_out1, B);
    MUX3to1 #5 regdst_mux(rt_out1, rd_out1, 5'b11111, reg_dst_out1, mux_reg_dst_out);
    alu ALU(A, B, aluop_out1, alu_result);
    regEX_MEM EX_MEM(clk, rst, mem_write_out1, mem_read_out1, mem_to_reg_out1, reg_write_out1,
                mem_write_out2, mem_read_out2, mem_to_reg_out2, reg_write_out2,
                addPCout3, alu_result, alu_src_mux_in0, mux_reg_dst_out, addPCout4,
                addr_in_mem, write_data_mem, mux_reg_dst_out2);
    data_memory my_data_mem(addr_in_mem, write_data_mem, mem_read_out2, mem_write_out2, clk, read_data_mem, max, max_index);
    assign rd_forward_exmem = mux_reg_dst_out2;
    assign reg_write_exmem = reg_write_out2;
    regMEM_WB MEM_WB(clk, rst, mem_to_reg_out2, reg_write_out2, mem_to_reg_out3, reg_write_out3,
                     read_data_mem, addr_in_mem, mux_reg_dst_out2, addPCout4, mem_to_reg_mux_in0,
                     alu_result2, mux_reg_dst_out3, addPCout5);
    MUX3to1 #32 memtoreg_mux(alu_result2, mem_to_reg_mux_in0, addPCout5, mem_to_reg_out3, mem_to_reg_mux_out);
    assign reg_write_memwb = reg_write_out3;
    assign rd_forward_memwb = mux_reg_dst_out3;
    
endmodule
