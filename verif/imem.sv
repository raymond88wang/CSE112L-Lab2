module imem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[511:0];

    // ALU Test
    /* assign RAM[0] = 32'hE3A000AA;
    assign RAM[1] = 32'hE3A01055;
    assign RAM[2] = 32'hE3A020FF;
    assign RAM[3] = 32'hE3A09000;
    assign RAM[4] = 32'hE1A03400;
    assign RAM[5] = 32'hE1833000;
    assign RAM[6] = 32'hE1A03403;
    assign RAM[7] = 32'hE1833000;
    assign RAM[8] = 32'hE1A03403;
    assign RAM[9] = 32'hE1833000;
    assign RAM[10] = 32'hE1A04402;
    assign RAM[11] = 32'hE1844002;
    assign RAM[12] = 32'hE1A04404;
    assign RAM[13] = 32'hE1844002;
    assign RAM[14] = 32'hE1A04404;
    assign RAM[15] = 32'hE1844002;
    assign RAM[16] = 32'hE1A05401;
    assign RAM[17] = 32'hE1855001;
    assign RAM[18] = 32'hE1A05405;
    assign RAM[19] = 32'hE1855001;
    assign RAM[20] = 32'hE1A05405;
    assign RAM[21] = 32'hE1855001;
    assign RAM[22] = 32'hE0036005;
    assign RAM[23] = 32'hE1160004;
    assign RAM[24] = 32'h02899001;
    assign RAM[25] = 32'hE1836005;
    assign RAM[26] = 32'hE3A00000;
    assign RAM[27] = 32'hE1360000;
    assign RAM[28] = 32'h12899001;
    assign RAM[29] = 32'hE0836005;
    assign RAM[30] = 32'hE0866003;
    assign RAM[31] = 32'hE24660A9;
    assign RAM[32] = 32'hE3A000AA;
    assign RAM[33] = 32'hE1866000;
    assign RAM[34] = 32'hE1560003;
    assign RAM[35] = 32'h02899001;
    assign RAM[36] = 32'hE1E06003;
    assign RAM[37] = 32'hE1560005;
    assign RAM[38] = 32'h02899001;
    assign RAM[39] = 32'hE1C36005;
    assign RAM[40] = 32'hE1560003;
    assign RAM[41] = 32'h02899001;
    assign RAM[42] = 32'hE0236005;
    assign RAM[43] = 32'hE1560004;
    assign RAM[44] = 32'h02899001;
    assign RAM[45] = 32'hE1A06403;
    assign RAM[46] = 32'hE0436006;
    assign RAM[47] = 32'hE35600AA;
    assign RAM[48] = 32'h02899001;
    assign RAM[49] = 32'hE1A060E3;
    assign RAM[50] = 32'hE1560005;
    assign RAM[51] = 32'h02899001;
    assign RAM[52] = 32'hE1A06023;
    assign RAM[53] = 32'hE3560000;
    assign RAM[54] = 32'h02899001;
    assign RAM[55] = 32'hE3A000FC;
    assign RAM[56] = 32'hE5809000;
    assign RAM[57] = 32'hEAFFFFFE; */

    // LDR STR Test
	//									  op 
    assign RAM[0] = 32'hE3A09000;  //1110 00 1 1101 0 0000 1001 0000 0000 0000  //MOV 9 0000 0000 0000
    assign RAM[1] = 32'hE3A000C8;  //1110 00 1 1101 0 0000 0000 0000 1100 1000  //MOV 0 0000 1100 1000
    assign RAM[2] = 32'hE3A02014;  //1110 00 1 1101 0 0000 0010 0000 0001 0100  //MOV 2 0000 0001 0100
    assign RAM[3] = 32'hE3A03004;  //1110 00 1 1101 0 0000 0011 0000 0000 0100  //MOV 3 0000 0000 0100
    assign RAM[4] = 32'hE5802004;  //1110 01 011 000 0000 0010 0000 0000 0100   //STR 2
    assign RAM[5] = 32'hE5901004;  //1110 01 011 001 0000 0001 0000 0000 0100   //LDR 1
    assign RAM[6] = 32'hE1510002;  //1110 00 0 1010 1 0001 0000 0000 0000 0010
    assign RAM[7] = 32'h02899001;  //0000 00 1 0100 0 1001 1001 0000 0000 0001
    assign RAM[8] = 32'hE3A000D0;  //1110 00 1 1101 0 0000 0000 0000 1101 0000
    assign RAM[9] = 32'hE3A0205A;  //1110 00 1 1101 0 0000 0010 0000 0101 1010
    assign RAM[10] = 32'hE5C02000; //1110 01 011 100 0000 0010 0000 0000 0000 //STRB 1st byte
    assign RAM[11] = 32'hE5D06000; //1110 01 011 101 0000 0110 0000 0000 0000 //LDRB 1st byte
    assign RAM[12] = 32'hE1520006; //1110 00 0 1010 1 0010 0000 0000 0000 0110
    assign RAM[13] = 32'h02899001; //0000 00 1 0100 0 1001 1001 0000 0000 0001
    assign RAM[14] = 32'hE2822001; //1110 00 1 0100 0 0010 0010 0000 0000 0001
    assign RAM[15] = 32'hE5C02001; //1110 01 011 100 0000 0010 0000 0000 0001 //STRB 2nd byte
    assign RAM[16] = 32'hE5D06001; //1110 01 011 101 0000 0110 0000 0000 0001 //LDRB 2nd byte
    assign RAM[17] = 32'hE1520006; //1110 00 0 1010 1 0010 0000 0000 0000 0110
    assign RAM[18] = 32'h02899001; //0000 00 1 0100 0 1001 1001 0000 0000 0001
    assign RAM[19] = 32'hE2822001; //1110 00 1 0100 0 0010 0010 0000 0000 0001
    assign RAM[20] = 32'hE5C02002; //1110 01 011 100 0000 0010 0000 0000 0010 //STRB 3rd byte
    assign RAM[21] = 32'hE5D06002; //1110 01 011 101 0000 0110 0000 0000 0010 //LDRB 3rd byte
    assign RAM[22] = 32'hE1520006; //1110 00 0 1010 1 0010 0000 0000 0000 0110
    assign RAM[23] = 32'h02899001; //0000 00 1 0100 0 1001 1001 0000 0000 0001
    assign RAM[24] = 32'hE2822001; //1110 00 1 0100 0 0010 0010 0000 0000 0001
    assign RAM[25] = 32'hE5C02003; //1110 01 011 100 0000 0010 0000 0000 0011  //STRB 4th byte
    assign RAM[26] = 32'hE5D06003; //1110 01 011 101 0000 0110 0000 0000 0011  //LDRB 4th byte
    assign RAM[27] = 32'hE1520006; //1110 00 0 1010 1 0010 0000 0000 0000 0110
    assign RAM[28] = 32'h02899001; //0000 00 1 0100 0 1001 1001 0000 0000 0001
    assign RAM[29] = 32'hE3A000FC; //1110 00 1 1101 0 0000 0000 0000 1111 1100
    assign RAM[30] = 32'hE5809000; //1110 01 011 000 0000 1001 0000 0000 0000 //STR
    assign RAM[31] = 32'hEAFFFFFE; //1110 10 1 0111 1 1111 1111 1111 1111 1110
   

    // Regression
    
    // assign RAM[0] = 32'he3a09000; //1110 0011 1010 0000 1001 0000 0000 0000
    // assign RAM[1] = 32'he3a00008;
    // assign RAM[2] = 32'heb00000a;
    // assign RAM[3] = 32'he3a06003;
    // assign RAM[4] = 32'he1510006;
    // assign RAM[5] = 32'h0b000017;
    // assign RAM[6] = 32'he3a0000f;
    // assign RAM[7] = 32'heb00000f;
    // assign RAM[8] = 32'he3a06078;
    // assign RAM[9] = 32'he1500006;
    // assign RAM[10] = 32'h0b000012;
    // assign RAM[11] = 32'he3a000fc;
    // assign RAM[12] = 32'he5809000;
    // assign RAM[13] = 32'heafffffe;
    // assign RAM[14] = 32'he3a02000;
    // assign RAM[15] = 32'he3e01000;
    // assign RAM[16] = 32'he3100001;
    // assign RAM[17] = 32'h12822001;
    // assign RAM[18] = 32'he2811001;
    // assign RAM[19] = 32'he1b000a0;
    // assign RAM[20] = 32'h1afffffa;
    // assign RAM[21] = 32'he3520001;
    // assign RAM[22] = 32'h03a00001;
    // assign RAM[23] = 32'he1a0f00e;
    // assign RAM[24] = 32'he3a01000;
    // assign RAM[25] = 32'he0811000;
    // assign RAM[26] = 32'he2500001;
    // assign RAM[27] = 32'h1afffffc;
    // assign RAM[28] = 32'he1a00001;
    // assign RAM[29] = 32'he1a0f00e;
    // assign RAM[30] = 32'he3a00001;
    // assign RAM[31] = 32'he0899000;
    // assign RAM[32] = 32'he1a0f00e;
    


    // Bonus credit
    /*
    assign RAM[0] = 32'hE3A09000;
    assign RAM[1] = 32'hE3A000C8; //1110 0011 1010 0000 0000 0000 1100 1000
    assign RAM[2] = 32'hE3A02014;
    assign RAM[3] = 32'hE3A03004;
    assign RAM[4] = 32'hE3A04002;
    assign RAM[5] = 32'hE5802004;
    assign RAM[6] = 32'hE5901004;
    assign RAM[7] = 32'hE1510002;
    assign RAM[8] = 32'h02899001;
    assign RAM[9] = 32'hE3A000D0;
    assign RAM[10] = 32'hE3A020FF;
    assign RAM[11] = 32'hE0822002;
    assign RAM[12] = 32'hE1C020B0;
    assign RAM[13] = 32'hE1D060B0;
    assign RAM[14] = 32'hE1520006;
    assign RAM[15] = 32'h02899001;
    assign RAM[16] = 32'hE2822001;
    assign RAM[17] = 32'hE1C020B2;
    assign RAM[18] = 32'hE1D060B2;
    assign RAM[19] = 32'hE1520006;
    assign RAM[20] = 32'h02899001;
    assign RAM[21] = 32'hE3A000FC;
    assign RAM[22] = 32'hE5809000;
    assign RAM[23] = 32'hEAFFFFFE;
    */

    assign rd = RAM[a[31:2]]; // word aligned

endmodule
