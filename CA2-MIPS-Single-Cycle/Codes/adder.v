module adder_32b (input1, input2, cin, cout, sum);
    input [31:0] input1, input2;
    input cin;
    output cout;
    output [31:0] sum;

    assign {cout, sum} = input1 + input2 + cin;

endmodule
