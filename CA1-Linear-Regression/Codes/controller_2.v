`timescale 1ns/1ns
module controller_2(start1, start2, clk, reset, init_sum_XR, init_sum_YR, init_RssXY, init_RssXX, load_x, load_y, load_sum_x, load_sum_y,
                    load_min_x, load_min_y, load_ssXY, load_ssXX, load_b0, load_b1, end1, end2, count);
    input start1, start2, clk, reset;
    output reg init_sum_XR, init_sum_YR, init_RssXY, init_RssXX, load_x, load_y, load_sum_x, load_sum_y, load_min_x, load_min_y, load_ssXY,
                load_ssXX, load_b0, load_b1, end1, end2;
    output reg [7:0] count = 8'd0;

    wire co;
    reg init_c, cen;
    parameter[3:0] Idle = 0, Initial = 1, Loadx = 2, Count1 = 3, End1 = 4, Start2 = 5 , Loadxx = 6, Count2 = 7, End2 = 8, EndT = 9;
    reg[3:0] ps, ns;

    always@(ps, co, start1, start2)begin
        ns = Idle;
        {init_sum_XR, init_sum_YR, init_RssXY, init_RssXX, load_x, load_y, load_sum_x, load_sum_y, load_min_x, load_min_y, load_ssXY, load_ssXX, load_b0, load_b1, end1, end2} = 16'b0;
        case(ps)
            Idle: begin ns = start1 ? Initial : Idle; init_c = 1;end
            Initial: begin ns = Loadx; init_sum_XR = 1; init_sum_YR = 1; init_RssXY = 1; init_RssXX = 1; cen = 1;end
            Loadx: begin ns = Count1; load_x = 1; load_y = 1;end
            Count1 : begin ns = co? End1 : Loadx; load_sum_x = 1; load_sum_y = 1; cen = 1;end
            End1: begin ns = Start2; end1 = 1; load_min_x = 1; load_min_y = 1; init_c = 1;end
            Start2 : begin ns = start2 ? Loadxx : Start2; cen = 1;end
            Loadxx: begin ns = Count2; load_x = 1; load_y = 1;end
            Count2: begin ns= co ? End2 : Loadxx; load_ssXY = 1; load_ssXX = 1; cen = 1;end
            End2 : begin ns = EndT; end2 = 1; load_b1 = 1;end
            EndT : begin ns = Idle; load_b0 = 1;end
        endcase
    end

    always @(posedge clk, posedge reset)begin
            if(reset)
                ps <= Idle;
            else
                ps <= ns;
    end

    always @(posedge clk, posedge reset)begin
        if (reset)
            count <= 7'b1101010;
        else if (init_c)
            count <= 7'b1101010;
        else if (cen)
            count <= count + 1 ;
    end

    assign co = &count;

endmodule
