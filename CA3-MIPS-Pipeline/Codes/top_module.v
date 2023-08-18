module top_module(clk, rst, max, max_index);
    input clk, rst;
    output[31:0] max, max_index;

    wire alu_src, reg_write, flush, mem_read, mem_write, pc_load, IF_ID_load, sel_signal, equal, mem_read_idex,
         reg_write_exmem, reg_write_memwb;
    wire [1:0] reg_dst, mem_to_reg, pc_src, selA, selB;
    wire [2:0] aluop;
    wire [4:0] rt_forwarding, rt_hazard, rs_hazard, rs_forwarding, rd_forward_exmem, rd_forward_memwb;
    wire [31:0] instt;

    data_path DataPath(clk, rst, reg_dst, mem_to_reg, alu_src, pc_src, aluop, reg_write, flush, mem_read, mem_write, selA, selB, pc_load,
                IF_ID_load, sel_signal, instt, equal, mem_read_idex, rt_forwarding, rt_hazard, rs_hazard, rs_forwarding,
                reg_write_exmem, rd_forward_exmem, reg_write_memwb, rd_forward_memwb, max, max_index);
    
    controller Controller(instt, reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pc_src, aluop, flush, equal);
    
    hazard_unit h_unit(mem_read_idex, rt_forwarding, rs_hazard, rt_hazard, sel_signal, IF_ID_load, pc_load);
    
    forward_unit f_unit(rs_forwarding, rt_forwarding, reg_write_exmem, rd_forward_exmem, reg_write_memwb, rd_forward_memwb, selA, selB);

endmodule
