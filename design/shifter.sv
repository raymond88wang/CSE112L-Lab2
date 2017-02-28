module shifter(
    input logic [25:0] Instr,
	input logic [31:0] Rm,
	input logic [31:0] Rs,
	output logic [31:0] Rd,
	output logic [3:0] ShifterFlags
);
    Rd = 32'b0;
	automatic logic overflow = 1'b0;
	automatic logic c_out = 1'b0;
	automatic logic negative = 1'b0;
	automatic logic zero = 1'b0;

    if (Instr[25] || ~Instr[11:4])
	    Rd = Rm;
		zero = ~|Rd;
		negative = Rd[31];
		Shifter_Flags = {negative, zero, c_out, overflow};
	else
	    if (Instr[4])
	        regshift regshift(Instr[11:8], Instr[6:5], Rm, Rd, ShifterFlags);
		else
	        immshift immshift(Rs, Instr[6:5], Rm, Rd, ShifterFlags);

end module