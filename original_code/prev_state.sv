//==========================================================================
//                       PREVIOUS STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL and row above and below
// 
//==========================================================================

module prev_state #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2,
                 input  logic               regwrite, reset, 
                 input  logic [REGBITS-1:0] ra,
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   row_a, row, row_b);

   	logic	[WIDTH-1:0] RAM [2**REGBITS-1:0];

  // 4 ported register file
  // read three ports combinationally
  // write fourth port during phase2 (second half-cycle)
  
  always_latch
    if (ph2 & regwrite) begin
		RAM[ra] <= wd;
	 end
	 
	// 3 rows of data
	logic [REGBITS-1:0] ra1, ra2, ra3;
	
	assign ra1 = ra - 'b1;
	assign ra2 = ra;
	assign ra3 = ra + 'b1;

   assign row_a = RAM[ra1];
   assign row = RAM[ra2];
   assign row_b = RAM[ra3];  
  
endmodule
