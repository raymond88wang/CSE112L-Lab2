module ram
(
	input clk ,
	input we ,
	input [3:0] be , // Byte - enable
	input [31:0] addr ,
	input [31:0] dataI ,
	output [31:0] dataO
};
	dmem dmem(clk, we, addr, dataI, dataO);
endmodule ;