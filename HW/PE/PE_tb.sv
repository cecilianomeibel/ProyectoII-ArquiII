
module PE_tb();
	logic clk, rst;
	logic [15:0] upData, leftData, w;
	logic [15:0] bottomResult, rightResult;
	
	PE #(16) cpu(
		.clk(clk),
		.rst(rst),
		.upData(upData),
		.leftData(leftData),
		.weight(w),
		.bottomResult(bottomResult),
		.rightResult(rightResult)
	);
	//Valores de entradas para pruebas
	logic errors;
	logic [1:0] i; //Cantidad de pruebas a realizar
	logic [15:0] expectedBottom, expectedRight;
	logic [15:0] upVector[1:0] = '{
		0: 16'h0000,
		1: 16'h0001
	};
	logic [15:0] leftVector[1:0] = '{
		0: 16'h0000,
		1: 16'h0001
	};
	//Valores esperados de salida
	logic [15:0] bottomVector[1:0] = '{
		0: 16'h0000,
		1: 16'h0002
	};
	logic [15:0] rightVector[1:0] = '{
		0: 16'h0000,
		1: 16'h0001
	};
	
	initial begin
		clk = 0; 
		rst = 1;
		errors = 0;
		i = 0;                
		upData = 16'h0000;
		leftData = 16'h0000;
		w = 16'h0001; //peso fijo definido para el PE
		expectedBottom = 0;
		expectedRight = 0;
		#5; rst = 0;
	end
	
	always @(negedge clk)
		begin
			upData = upVector[i];
			leftData = leftVector[i];
		end
	
	always @(posedge clk)
		begin
			expectedBottom = bottomVector[i];
			expectedRight = rightVector[i];
			#5; //tiempo esperado para obtener el resultado del PE
			if((bottomResult !== expectedBottom) || (rightResult !== expectedRight)) begin
				$display("Test failed for values %h, %h. Expected %h, %h", bottomResult, rightResult, expectedBottom, expectedRight);
				errors = 1;
			end
			i = i + 1;
			if(i > 2) begin
				if(errors !== 1) $display("Test passed.");
				else $display("Test ended with some errors.");
				$finish;
			end 
		end
	
	always #5 clk = ~clk;

endmodule
