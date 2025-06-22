
module PE #(parameter dataSize=16)(
		input logic clk, rst,
		input logic [dataSize-1:0] upData, leftData, weight,
		output logic [dataSize-1:0] bottomResult, rightResult,
		output logic [4:0] operations
);

	reg [dataSize-1:0] passThrough, w;
	//TODO metrics regs 
	reg [4:0] Ops;
	
	always_ff @(posedge clk or negedge rst) 
		if (~rst) begin 
			passThrough <= 0;
			Ops <= 0;
		end
		else begin
			passThrough <= leftData;
			
			bottomResult <= (leftData * w) + upData;
			if (bottomResult >= 0) Ops <= Ops + 2;
		end
		
	assign rightResult = passThrough;
	assign w = weight; 
	assign operations = Ops;

endmodule
