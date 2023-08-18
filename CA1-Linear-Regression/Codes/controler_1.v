`timescale 1ns/1ns
module controller_1(start,clk,reset ,end1,end2,end3,write_x,write_y,ready,start1,start2,start3,count);
    input start, clk, reset, end1, end2, end3;
    output reg write_x, write_y, ready, start1, start2, start3;
    output reg [7:0] count;

    wire co;
    reg c_rst, cen;
    parameter[3:0] Idle = 0, Initial = 1, Load = 2, Count = 3, Start1 = 4 ,End1 = 5, Start2 = 6, End2 = 7, Start3 = 8, End3 = 9;
    reg[3:0] ps, ns;

    always@(ps, co, start, end1, end2) begin
        ns = Idle;
        {c_rst, write_x, write_y, ready, cen, start1, start2, start3} = 8'b0;
        case(ps)
            Idle: ns = start?Initial : Idle;
            Initial: begin ns = Load; c_rst = 1; ready = 1;end
            Load: begin ns = Count; write_x = 1; write_y = 1;end
            Count: begin ns = co? Start1 : Load; cen = 1;end
            Start1: begin ns = End1; cen =1; start1 = 1;end
            End1: begin ns = end1 ? Start2 : End1;end
            Start2: begin ns = End2; cen = 1; start2 = 1;end
            End2: begin ns = end2 ? Start3 : End2;end
            Start3: begin ns = End3; cen = 1; start3 =1;end
            End3: ns = end3 ? Idle : End3;
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
        else if (c_rst)
            count <= 7'b1101010;
        else if (cen)
            count <= count + 1 ;
    end
    assign co = &count;

endmodule
