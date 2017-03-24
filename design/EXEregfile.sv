module EXregfile(
    input logic clk,
    input logic [31:0] ALUResult, WriteData, MEMResult,
    output logic [31:0] ALUResultE, WriteDataE, EXEResult);

    always_ff @(posedge clk)
		begin
			ALUOutM = ALUResultE;
			WriteDatao = WriteDataE;
			Resulto = Resulti;
		end
endmodule
