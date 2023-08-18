module Register_file(readReg1, readReg2, writeRegister, writeData, regWrite, clock, rst, readData1, readData2);
	input[4:0] readReg1, readReg2, writeRegister;
	input[31:0] writeData;
	input regWrite, clock, rst;
	output[31:0] readData1, readData2;

	reg [31:0] reg_file [0:31];
	integer k;
	always@(posedge clock, posedge rst)begin
		if(rst)
			for (k = 0; k <= 31 ; k = k + 1)
				reg_file[k] <= 32'd0;
		else if(regWrite && writeRegister != 5'd0)
			reg_file[writeRegister] <= writeData;
	end
	assign readData1 = (readReg1 != 5'd0) ? reg_file[readReg1] : 32'd0;
    assign readData2 = (readReg2 != 5'd0) ? reg_file[readReg2] : 32'd0;

endmodule
