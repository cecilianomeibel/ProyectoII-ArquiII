
module ReLU #(parameter dataSize=16)(
	input logic enable,
	input logic [dataSize-1:0] data,
	output logic [dataSize-1:0] result
);

	always @(*)
		begin 
			if (enable) begin 
				if (data < 0) result = 0;
				else result = data;
			end
			else result = data;			
		end

endmodule
