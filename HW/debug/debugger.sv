
module debugger(
	input logic clk, rst, memEnable, btn,
	input logic [15:0] data,
	output logic [11:0] address,
	output logic [6:0] display1, display2, display3
);
	logic [9:0] numberMod;
	logic [3:0] digit0, digit1, digit2;
	logic pulso;
	
	decoder deco1(
		.num(digit0),
		.segment(display1)
	);
	decoder deco2(
		.num(digit1),
		.segment(display2)
	);
	decoder deco3(
		.num(digit2),
		.segment(display3)
	);
	
	debouncer d(
		.clk(clk), 
		.rst(rst),
		.btn(btn),
		.pulse(pulso)
	);
	
	always_comb 
		begin
			numberMod = data % 1000;
			digit0 = numberMod % 10;
			digit1 = (numberMod / 10) % 10;
			digit2 = (numberMod /100) % 10; 			
		end

	/*always_ff @(posedge clk, posedge rst) 
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
	
	assign pulso = btnDown & ~btnFiltered;*/
	
	always_ff @(posedge clk, posedge rst) begin
		if (rst) address <= 0;
		
		else if (memEnable && pulso) begin
			address <= address + 1;
			if (address > 17) address <= 0;
		end
	end
	
endmodule
