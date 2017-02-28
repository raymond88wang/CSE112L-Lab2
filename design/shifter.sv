module shifter(
    input logic [25:0] Instr,
	input logic [31:0] Rm,
	output logic [31:0] Rd
);
    Rd = 32'b0;

    if (Instr[25])
	    Rd = Rm;
	else
	    if (Instr[4])
	        regshift regshift(Instr[11:8], Instr[6:5], Rm, Rd);
		else
	        immshift immshift(Instr[11:7], Instr[6:5], Rm, Rd);

end module