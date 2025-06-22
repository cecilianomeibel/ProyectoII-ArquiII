
module RAM(
	input logic clk, wren,
	input logic [15:0] writeData,
	input logic [11:0] address,
	output logic [15:0] readData	
);
	
	SRAM mem(
		.clock(clk),
		.wren(wren),
		.data(writeData),
		.address(address),
		.q(readData)
	);

endmodule
