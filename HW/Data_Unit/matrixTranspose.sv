
module matrixTranspose #(parameter dataSize = 16, parameter matrixSize = 4)(
	input logic[dataSize-1:0] matrix[matrixSize][matrixSize],
	output logic[dataSize-1:0] result[matrixSize][matrixSize]
);

	always @(*) 
		begin
			for(int i=0; i<4; i++) begin : rows_loop
				for(int j=0; j<4; j++) begin : cols_loop
					result[j][i] = matrix[i][j]; //transposicion de matriz de pesos
				end
			end
		end


endmodule
