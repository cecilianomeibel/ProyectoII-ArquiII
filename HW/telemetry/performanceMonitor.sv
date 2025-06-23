
module performanceMonitor #(parameter PEamount=16)(
	input logic clk, rst, working,
	input logic reading, writing,
	input logic [4:0] operations[PEamount],
	output logic [15:0] totalCycles, totalReads, totalWrites,
	output logic [15:0] totalOp
);
	logic countOp, countOpFinish;
	logic [15:0] cycles, reads, writes;
	logic [15:0] Ops;
	
	always @(posedge clk, posedge rst) 
		begin
			if (rst) begin
				cycles <= 0;
				reads <= 0;
				writes <= 0;
				Ops <= 0;
				countOp <= 0;
				countOpFinish <= 0;
			end
			else begin
				if (working) begin
					cycles <= cycles + 1;
				end
				else begin
					countOp <= 1;
					if (countOp && ~countOpFinish) begin
						for (int i=0; i<PEamount; i++) begin : opLoop
							Ops = Ops + operations[i];
						end
						countOpFinish <= 1;
					end
				end
				if (reading) begin
					reads <= reads + 1;
				end
				if (writing) begin
					writes <= writes + 1;
				end
			end

		end
		
	assign totalCycles = cycles;
	assign totalReads = reads;
	assign totalWrites = writes;
	assign totalOp = Ops;

endmodule 
