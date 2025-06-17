
module PE #(parameter dataSize=16)(
		input logic clk, rst,
		input logic [dataSize-1:0] upData, leftData, weight,
		output logic [dataSize-1:0] bottomResult, rightResult
);

	reg [dataSize-1:0] passThrough, w;
	//TODO metrics regs 
	
	always_ff @(posedge clk or posedge rst) 
		if (rst) begin 
			passThrough <= 0; 
		end
		else begin
			passThrough <= leftData;
			
			bottomResult <= (leftData * w) + upData;
		end
		
	assign rightResult = passThrough;
	assign w = weight; 

endmodule
