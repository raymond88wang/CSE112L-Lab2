module decoder(
	input logic [1:0] Op,
    input logic [5:0] Funct,
    input logic [3:0] Rd,
	input logic [1:0] Op2,
	output logic [3:0] be,
    output logic [1:0] FlagW,
    output logic PCS, RegW, MemW,
    output logic MemtoReg, ALUSrc,
    output logic [1:0] ImmSrc, RegSrc, ALUControl);

    logic [9:0] controls;
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
						controls = 10'b0011111000;
						be = 4'b0011;
					end
				2'b10:
					begin
					// LDRSB
						controls = 10'b0000111000;
						be = 4'b0001;
					end
				2'b11:
					begin
						controls = 10'b0011111000;
				default: controls = 10'bx;
				endcase	
            // Data-processing register
            else 
				if(Op2[1:0] == 2'b01)
				{
				// STRH
					controls = 10'b1001110100;
					be = 4'b0011;
				}
				else
					controls = 10'b0000001001;
			
            2'b01: 
				if (Funct[0])
					if(Funct[2]) 
					// LDR
						controls = 10'b0001111000;
					else
					{
					// LDRB
						controls = 10'b0001111000;
						be = 4'b0001;
					}
				else 
					if(Funct[2])
					{
					// STRB
						controls = 10'b1001110100;
						be = 4'b0001;
					}
					else
					// STR
						controls = 10'b1001110100;
				
            // B and BL
            2'b10: controls = 10'b0110100010;
            // Unimplemented
            default: controls = 10'bx;
        endcase
    
    assign {RegSrc, ImmSrc, ALUSrc, MemtoReg,
        RegW, MemW, Branch, ALUOp} = controls;
    
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
