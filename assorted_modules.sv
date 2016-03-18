//==========================================================================
//                            DECODER MODULE
// returns true if the center cell, given by boolean input 'center', should
// be lit on the next generation (as determined by the 8-bit input 'sides')
//==========================================================================

module decoder (input  logic center, input logic [7:0] sides,
				output logic nexton);
	always_comb begin
	
		// sum the bits coming in
		logic [2:0] sum = sides[0] + sides[1] + sides[2] + sides[3] + sides[4] + sides[5] + sides[6] + sides[7];
		
		//consider center bits and bits of sum
		casex ({center, sum})
			4'bx011:
				// whether alive or dead, a cell with 3 neighbors lives on
				nexton = 1;
			4'b101x:
				// if a live cell has 2 or 3 neighbors, it survives
				nexton = 1;
			default:
				// it should die in all other situations
				nexton = 0;
		endcase
	end
endmodule


//==========================================================================
//                   DISPLAY CONTROLLER (no buffering)
//
// given inputs of bitline in and 6-bit address for bit to consider, choose
//                          which bits to output 
//
// assuming that addr is a 6-bit address between 1 and 64, addr[5:3] will
//              describe col and addr[2:0] will describe row
//
//==========================================================================

module dispcontrol (input logic [5:0] addr, input logic BitIn,
					output logic [5:0] row, output logic [5:0] col)
	always_latch begin
	
	end			
endmodule
					output logic [5:0] row, output logic [5:0] col);


					
endmodule