module forward_unit(rs_forwarding, rt_forwarding, reg_write_exmem, rd_forward_exmem, reg_write_memwb, rd_forward_memwb, selA, selB);
    input [4:0] rs_forwarding, rt_forwarding, rd_forward_exmem, rd_forward_memwb;
    input reg_write_exmem, reg_write_memwb;
    output reg [1:0] selA, selB;

    always @(rs_forwarding, rt_forwarding, reg_write_exmem, rd_forward_exmem, reg_write_memwb, rd_forward_memwb) begin
        selA = 2'b00;
        selB = 2'b00;
        if (rd_forward_exmem == rs_forwarding)
            if(rd_forward_memwb != 5'b0)
                if(reg_write_memwb)
                    if(!reg_write_exmem)
                        if(rd_forward_memwb == rs_forwarding)
                            if(rd_forward_exmem != 5'b0)
                                selA = 2'b01;
        if(rd_forward_exmem == rt_forwarding)
            if(rd_forward_memwb != 5'b00000)
                if(reg_write_memwb)
                    if(!reg_write_exmem)
                        if(rd_forward_memwb == rt_forwarding)
                            if(rd_forward_exmem != 5'b0)
                                selB = 2'b01;
        if (rd_forward_exmem == rs_forwarding)
            if(rd_forward_exmem != 5'b0)
                if(reg_write_exmem)
                    selA = 2'b10;
        
        if (rd_forward_exmem == rt_forwarding)
            if(rd_forward_exmem != 5'b0)
                if(reg_write_exmem)
                    selB = 2'b10;
    end

endmodule
