module regshift(
    input logic [31:0] Rs,
	input logic [1:0] shift_control,
	input logic [31:0] Rm,
	output logic [31:0] Rd
);
    
	always_comb
	begin
	    Rd = 32'b0;
		automatic logic c_flag = 1'b0;
	    case(shift_control)
		2'b00: //LSL by register
		    begin
			    if (Rs[7:0] == 0)
				    Rd = Rm;
				else if (Rs[7:0] < 32)
				    Rd = Rm << Rs[7:0];
				else
				    Rd = 0;
		    end
		2'b01: //LSR by register
		    begin
			    if (Rs[7:0] == 0)
				    Rd = Rm;
				else if (Rs[7:0] < 32)
				    Rd = Rm >> Rs[7:0];
				else
				    Rd = 0;
		    end
		2'b10: //ASR by register
		    begin
			    if (Rs[7:0] == 0)
				    Rd = Rm;
				else if (Rs[7:0] < 32)
				    Rd = Rm >>> Rs[7:0];
				else
					if (Rm[31] == 0)
				        Rd = 0;
					else
					    Rd = 32'hffffffff;
		    end
		2'b11: //ROR by register
		    begin
			    if (Rs[7:0] == 0)
				    Rd = Rm;
				else if (Rs[4:0] == 0)
				    Rd = Rm;
				else 
				    Rd = (Rm << Rs[4:0]) | (Rm >> Rs[4:0]));
			end
		endcase
	end
end module