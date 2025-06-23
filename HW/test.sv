
module test(
	input logic clk, rst, btn, 
	output logic [6:0] sevenSeg0, sevenSeg1, sevenSeg2
); 
	logic writeEn, done;
	logic [15:0] data;
	logic [11:0] debugAddr;
	
	RAM mem (
		.clk(clk),
		.wren(writeEn),
		.address(debugAddr),
		.writeData(9),
		.readData(data)
	);
	
	debugger debug(
		.clk(clk),
		.rst(rst),
		.memEnable(done),
		.btn(btn),
		.data(data),
		.address(debugAddr),
		.display1(sevenSeg2),
		.display2(sevenSeg1),
		.display3(sevenSeg0)
	);
	
	always_ff @(posedge clk) 
		begin
			done <= 1;
			writeEn <= 0; 
		end


endmodule
