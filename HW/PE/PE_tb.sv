
module PE_tb();
	logic clk;
	logic [15:0] upData, leftData, weight;
	logic [15:0] bottomResult, rightResult;
	
	PE cpu(
		.clk(clk),
		.upData(upData),
		.leftData(leftData),
		.weight(weight),
		.bottomResult(bottomResult),
		.rightResult(rightResult)
	);
	
	initial begin
		clk = 0; 
		upData = 4'h000A;
		leftData = 4'h0001;
		weight = 4'h0001; #20;
		
		$finish;
	end
	
	always #5 clk = ~clk;

endmodule
