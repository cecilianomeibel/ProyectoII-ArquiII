
module dataUnit #(parameter dataSize = 16, parameter matrixSize = 4) (
	input logic clk, rst,
	input logic [dataSize-1:0] data,
	
	output logic wren, working,
	output logic [11:0] address,
	output logic [dataSize-1:0] weights[matrixSize][matrixSize],
	output logic [dataSize-1:0] PEinputs[matrixSize]
	
	//input logic trigger, 
	//output logic [1:0] state
	);
	
	logic ramRead;
	logic [dataSize-1:0] shift1, shift2, shift3, shift4;
	logic [1:0] nextState, state;
	logic [5:0] counter, index, dataCicles, shiftIndex;
	logic [dataSize-1:0] dataMatrix[matrixSize][matrixSize];
	logic [dataSize-1:0] wTemp[matrixSize][matrixSize];
	localparam INIT = 			2'b00;
	localparam WEIGHTS = 		2'b01;
	localparam LOADMATRIX =		2'b10;
	localparam LOADSHIFT = 		2'b11;
	
	
	assign index = counter - 2;
	assign dataCicles = matrixSize*matrixSize*2+1;
	
	ShiftRegisterChain shiftRow1 (
		.clk(clk),
		.rst(rst),
		.data_in(shift1),
		.out(PEinputs[0])
	);
	  
	ShiftRegisterChain shiftRow2 (
		.clk(clk),
		.rst(rst),
		.data_in(shift2),
		.out(PEinputs[1])
	);
	  
	ShiftRegisterChain shiftRow3 (
		.clk(clk),
		.rst(rst),
		.data_in(shift3),
		.out(PEinputs[2])
	);
	  
	ShiftRegisterChain shiftRow4 (
		.clk(clk),
		.rst(rst),
		.data_in(shift4),
		.out(PEinputs[3])
	);
	
	matrixTranspose calc ( 
		.matrix(wTemp),
		.result(weights)
	);
	
	//always_ff @(posedge trigger, posedge rst)
		//if (rst) state <= INIT;
		//else begin
			//state <= nextState;
		//end
	

	//weight load and counter logic 
	always_ff @(posedge clk, posedge rst) 
		begin
			if (rst) begin
				state <= INIT;
				counter <= 5'b00000; 
				shiftIndex <= 5'b00000;
			end
			else begin
				state <= nextState;
				if (ramRead) counter <= counter + 1;
				if (~ramRead) shiftIndex <= shiftIndex + 1;
				if (state == WEIGHTS && ramRead && counter > 1) begin
					wTemp[index/matrixSize][index%matrixSize] <= data; 
				end
			end
		end
	
	//data load into matrix
	always_ff @(posedge clk) 
		begin
			if (state == LOADMATRIX && ramRead) begin
				dataMatrix[(index/matrixSize)-4][index%matrixSize] <= data; 
			end
		end
	
	always_ff @(posedge clk)
		begin
			if (state == LOADSHIFT && ~ramRead) begin
				shift1 = dataMatrix[0][shiftIndex];
				shift2 = dataMatrix[1][shiftIndex-1];
				shift3 = dataMatrix[2][shiftIndex-2];
				shift4 = dataMatrix[3][shiftIndex-3];
			end
		end
	
	always_comb 
		begin 
			nextState = state; 
			ramRead = 1'bx; 
			address = counter-1;
			working = 0;
			
			case (state) 
				INIT: begin
					working = 1;
					nextState = WEIGHTS; 
				end
				
				WEIGHTS: begin
					ramRead = 1;
					if (counter < matrixSize*matrixSize+1) begin
						nextState = WEIGHTS; 
					end
					else nextState = LOADMATRIX; 
				end
					
				LOADMATRIX: begin
					ramRead = 1;
					if (counter < dataCicles) begin
						nextState = LOADMATRIX;
					end
					else nextState = LOADSHIFT;					
				end
				
				LOADSHIFT: begin
					ramRead = 0; 
					nextState = LOADSHIFT;
				end
				
				default: begin
					ramRead = 0;
					nextState = INIT;
				end
			endcase 
		end
		
	assign wren = ramRead;

endmodule
