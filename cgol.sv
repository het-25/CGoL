module cgol #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               regwrite, 
                 input  logic [REGBITS-1:0] ra, wa,
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd1, rd2, rd3);

   logic	[WIDTH-1:0] RAM1 [2**REGBITS-1:0];
	logic	[WIDTH-1:0] RAM2 [2**REGBITS-1:0];

  // three ported register file
  // read two ports combinationally
  // write third port during phase2 (second half-cycle)
  // register 0 hardwired to 0
  always_latch
    if (ph2 & regwrite) 
	 begin
		RAM1[wa] <= wd;
		RAM2[wa] <= wd;
	 end
	 
	// 3 rows of data
	logic [REGBITS-1:0] ra1, ra2, ra3;
	
	assign ra1 = ra - 'b1;
	assign ra2 = ra;
	assign ra3 = ra + 'b1;

	
  assign rd1 = ra1 ? RAM1[ra1] : 0;
  assign rd2 = ra2 ? RAM1[ra2] : 0;
  assign rd3 = ra3 ? RAM2[ra3] : 0;
  
  
endmodule
