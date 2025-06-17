
module PE(
		input logic clk,
		input logic [15:0] upData, leftData, weight,
		output logic [15:0] bottomResult, rightResult
);

	reg [15:0] passThrough, w;
	//TODO metrics regs 
	
	always_ff @(posedge clk) 
		begin
			passThrough <= leftData;
			
			bottomResult <= (leftData * w) + upData; //toma 2 ciclos por guardado de w
		end
		
	assign rightResult = passThrough;
	assign w = weight; 

endmodule
