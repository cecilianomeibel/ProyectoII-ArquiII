`timescale 1 ps / 1 ps
module NPU_tb();
	logic clk, rst, enableR;
	logic [15:0] resultRow[3:0];
	
	NPU npu(
		.clk(clk),
		.rst(rst),
		.enableR(enableR),
		.resultRow(resultRow)
	);
	
	always #5 clk = ~clk;
	
	initial begin 
		clk = 0;
		rst = 0;
		enableR = 1;
		#20;
		rst = 1;
		
		#1000;
		$finish;
	end

endmodule
