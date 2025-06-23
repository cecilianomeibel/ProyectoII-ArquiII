`timescale 1 ps / 1 ps
module NPU_tb();
	logic clk, rst, enableR, debugBtn, trigger, debugDone;
	logic [6:0] sevenSeg0, sevenSeg1, sevenSeg2;
	logic [1:0] state;
	
	NPU npu(
		.clk(clk),
		.rst(rst),
		.enableR(enableR),
		.debugBtn(debugBtn),
		.sevenSeg0(sevenSeg0), 
		.sevenSeg1(sevenSeg1), 
		.sevenSeg2(sevenSeg2),
		.trigger(trigger),
		.state(state),
		.debugDone(debugDone)
	);
	
	always #5 clk = ~clk;
	
	initial begin 
		clk = 0;
		rst = 0;
		enableR = 1;
		debugBtn = 1;
		#40;
		rst = 1;
		#20;
		rst = 0;
		
		#20; 
		trigger = 1;
		
		#200;
		trigger = 0;
		
		#850;
		debugBtn = 0;
		
		#100;
		debugBtn = 1;
		
		#300;
		$finish;
	end

endmodule
