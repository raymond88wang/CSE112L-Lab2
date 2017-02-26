module alu(
    input logic [31:0] A, B,
    input logic [3:0] ALUControl,
    output logic [31:0] ALUResult,
	  output logic [3:0] ALUFlags
    );


	always_comb 
	begin
		//flags
		automatic logic overflow = 1'b0;
		automatic logic c_out = 1'b0;
		automatic logic negative = 1'b0;
		automatic logic zero = 1'b0;
		ALUFlags = 4'b0000;
		
		ALUResult = 32'b0;
		
		case(ALUControl)
      4'b0000 :   // AND
			begin
				ALUResult = A & B;
				zero = ~|ALUResult;
			end
      4'b0001 :   // XOR
			begin
			  ALUResult = A ^ B;
				zero = ^ALUResult;
			end
      4'b0010 :   // SUB
			begin
				{c_out,ALUResult} = A - B;
				if (A[31] & ~B[31] & ~ALUResult[31])
					overflow = 1'b1;
				else if (~A[31] & B[31] & ALUResult[31])
					overflow = 1'b1;
				else
					overflow = 1'b0;
				zero = ~|ALUResult;
				negative = ALUResult[31];
      end
      4'b0011 : // REVERSE SUB
      begin
				{c_out,ALUResult} = B - A;
				if (B[31] & ~A[31] & ~ALUResult[31])
					overflow = 1'b1;
				else if (~B[31] & A[31] & ALUResult[31])
					overflow = 1'b1;
				else
					overflow = 1'b0;
				zero = ~|ALUResult;
				negative = ALUResult[31];
      end
			4'b0100 :   // ADD
			begin
				{c_out,ALUResult} = A + B;
				if (A[31] & B[31] & ~ALUResult[31])
					overflow = 1'b1;
				else if (~A[31] & ~B[31] & ALUResult[31])
					overflow = 1'b1;
				else
					overflow = 1'b0;
				zero = ~|ALUResult;
				negative = ALUResult[31];
			end
      4'b0101 :  // ADD WITH CARRY
      begin
        c_out = A + B;
        {c_out, ALUResult} = A + B + c_out;
        if (A[31] & B[31] & c_out & ~ALUResult[31])
          overflow = 1'b1;
        else if (~A[31] & ~[31] & ~c_out & ALUResult[31])
          overflow = 1'b1;
        else
          overflow = 1'b0;
        zero = ~|ALUResult;
        negative = ALUResult[31];
      end
      4'b0110 :  // SUB WITH CARRY
      begin
        c_out = A - B;
        {c_out, ALUResult} = A - B - c_out;
        if (A[31] & ~B[31] & ~c_out & ~ALUResult[31])
					overflow = 1'b1;
				else if (~A[31] & B[31] & c_out & ALUResult[31])
					overflow = 1'b1;
				else
					overflow = 1'b0;
				zero = ~|ALUResult;
				negative = ALUResult[31];
      end
      4'b0111 :  // REVERSE SUB WITH CARRY
      begin
        c_out = B - A;
        {c_out, ALUResult} = B - A - c_out;
        if (B[31] & ~A[31] & ~c_out & ~ALUResult[31])
					overflow = 1'b1;
				else if (~B[31] & A[31] & c_out & ALUResult[31])
					overflow = 1'b1;
				else
					overflow = 1'b0;
				zero = ~|ALUResult;
				negative = ALUResult[31];
      end
      4'b1000 :  // TEST
      begin
        {negative, zero, c_out, overflow} = A & B;
      end
      4'b1001 :  // TEST EQUIVALENCE
      begin
        {negative, zero, c_out, overflow} = A ^ B;
      end
			4'b1010 :  // COMP
			begin
        {negative, zero, c_out, overflow} = A - B;
			end
      4'b1011 : // COMPARE NEGATIVE
      begin
        {negative, zero, c_out, overflow} = A + B;
      end
			4'b1100 :   // OR
			begin
				ALUResult = A | B;
				zero = ~|ALUResult;
			end
      // 4'b1101 : // SHIFTS
      4'b1110 : // CLEAR
      begin
        ALUResult = A & ~B;
        {negative, zero} = A & ~B;
      end
			4'b1111 :   // NOT
			begin
				ALUResult = ~A;
      end
		endcase
		ALUFlags = {negative, zero, c_out, overflow};
	end
endmodule