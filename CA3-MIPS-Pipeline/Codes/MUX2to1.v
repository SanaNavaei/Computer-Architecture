module MUX2to1 #(parameter size = 0) (a, b, s, out_mux);
    input [size-1:0] a, b;
    input s;
    output [size-1:0] out_mux;

    assign out_mux = s ? b : a;

endmodule
