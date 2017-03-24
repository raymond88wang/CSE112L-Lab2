module IFregfile(
    input logic clk,
    input logic [31:0] InstrF, Resulti,
    output logic [31:0] InstrD, Resulto);

    always_ff @(posedge clk)
		begin
			InstrD = InstrF;
			Resulto = Resulti;
		end
endmodule
