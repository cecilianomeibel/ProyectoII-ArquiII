
module systolicArray #(parameter size=4, parameter dataSize=16) (
	input logic clk, rst, enableRelu,
	input logic [dataSize-1:0] PELeftdata[size],
	input logic [dataSize-1:0] weights[size][size],
	output logic [dataSize-1:0] resultRow[size],
	output logic [4:0] opArray[size*size]
);

	logic [dataSize-1:0] upData[size+1][size];
	logic [dataSize-1:0] leftData[size][size+1];
	logic [dataSize-1:0] resultTemp[size];
	
	initial begin 
		for(int j=0; j<size; j++) begin
			upData[0][j] = 16'h0000; //entradas de primera fila
		end
	end

	genvar i, j;
	generate 
		for(i=0; i<size; i++) begin : rowLoop
			for(j=0; j<size; j++) begin : colLoop
				if(i === 3) begin
					PE #(dataSize) PE_inst(
						.clk(clk),
						.rst(rst),
						.upData(upData[i][j]),
						.leftData(leftData[i][j]),
						.weight(weights[i][j]),
						.bottomResult(resultTemp[j]),
						.rightResult(leftData[i][j+1]),
						.operations(opArray[4*i+j])
				);
				end 
				else begin
					PE #(dataSize) PE_inst(
						.clk(clk),
						.rst(rst),
						.upData(upData[i][j]),
						.leftData(leftData[i][j]),
						.weight(weights[i][j]),
						.bottomResult(upData[i+1][j]),
						.rightResult(leftData[i][j+1]),
						.operations(opArray[4*i+j])
				);
				end
			end
		end 
	endgenerate
	
	generate 
		for(i=0; i<4; i++) begin : reluLoop
			ReLU relu_inst(
				.enable(enableRelu),
				.data(resultTemp[i]),
				.result(resultRow[i])			
			);
		end
	endgenerate 
	//fila size-1 
	always @(*) begin
		for(int i=0; i<size; i++) begin : leftLoop
			leftData[i][0] = PELeftdata[i]; //asignar datos de entrada a la primera columna
		end 
	end


endmodule
