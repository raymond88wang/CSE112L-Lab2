module immshift(
    input logic [4:0] shift_imm,
	input logic [1:0] shift_control,
	input logic [31:0] Rm,
	output logic [31:0] Rd
);
    
	begin
	    Rd = 32'b0;
		automatic logic c_flag = 1'b0;
	    case(shift_control)
		2'b00: //LSL by immediate
		    begin
			    if (shift_imm == 0)
				    Rd = Rm;
				else
				    Rd = Rm << shift_imm;
		    end
		2'b01: //LSR by immediate
		    begin
			    if (shift_imm == 0)
				    Rd = 32'b0;
				else
				    Rd = Rm >> shift_imm;
		    end
		2'b10: //ASR by immediate
		    begin
			    if (shift_imm == 0)
				    if (Rm[31] == 0)
				        Rd = 32'b0;
					else
					    Rd = 32'hffffffff;
				else
				    Rd = Rm >>> shift_imm;
		    end
		2'b11: 
		    begin
			    if (shift_imm == 0) //RRX
				    Rd = (c_flag << 31) | (Rm >> 1);
				else //ROR by immediate
				    Rd = (Rm << shift_imm) | (Rm >> shift_imm);
			end
		endcase
	end
end module