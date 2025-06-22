`timescale 1 ps / 1 ps
module NPU_tb();
	logic clk, rst, enableR;
	logic [15:0] resultRow[3:0];
	logic [15:0] totalCycles, totalReads, totalWrites, totalOp;
	
	NPU npu(
		.clk(clk),
		.rst(rst),
		.enableR(enableR),
		.totalCycles(totalCycles),
		.totalReads(totalReads),
		.totalWrites(totalWrites),
		.totalOp(totalOp),
		.resultRow(resultRow)
	);
	
	always #5 clk = ~clk;
	
	initial begin 
		clk = 0;
		rst = 1;
		enableR = 1;
		#40;
		rst = 0;
		#20;
		rst = 1;
		
		#1000;
		$finish;
	end

endmodule
