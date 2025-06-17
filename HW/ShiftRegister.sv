module ShiftRegister(
      input logic clk, rst,
		input logic [15:0] data_in,
		output logic [15:0] data_out 
);

  logic [15:0] data;
  
  always_ff @(posedge clk) begin
      if (rst)
	       data <= 16'b0;
	   else 
	       data <= data_in;  // Captura lo que entra por data_in
  end


  assign data_out = data;

endmodule  