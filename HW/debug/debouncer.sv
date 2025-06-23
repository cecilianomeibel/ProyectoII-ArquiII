
module debouncer(
	input logic clk, rst, btn, 
	output logic pulse
);
	logic [19:0] count;
	logic btnSync, btnPrev, btnFiltered, btnDown;

	always_ff @(posedge clk, posedge rst) 
		begin
			if (rst) begin 
				count <= 0;
				btnSync <= 1;
				btnPrev <= 1; 
				btnFiltered <= 1;
			end
			else begin
				btnSync <= btn;
				if (btnSync == btnPrev) begin
					if (count < (2**20 - 1)) count <= count + 1;
					else btnFiltered <= btnSync;
				end
				else begin
					count <= 0;
					btnPrev <= btnSync;
				end
			end 
			
		end
		
	always_ff @(posedge clk) btnDown <= btnFiltered;
	
	assign pulse = btnDown & ~btnFiltered;

endmodule
