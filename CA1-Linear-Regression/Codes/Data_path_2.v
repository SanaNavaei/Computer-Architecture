module data_path2(inx, iny, clk, reset, load_x, load_y, load_sum_x, load_sum_y, init_sum_XR, init_sum_YR, load_min_x, load_min_y,
                    load_ssXY, init_RssXY, load_ssXX, init_RssXX, load_b0, load_b1, outB0, outB1);
    input clk, reset, load_x, load_y, load_sum_x, load_sum_y, init_sum_XR, init_sum_YR, load_min_x, load_min_y,
        load_ssXY, init_RssXY, load_ssXX, init_RssXX, load_b0, load_b1;
    input [19:0] inx, iny;
    output reg [19:0] outB0, outB1;

    wire [27:0] outx, outy, sum_xout, sum_yout, div_xout, div_yout, min_xout, min_yout, sub_xout, sub_yout;
    wire [63:0] ssXY_Rout, ssXY_Lout, ssXX_Rout, ssXX_Lout, out_fa_xy, out_fa_xx, b1;

    wire [19:0] b11;
    assign b11 = {b1[9:0],10'd0};

    wire [47:0] multi_b1_out;
    wire [27:0] multi_b11_out;
    assign multi_b11_out = multi_b1_out[37:10];

    wire [27:0] sub_b0_out;
    wire [19:0] sub_b00_out;
    assign sub_b00_out = sub_b0_out[19:0];

    wire [27:0] sign_extend_inx;
    assign sign_extend_inx = {{8{inx[19]}}, inx};

    wire [27:0] sign_extend_iny;
    assign sign_extend_iny = {{8{iny[19]}}, iny};

    wire [55:0] multi_xyout,multi_xxout;
    wire [63:0] sign_extend_multi_xyout;
    assign sign_extend_multi_xyout = {{8{multi_xyout[55]}}, multi_xyout};

    wire [63:0]sign_extend_multi_xxout;
    assign sign_extend_multi_xxout = {{8{multi_xxout[55]}}, multi_xxout};

    REG #(28) Rx(sign_extend_inx, clk, reset, load_x, 0, outx);
    REG #(28) Ry(sign_extend_iny, clk, reset, load_y, 0, outy);
    REG #(28) Rsum_x(out_fa_x, clk, reset, load_sum_x, init_sum_XR, sum_xout);
    REG #(28) Rsum_y(out_fa_y, clk, reset, load_sum_y, init_sum_YR, sum_yout);
    FA #(28) fa_x(outx, sum_xout, out_fa_x);
    FA #(28) fa_y(outy, sum_yout, out_fa_y);
    DIV150 #(28) div_x(sum_xout, div_xout);
    DIV150 #(28) div_y(sum_yout, div_yout);
    REG #(28) RXbar(div_xout, clk, reset, load_min_x, 0, min_xout);
    REG #(28) RYbar(div_yout, clk, reset, load_min_y, 0, min_yout);
    SUB #(28) sub_x(outx, min_xout, sub_xout);
    SUB #(28) sub_y(outy, min_yout, sub_yout);
    MULTI #(28,28) multi_xy(sub_yout, sub_xout, multi_xyout);
    MULTI #(28,28) multi_XX(sub_xout, sub_xout, multi_xxout);
    REG #( 64) RssXY(out_fa_xy, clk, reset, load_ssXY, init_RssXY, ssXY_Rout);
    REG #(64) RssXX(out_fa_xx, clk, reset, load_ssXX, init_RssXX, ssXX_Rout);
    FA #(64) fa_xy(sign_extend_multi_xyout, ssXY_Rout, out_fa_xy);
    FA #(64) fa_xx(sign_extend_multi_xxout, ssXX_Rout, out_fa_xx);
    DIV #(64) div_b1(ssXY_Rout, out_fa_xx,b1);
    REG #(20) RB1(b11, clk, reset, load_b1, 0, outB1);
    MULTI #(28,20) multi_b1(min_xout, outB1, multi_b1_out);
    SUB #(28) sub_b0(min_yout, multi_b11_out, sub_b0_out);
    REG #(20) RB0(sub_b00_out, clk, reset, load_b0, 0, outB0);

endmodule
