//==========================================================================
//                       CURRENT STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL
// 
//==========================================================================

module current_state #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               regwrite,
		 input  logic [3:0]         reset_lines,
                 input  logic [REGBITS-1:0] ra, 
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd);

   logic [WIDTH-1:0] RAM [2**REGBITS-1:0];

  // two ported register file
  // read one ports combinationally
  // write second port during phase2 (second half-cycle)
  
  always_latch
	if (ph2) begin
		if (reset_lines[0]) begin
			//r-pentomino
			RAM[0] <= 8'b00011000;
			RAM[1] <= 8'b00110000;
			RAM[2] <= 8'b00010000;
			RAM[3] <= 8'b0;
			RAM[4] <= 8'b0;
			RAM[5] <= 8'b0;
			RAM[6] <= 8'b0;
			RAM[7] <= 8'b0;
    		end
		else if (reset_lines[1]) begin
			RAM[0] <= 8'b00011000;
			RAM[1] <= 8'b01000010;
			RAM[2] <= 8'b01000010;
			RAM[3] <= 8'b01000010;
			RAM[4] <= 8'b00100100;
			RAM[5] <= 8'b10100101;
			RAM[6] <= 8'b11000011;
			RAM[7] <= 8'b00000000;
		end
		else if (reset_lines[2]) begin
			RAM[0] <= 8'b11000110;
			RAM[1] <= 8'b01010100;
			RAM[2] <= 8'b01101100;
			RAM[3] <= 8'b01010100;
			RAM[4] <= 8'b11000110;
			RAM[5] <= 8'b00000000;
			RAM[6] <= 8'b00000000;
			RAM[7] <= 8'b00000000;
		end
		else if (reset_lines[3]) begin
			RAM[0] <= 8'b01000000;
			RAM[1] <= 8'b10000000;
			RAM[2] <= 8'b11100000;
			RAM[3] <= 8'b00000011;
			RAM[4] <= 8'b00000011;
			RAM[5] <= 8'b11100000;
			RAM[6] <= 8'b10000000;
			RAM[7] <= 8'b01000000;
		end
    	else if (regwrite) begin
    		RAM[ra] <= wd;
    	end
  end
  assign rd = RAM[ra];
endmodule
