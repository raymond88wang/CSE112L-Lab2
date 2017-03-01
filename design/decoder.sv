module decoder(
	input logic [1:0] Op,
    input logic [5:0] Funct,
    input logic [3:0] Rd,
	input logic [1:0] Op2,
	output logic [3:0] be,
    output logic [1:0] FlagW,
    output logic PCS, RegW, MemW,
    output logic MemtoReg, ALUSrc, ShifterSrc,
    output logic [1:0] ImmSrc, RegSrc, ALUControl);

    logic [10:0] controls;
    logic Branch, ALUOp;
    
    // Main Decoder
    always_comb
        casex(Op)
            // Data-processing immediate
            2'b00: 
			if (Funct[5]) 
				case(Op2[1:0])
				2'b01: 
					begin
					// LDRH
					    if (Funct[4:1] == 4'b1101)
						begin
						    controls = 11'b00111110001;
						    be = 4'b0011;
						end
						else
						begin
						    controls = 11'b00111110000;
						    be = 4'b0011;
						end
					end
				2'b10:
					begin
					// LDRSB
					    if (Funct[4:1] == 4'b1101)
						begin
						    controls = 11'b00001110001;
						    be = 4'b0001;
						end
						else
						begin
						    controls = 11'b00001110000;
						    be = 4'b0001;
						end
					end
				2'b11:
					begin
					    if (Funct[4:1] == 4'b1101)
						    controls = 11'b00111110001;
						else
						    controls = 11'b00111110000;
					end
				endcase	
            // Data-processing register
            else 
				if(Op2[1:0] == 2'b01)
				// STRH
					begin
					if (Funct[4:1] == 4'b1101)
					    begin 
					    controls = 11'b10011101001;
					    be = 4'b0011;
						end
					else
					    begin
						controls = 11'b10011101000;
					    be = 4'b0011;
						end
					end
				else
				    if (Funct[4:1] == 4'b1101)
					    controls = 11'b00000010011;
					else
					    controls = 11'b00000010010;
            2'b01: 
				if (Funct[0])
					if(Funct[2]) 
					// LDR
						controls = 11'b00011110000;
					else
					// LDRB
					    begin
						controls = 11'b00011110000;
						be = 4'b0001;
						end
				else 
					if(Funct[2])
					// STRB
					    begin
						controls = 11'b10011101000;
						be = 4'b0001;
						end
					else
					// STR
						controls = 11'b10011101000;
				
            // B and BL
            2'b10: controls = 11'b01101000100;
            // Unimplemented
            default: controls = 11'bx;
        endcase
    
    assign {RegSrc, ImmSrc, ALUSrc, MemtoReg,
        RegW, MemW, Branch, ALUOp, ShifterSrc} = controls;
    
    // ALU Decoder
    always_comb
        if (ALUOp) begin // which DP Instr?
            case(Funct[4:1])
                4'b0100: ALUControl = 2'b00; // ADD
                4'b0010: ALUControl = 2'b01; // SUB
                4'b0000: ALUControl = 2'b10; // AND
                4'b1100: ALUControl = 2'b11; // ORR
                default: ALUControl = 2'bx; // unimplemented
            endcase
            
            // update flags if S bit is set (C & V only for arith)
            FlagW[1] = Funct[0];
            FlagW[0] = Funct[0] &
                (ALUControl == 2'b00 | ALUControl == 2'b01);
        end 
        else begin
            ALUControl = 2'b00; // add for non-DP instructions
            FlagW = 2'b00; // don't update Flags
        end

    // PC Logic
    assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
endmodule
