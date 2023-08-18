`timescale 1ns/1ns
module controller_3(start3, clk, reset, end3, load_x, load_y, out_ready);
    input start3, clk, reset;
    output reg end3, load_x, load_y, out_ready;

    wire co;
    reg init_c, cen;
    reg [7:0] count;
    parameter[2:0] Idle = 0, Load = 1, Loadx = 2, Count = 3, End1 = 4;
    reg[2:0] ps, ns;

    always@(ps, co, start3)begin
        ns = Idle;
        {init_c, cen, end3, load_x, load_y, out_ready} = 6'b0;
        case(ps)
            Idle: begin ns = start3 ? Load : Idle; init_c = 1;end
            Load: begin ns = Loadx; cen = 1;end
            Loadx: begin ns = Count; load_x = 1;load_y = 1;end
            Count: begin ns = co ? End1 : Loadx; cen = 1; out_ready = 1;end
            End1: begin ns = Idle; end3 = 1;end
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
