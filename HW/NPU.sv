
module NPU (
	input logic clk, rst, enableR,
	output logic [15:0] totalCycles, totalReads, totalWrites, totalOp,
	output logic [15:0] resultRow[3:0]
);
	logic wren, writeEn, readyData;
	logic [5:0] counter;
	logic [11:0] address, memAddr, writeAddr;
	logic [15:0] data, writeData;
	logic [15:0] weights[4][4];
	logic [15:0] resultData[4][4];
	logic [15:0] PEinputs[4];
	
	//Control registers
	logic dataWorking, working;
	logic done = 0;
	logic writing;
	
	//Telemetry
	logic [4:0] Ops[16];
	
	assign writeEn = (wren == 0) ? 1 : 0;
	assign memAddr = (wren == 0) ? writeAddr : address;
	assign working = ~done; //total cycles count enable
	assign writing = (writeEn == 1) ? ((done == 1) ? 0 : 1) : 0;
	
	RAM mem (
		.clk(clk),
		.wren(writeEn),
		.address(memAddr),
		.writeData(writeData),
		.readData(data)
	);
	
	dataUnit #(.dataSize(16), .matrixSize(4)) dataTest(
		.clk(clk),
		.rst(rst),
		.data(data),
		.wren(wren),
		.working(dataWorking),
		.address(address),
		.weights(weights),
		.PEinputs(PEinputs)
	);
	
	systolicArray #(.dataSize(16), .size(4)) sysArray(
		.clk(clk),
		.rst(rst),
		.enableRelu(enableR),
		.PELeftdata(PEinputs),
		.weights(weights),
		.resultRow(resultRow),
		.opArray(Ops)
	);
	
	performanceMonitor PM(
		.clk(clk),
		.rst(rst),
		.working(working),
		.reading(wren),
		.writing(writing),
		.operations(Ops),
		.totalCycles(totalCycles),
		.totalReads(totalReads),
		.totalWrites(totalWrites),
		.totalOp(totalOp)
	);
	
	always @(*) 
		begin
			if (resultRow[3] >= 0) readyData = 1;
			if (counter == 9 && readyData) readyData = 0;
			if (counter-9 == 16) begin 
				readyData = 1'bx;
				done = 1;
			end
		end
	
	always_ff @(posedge clk, negedge rst) 
		begin
			if (~rst) begin
				writeAddr <= 128;
				counter <= 0;
			end
			else begin
				if (readyData) begin
					resultData[0][counter] <= resultRow[3];
					resultData[1][counter-1] <= resultRow[2];
					resultData[2][counter-2] <= resultRow[1];
					resultData[3][counter-3] <= resultRow[0];
					counter <= counter + 1;
				end
				if (~readyData) begin
					writeAddr <= (counter-9) + 128; 
					writeData <= resultData[(counter-9)/4][(counter-9)%4];
					counter <= counter + 1;
				end				
			end
		end

endmodule
