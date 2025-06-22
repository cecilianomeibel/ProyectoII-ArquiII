
module dataUnit #(parameter dataSize = 16, parameter matrixSize = 4) (
	input logic clk, rst,
	input logic [dataSize-1:0] data,
	
	output logic wren,
	output logic [11:0] address,
	output logic [dataSize-1:0] weights[matrixSize][matrixSize]
	);
	
	logic ramRead;
	logic [1:0] state, nextState;
	logic [5:0] counter, index;
	localparam INIT = 	2'b00;
	localparam WEIGHTS = 2'b01;
	localparam DATA =		2'b10;
	
	assign index = counter - 2;
	
	/*ShiftRegisterChain shiftRow1 (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.out(out0)
	);
	  
	ShiftRegisterChain shiftRow2 (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.out(out0)
	);
	  
	ShiftRegisterChain shiftRow3 (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.out(out0)
	);
	  
	ShiftRegisterChain shiftRow4 (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.out(out0)
	);*/
	
	/*always_ff @(posedge clk) 
		begin
			if (state == WEIGHTS && ramRead) begin
				weights[counter/matrixSize][counter%matrixSize] <= data; 
				counter <= counter + 1;
			end
			
	end*/
	
	always_ff @(posedge clk, negedge rst) 
		begin
			if (~rst) begin
				state <= INIT;
				counter <= 5'b00000; 
			end
			else begin
				state <= nextState;
				if (ramRead) counter <= counter + 1;
				if (state == WEIGHTS && ramRead && counter > 1) begin
					weights[index/matrixSize][index%matrixSize] <= data; 
				end
			end
		end
	
	always_comb 
		begin 
			nextState = state; 
			ramRead = 0; 
			address = counter-1;
			
			case (state) 
				INIT: begin
					nextState = WEIGHTS; 
				end
				
				WEIGHTS: begin
					ramRead = 1;
					if (counter < matrixSize*matrixSize+1) begin
						nextState = WEIGHTS; 
					end
					else nextState = DATA; 
				end
					
				DATA: begin
					ramRead = 0; 
					nextState = DATA;
				end
				
				default: begin
					ramRead = 0;
					nextState = INIT;
				end
			endcase 
		end
		
	assign wren = 0;

endmodule
