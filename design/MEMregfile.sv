module MEMregfile(
    input logic clk,
    input logic [31:0] ReadData, ALUOutM, ReadDataW,
    output logic [31:0] ReadDataW, ALUOutW, MEMResult);

    always_ff @(posedge clk)
		begin
			ALUOutM = ALUResultE;
			WriteDatao = WriteDataE;
			Resulto = Resulti;
		end
endmodule
