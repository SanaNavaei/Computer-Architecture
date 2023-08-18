`timescale 1ns/1ns
module data_path3(B0, B1, inx3, iny3, clk, reset, load_x, load_y, ei);
    input clk, reset, load_x, load_y;
    input [19:0] B0, B1, inx3, iny3;
    output[19:0] ei;
    
    wire [19:0] outx, outy, multi_xb1_out_real, out_fa_b0_xb1;
    wire [39:0] multi_xb1_out;

    assign multi_xb1_out_real = {10'd0, multi_xb1_out[19:10]};
    REG #(20) Rx(inx3, clk, reset, load_x, 0, outx);
    MULTI #(20,20) multi_xb1(outx, B1, multi_xb1_out);
    FA #(20) fa_b0_xb1(multi_xb1_out_real, B0, out_fa_b0_xb1);
    REG #(20) Ry(iny3, clk, reset, load_y, 0, outy);
    SUB #(20) sub_ei(outy, out_fa_b0_xb1, ei);

endmodule
