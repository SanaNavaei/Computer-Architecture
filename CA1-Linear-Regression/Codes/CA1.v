`timescale 1ns/1ns
module CA(inx, iny, ei, clk, reset, start, ready, out_ready);
    input [19:0] inx, iny;
    input clk, reset, start;
    output[19:0] ei;
    output ready, out_ready;
    
    wire [19:0] outx, outy, outB0, outB1;
    wire [7:0] count_addr, add_w_count;
    wire write_en_x, write_en_y, end1, end2, end3, start1, start2, start3, load_x, load_xx, load_y, load_yy, load_sum_x, load_sum_y,
        init_sum_XR, init_sum_YR, load_min_x, load_min_y, load_ssXY, init_RssXY, load_ssXX, init_RssXX, load_b0, load_b1;
    
    data_Path1 data_loader(inx, iny, outx, outy, count_addr, add_w_count, clk,reset, write_en_x, write_en_y);
    controller_1 data_loader_c(start, clk, reset ,end1, end2, end3, write_en_x, write_en_y, ready, start1, start2, start3, add_w_count);
    data_path2 coefficient_calculator(outx, outy, clk, reset, load_x, load_y, load_sum_x, load_sum_y, init_sum_XR, init_sum_YR, load_min_x,
                                    load_min_y, load_ssXY, init_RssXY, load_ssXX, init_RssXX, load_b0, load_b1, outB0, outB1);
    controller_2 coefficient_calculator_c(start1, start2, clk, reset , init_sum_XR, init_sum_YR, init_RssXY, init_RssXX, load_x, load_y,
                                        load_sum_x, load_sum_y, load_min_x, load_min_y, load_ssXY, load_ssXX, load_b0, load_b1, end1, end2, count_addr);
    data_path3 Error_checker(outB0, outB1, outx, outy, clk, reset, load_xx, load_y, ei);
    controller_3 Error_checker_c(start3, clk, reset, end3, load_xx, load_yy, out_ready);

endmodule
