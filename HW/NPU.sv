
module NPU (
	input logic clk, rst, enableR, debugBtn, 
	output logic [6:0] sevenSeg0, sevenSeg1, sevenSeg2,
	
	output logic [15:0] writeData
);
	
	logic [15:0] resultRow[3:0];
	logic wren, writeEn, readyData, triggerOut;
	logic [5:0] counter;
	logic [11:0] address, memAddr, writeAddr, debugAddr;
	logic [15:0] data; //writeData;
	logic [15:0] weights[4][4];
	logic [15:0] resultData[4][4];
	logic [15:0] PEinputs[4];
	
	//Control registers
	logic dataWorking, working;
	logic done;
	logic writing;
	
	//Telemetry
	logic [4:0] Ops[16];
	logic [15:0] totalCycles, totalReads, totalWrites, totalOp;
	
	assign writeEn = (done) ? 0 : ((wren == 0) ? 1 : 0);
	assign memAddr = (done) ? debugAddr : ((wren == 0) ? writeAddr : address);
	assign working = ~done; //total cycles count enable
	assign writing = (writeEn == 1) ? ((done == 1) ? 0 : 1) : 0;
	
	initial begin
		done <= 0;
	end
	
	RAM mem (
		.clk(clk),
		.wren(writeEn),
		.address(memAddr),
		.writeData(0),
		.readData(data)
	);
	
	debouncer d(
		.clk(clk),
		.rst(rst),
		.btn(trigger),
		.pulse(triggerOut)
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
	
	debugger debug(
		.clk(clk),
		.rst(rst),
		.memEnable(done),
		.btn(debugBtn),
		.data(writeData),
		.address(debugAddr),
		.display1(sevenSeg1),
		.display2(sevenSeg0),
		.display3(sevenSeg2)
	);
	
	always @(*) 
		begin
			if (rst) done = 0;
			if (resultRow[3] >= 0) readyData = 1;
			else readyData = 1'bx;
			if (counter == 9 && readyData) readyData = 0;
			if (counter-9 == 17) begin 
				readyData = 1'bx;
				done = 1;
			end
		end
	
	always_ff @(posedge clk, posedge rst) 
		begin
			if (rst) begin
				writeAddr <= 3;
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
					writeData <= resultData[debugAddr/4][debugAddr%4];
					counter <= counter + 1;
				end				
			end
		end

endmodule
