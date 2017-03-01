module ram(
	input logic clk ,
	input logic we ,
	input logic [3:0] be , // Byte - enable
	input logic [31:0] addr ,
	input logic [31:0] dataI ,
	output logic [31:0] dataO);
	
	dmem dmem(clk, we, addr, dataI, dataO);

endmodule