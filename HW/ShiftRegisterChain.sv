module ShiftRegisterChain (
    input  logic clk, rst,
    input  logic [15:0] data_in,
    output logic [15:0] out0, out1, out2, out3
);

    logic [15:0] stage0, stage1, stage2;

    // Instancia 1: recibe el dato inicial
    ShiftRegister reg0 (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(stage0)
    );

    // Instancia 2: recibe salida de la anterior
    ShiftRegister reg1 (
        .clk(clk),
        .rst(rst),
        .data_in(stage0),
        .data_out(stage1)
    );

    // Instancia 3: sigue desplazando
    ShiftRegister reg2 (
        .clk(clk),
        .rst(rst),
        .data_in(stage1),
        .data_out(stage2)
    );
	 
	     ShiftRegister reg3 (
        .clk(clk),
        .rst(rst),
        .data_in(stage2),
        .data_out(out3)
    );

    assign out0 = stage0;  
    assign out1 = stage1;  
    assign out2 = stage2;  
	 // out3 ya viene directo del último registro

endmodule
