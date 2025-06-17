`timescale 1 ps / 1 ps
module SRAM_tb();

	logic clk, wren;
	logic [11:0] address;
	logic [15:0] data, rdata, expectedOut;
	logic [15:0] memVector[255:0];
	logic [11:0] i;
	
	SRAM mem (
		.clock(clk),
		.wren(wren),
		.address(address),
		.data(data),
		.q(rdata)
	);
	
	initial begin 
		$readmemh("C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/Proyecto2/SRAM/SRAM_DATA_tb.txt", memVector); //datos para escritura
		i = 0;
		wren = 0;
		data = 0;
		address = 0;
		clk = 0;
	end
	
	always @(posedge clk) 
		begin
			//lectura del dato escrito
			wren = 0;
			expectedOut = memVector[i]; #5;
			
			if(expectedOut !== rdata) begin
				$display("Test failed. Data expected %h, and got %h", expectedOut, rdata);
			end
			i = i + 1;
			if (i === 12'b111111111111) begin
				$finish;
			end
		end
	
	always @(negedge clk)
		begin
			//escritura en RAM
			wren = 1; 
			address = i;
			data = memVector[i];
		end
		
	always #5 clk = ~clk;
	
	
endmodule
