`timescale 1ns/1ns
module TB();
        reg [19:0] mem_x [0:149];
        reg [19:0] mem_y [0:149];
        reg [19:0] mem_error[0:149];
        reg start = 0, clk = 0, reset;
        wire ready, error_ready;
        reg [19:0] in_x, in_y;
        wire [19:0] error_out;
        integer i, f, j;

        initial $readmemb ("x_value.txt", mem_x);
        initial $readmemb ("y_value.txt", mem_y);
        CA CUT(in_x, in_y, error_out, clk, reset, start, ready, error_ready);

        always #20 clk = ~clk;
        initial begin
            #20 start = 1;
            #40 while (~ready) #20;
            
            for(j = 0; j < 150; j = j + 1)begin
                #40;
                in_x = mem_x[j];
                in_y = mem_y[j];
            end

            for (i = 0; i < 150; i = i + 1) begin
                while (~error_ready) begin
                    #40;
                end
                #40;
                mem_error[i] = error_out;
            end

            f = $fopen("output.txt", "w");
            for (i = 0; i < 150; i = i + 1) begin
                $fwrite(f,"%b\n", mem_error[i]);
            end
            $fclose(f);
        end

endmodule
