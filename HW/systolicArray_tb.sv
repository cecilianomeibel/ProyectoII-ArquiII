
module systolicArray_tb(); 
	logic clk, rst;
	logic [15:0] PELeftdata[3:0];
	logic [15:0] resultRow[3:0];
	
	logic [15:0] weights[0:3][0:3];
	logic [15:0] Tweights[0:3][0:3];
	logic [4:0] count = 0;
	
	
	systolicArray #(.dataSize(16), .size(4)) sysArray(
			.clk(clk),
			.rst(rst),
			.PELeftdata(PELeftdata),
			.weights(Tweights),
			.resultRow(resultRow)
	);
	
	always #5 clk = ~clk;
	
	logic [15:0] matrix[0:3][0:3];
	
	initial begin
		clk = 0;
		rst = 0;
		matrix = '{default: '{default: 16'h0000}}; // Inicializa todo a cero
		weights = '{default: '{default: 16'h0000}}; // Inicializa todo a cero

		matrix[0] = '{16'h0001, 16'h0002, 16'h0000, 16'h0000};
		matrix[1] = '{16'h0001, 16'h0002, 16'h0001, 16'h0002};
		matrix[2] = '{16'h0001, 16'h0001, 16'h0003, 16'h0001};
		matrix[3] = '{16'h0000, 16'h0002, 16'h0004, 16'h0005};

			
		weights[0] = {16'h0003, 16'h0002, 16'h0003, 16'h0004};
		weights[1] = {16'h0004, 16'h0001, 16'h0002, 16'h0003};
		weights[2] = {16'h0002, 16'h0004, 16'h0001, 16'h0002};
		weights[3] = {16'h0001, 16'h0007, 16'h0003, 16'h0005};
		
		for(int i=0; i<4; i++) begin : rows_loop
			for(int j=0; j<4; j++) begin : cols_loop
				Tweights[j][i] = weights[i][j]; //transposicion de matriz de pesos
			end
		end
	
		#5; rst = 1;
	end
	
	always @(posedge clk) begin
		PELeftdata[3] = matrix[0][count];
		PELeftdata[2] = matrix[1][count-1];
		PELeftdata[1] = matrix[2][count-2];
		PELeftdata[0] = matrix[3][count-3];
		count = count + 1;
		if(count === 5'b11111) $finish;
	end

endmodule
