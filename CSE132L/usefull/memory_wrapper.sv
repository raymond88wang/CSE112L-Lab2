
module mem (
            input  logic        clk,
            input  logic        we,
            input  logic [31:0] a,
            input  logic [31:0] wd,
            output logic [31:0] rd
            );
            
            
`ifdef sim

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always @(posedge clk)
    if (we)
      RAM[a[31:2]] <= wd;
      
      
  initial
    begin
      // will read the memfile.data from sim directory and preloads the RAM array.
      $readmemh("memfile.dat", RAM); // initialize memory
    end      
      
`else

   SRAM1RW512x32 RAM (
			.A       ( a[8:0] ),
			.CE      ( 1'b1   ),
			.WEB     ( ~we    ),
			.OEB     ( we     ),
			.CSB     ( 1'b0   ),
			.I       ( wd     ),
			.O       ( rd     )
			);

`endif

endmodule