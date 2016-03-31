//==========================================================================
//                       CURRENT STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL
// 
//==========================================================================

module current_state #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               regwrite, reset,
                 input  logic [REGBITS-1:0] ra, 
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd);

   logic [WIDTH-1:0] RAM [2**REGBITS-1:0];

  // two ported register file
  // read one ports combinationally
  // write second port during phase2 (second half-cycle)
  
  always_latch
	if (ph2) begin
		if (reset) begin
			RAM[0] <= 8'b00011000;
			RAM[1] <= 8'b00110000;
			RAM[2] <= 8'b00010000;
			RAM[3] <= 8'b0;
			RAM[4] <= 8'b0;
			RAM[5] <= 8'b0;
			RAM[6] <= 8'b0;
			RAM[7] <= 8'b0;
    		end
    	else if (regwrite) begin
    		RAM[ra] <= wd;
    	end
  end
  assign rd = RAM[ra];
endmodule