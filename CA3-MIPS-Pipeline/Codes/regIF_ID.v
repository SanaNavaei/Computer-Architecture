module regIF_ID(clk, rst, load, flush, inst, addPCin, inst_out, addPCout);
    input clk, rst, load, flush;
    input [31:0] inst, addPCin;
    output reg [31:0] inst_out, addPCout;

    always @(posedge clk)begin
        if (flush) inst_out <= 32'd0;
        else if (rst) begin inst_out <= 32'd0; addPCout <= 32'd0; end
        else if (load) begin inst_out <= inst; addPCout <= addPCin; end
    end

endmodule
