module Reg_file(readReg1, readReg2, writeReg, writeData, regWrite, clock, rst, readData1, readData2);
	input regWrite, clock, rst;
	input[2:0] readReg1, readReg2, writeReg;
	input[15:0] writeData;
	output[15:0] readData1, readData2;

	reg [15:0] reg_file [0:7];
	integer k;

	always@(posedge clock, posedge rst)begin
		if(rst)
			for (k = 0; k <= 7 ; k = k + 1) reg_file[k] <= 16'd0;
		else if((regWrite) != 1'd0)
			reg_file[writeReg] <= writeData;
	end

	assign readData1 = reg_file[readReg1];
    assign readData2 = reg_file[readReg2];
	
endmodule
