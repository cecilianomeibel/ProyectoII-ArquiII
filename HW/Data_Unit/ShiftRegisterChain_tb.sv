module ShiftRegisterChain_tb();

  logic clk,rst;
  logic [15:0] data_in;
  logic [15:0] out;

  ShiftRegisterChain uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .out(out)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    data_in = 16'h0000;

    #10;
    rst = 0;

	 
    data_in = 16'hAAAA; 
    #10; // ciclo 1

    data_in = 16'h1234;
    #10; // ciclo 2

    data_in = 16'h5678; 
    #10; // ciclo 3

    data_in = 16'hFFFF; 
    #10; // ciclo 4

    data_in = 16'h0000; // después, entran ceros
    #50;

    $finish;
  end

endmodule
