module datapath(
    input logic clk, reset,
    input logic [1:0] RegSrc,
    input logic RegWrite,
    input logic [1:0] ImmSrc,
    input logic ALUSrc,
	input logic ShifterSrc,
    input logic [3:0] ALUControl,
    input logic MemtoReg,
    input logic PCSrc,
	input logic MemWrite,
	input logic Branch,
    output logic [3:0] ALUFlags,
    output logic [31:0] PC,
    input logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData);


    logic [31:0] PCNext, PCPlus4, PCPlus8;
    logic [31:0] ExtImm, SrcA, SrcB, Rd, Rs, BranchResult;
	logic [31:0] Result, ResultToPc;
    logic [3:0] RA1, RA2, ShifterFlags, AFlags, BranchFlags;
	


    // next PC logic
    mux2 #(32) pcmux(PCPlus4, ResultToPc, PCSrc, PCNext);
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    adder #(32) pcadd1(1'b0, PC, 32'b100, PCPlus4);
    adder #(32) pcadd2(1'b0, PCPlus4, 32'b100, PCPlus8);

    // register file logic
    mux2 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
    mux2 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
    regfile rf(clk, RegWrite, RA1, RA2,
        Instr[15:12], Instr[11:8], ResultToPc, PCPlus8, PCPlus4,
        SrcA, WriteData, Rs);		
    extend ext(Instr[23:0], ImmSrc, ExtImm);

    // ALU logic
	shifter shifter(Instr[25:0], WriteData, Rs, Rd, ShifterFlags);
    mux2 #(32) srcbmux(Rd, ExtImm, ALUSrc, SrcB);
    alu alu(SrcA, SrcB, ALUControl, ALUResult, AFlags);
	mux2 #(4) flagsmux(ShifterFlags, AFlags, ShifterSrc, ALUFlags);
	
	mux2 #(32) resmux(ALUResult, ReadData, MemtoReg, Result);
	immshift branchshift(4'b0010, 2'b00, ALUResult, BranchResult, BranchFlags);
	mux2 #(32) branchmux(Result, BranchResult, Branch, ResultToPc);
endmodule
