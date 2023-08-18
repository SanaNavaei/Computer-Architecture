module hazard_unit(mem_read_idex, rt_forwarding, rs_hazard, rt_hazard, sel_signal, IF_ID_load, pc_load);
    input mem_read_idex;
    input [4:0] rt_forwarding, rs_hazard, rt_hazard;
    output reg sel_signal, IF_ID_load, pc_load;

    always @(mem_read_idex, rt_forwarding, rs_hazard, rt_hazard) begin
        sel_signal = 1'b1;
        IF_ID_load = 1'b1;
        pc_load = 1'b1;
        if (((rt_forwarding == rt_hazard) || (rt_forwarding == rs_hazard)))
            if(mem_read_idex)begin
                sel_signal = 1'b0;
                IF_ID_load = 1'b0;
                pc_load = 1'b0;
            end
    end

endmodule
