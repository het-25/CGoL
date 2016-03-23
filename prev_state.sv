//==========================================================================
//                       PREVIOUS STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL and row above and below
// 
//==========================================================================

module prev_state #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2,
                 input  logic               regwrite, reset, 
                 input  logic [REGBITS-1:0] ra, wa,
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd1, rd2, rd3);

   logic	[WIDTH-1:0] RAM1 [2**REGBITS-1:0];
	logic	[WIDTH-1:0] RAM2 [2**REGBITS-1:0];

  // 3 ported register file & 2 ported register file
  // read three ports combinationally
  // write third port during phase2 (second half-cycle)
  // register 0 hardwired to 0
  always_ff
	 if (ph2 & reset) begin
		RAM1[0] <= 8'b00011000;
		RAM1[1] <= 8'b00110000;
		RAM1[2] <= 8'b00010000;
		RAM1[3] <= 8'b0;
		RAM1[4] <= 8'b0;
		RAM1[5] <= 8'b0;
		RAM1[6] <= 8'b0;
		RAM1[7] <= 8'b0;
		
		RAM2[0] <= 8'b00011000;
		RAM2[1] <= 8'b00110000;
		RAM2[2] <= 8'b00010000;
		RAM2[3] <= 8'b0;
		RAM2[4] <= 8'b0;
		RAM2[5] <= 8'b0;
		RAM2[6] <= 8'b0;
		RAM2[7] <= 8'b0;
	 end
	 
    else if (ph2 & regwrite) begin
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
