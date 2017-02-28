module extend(
	input logic sign,
    input logic [23:0] Instr,
    input logic [1:0] ImmSrc,
    output logic [31:0] ExtImm);


    always_comb
        case(ImmSrc)
            // 8-bit unsigned immediate
            2'b00: 
				ExtImm = sign ? {24'b1, Instr[7:0]} : {24'b0, Instr[7:0]};
            // 12-bit unsigned immediate
            2'b01: 
				ExtImm = sign ? {20'b1, Instr[11:0]} : {20'b0, Instr[11:0]};
            // 24-bit two's complement shifted branch
            2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
			// 16-bit unsigned immediate
            2'b11: 
				ExtImm = sign ? {16'b1, Instr[15:0]} : {16'b0, Instr[15:0]};
            default: ExtImm = 32'bx; // undefined
        endcase
endmodule
