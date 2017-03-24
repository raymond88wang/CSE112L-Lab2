module IDregfile(
    input logic clk,
    input logic [31:0] SrcA, WriteData, ExtImm, Resulti,
    output logic [31:0] SrcAE, SrcBE, ExtImmE, Resulto);

    always_ff @(posedge clk)
		begin
			RD1o = RD1i;
			RD2o = RD2i;
			ExtImmeEo = ExtImmEi;
			Resulto = Resulti;
		end
endmodule
