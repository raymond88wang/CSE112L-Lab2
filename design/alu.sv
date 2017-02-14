module alu(
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    input logic [1:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic [3:0] ALUFlags   // {Neg, Zero, Carry, Overflow}
    );

    logic neg_flag;
    logic zero_flag;
    logic carry_flag;
    logic overflow_flag;

    assign ALUFlags = {neg_flag, zero_flag, carry_flag, overflow_flag};

    assign zero_flag = ~|ALUResult;
    assign neg_flag = ALUResult[31];

    always_comb
    begin
        ALUResult = 'd0;
        carry_flag = 'd0;
        overflow_flag = 'd0;

        case(ALUControl)
        2'b00 :     //add
        begin
            {carry_flag, ALUResult} = SrcA + SrcB;
            if (~SrcA[31] & ~SrcB[31] & ALUResult[31])
                overflow_flag = 1'b1;
            else if (SrcA[31] & SrcB[31] & ~ALUResult[31])
                overflow_flag = 1'b1;
            else
                overflow_flag = 1'b0;
        end
        2'b01 :     //sub
        begin
            {carry_flag, ALUResult} = SrcA - SrcB;
            if (~SrcA[31] & SrcB[31] & ALUResult[31])
                overflow_flag = 1'b1;
            else if (SrcA[31] & ~SrcB[31] & ~ALUResult[31])
                overflow_flag = 1'b1;
            else
                overflow_flag = 1'b0;
        end
        2'b10 :     //and
        begin
            ALUResult = SrcA & SrcB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        2'b11 :     //or
        begin
            ALUResult = SrcA | SrcB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        default :
        begin
            ALUResult = 'd0;
            carry_flag = 'd0;
            overflow_flag = 'd0;
        end
        endcase
    end

endmodule
