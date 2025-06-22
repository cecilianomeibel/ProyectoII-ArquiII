`timescale 1 ps / 1 ps
module dataUnit_tb(); 
	logic clk, rst, wren;
	logic [15:0] data;
	logic [11:0] address;
	logic [15:0] weights[4][4];
	logic [15:0] PEinputs[4];
	
	dataUnit #(.dataSize(16), .matrixSize(4)) dataTest(
		.clk(clk),
		.rst(rst),
		.data(data),
		.wren(wren),
		.address(address),
		.weights(weights),
		.PEinputs(PEinputs)
	);
	
	RAM mem (
		.clk(clk),
		.wren(wren),
		.address(address),
		.writeData(0),
		.readData(data)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 0;
		clk = 0;
		
		#5;
		rst = 1;
		
		#500;
		$finish;
	end

endmodule
