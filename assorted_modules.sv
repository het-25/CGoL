//==========================================================================
//                         TOP-LEVEL DECODER MODULE
// computes the next state of an entire row using 8 decoder modules
//==========================================================================
module decoder_top (input logic [7:0] row_in, row_a, row_b,
					output logic [7:0] row_out)
		decoder d0(row_in[0], { row_a[1:0],row_a[7], row_b[1:0],row_b[7], row_in[1], row_in[7] }, row_out[0]);
		decoder d1(row_in[1], { row_a[2:0],row_b[2:0], row_in[0], row_in[2] }, row_out[1]);
		decoder d2(row_in[2], { row_a[3:1],row_b[3:1], row_in[1], row_in[3] }, row_out[2]);
		decoder d3(row_in[3], { row_a[4:2],row_b[4:2], row_in[2], row_in[4] }, row_out[3]);
		decoder d4(row_in[4], { row_a[5:3],row_b[5:3], row_in[3], row_in[5] }, row_out[4]);
		decoder d5(row_in[5], { row_a[6:4],row_b[6:4], row_in[4], row_in[6] }, row_out[5]);
		decoder d6(row_in[6], { row_a[7:5],row_b[7:5], row_in[5], row_in[7] }, row_out[6]);
		decoder d7(row_in[7], { row_a[7:6],row_a[0], row_b[7:6],row_b[0], row_in[6], row_in[0] }, row_out[7]);
endmodule




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
//                           DISPLAY CONTROLLER
//
// given inputs of bitline in and 6-bit address for bit to consider, choose
//                          which bits to output 
//==========================================================================

module dispcontrol (input logic [5:0] addr, input logic [7:0] BitIn, input logic ph1, input logic ph2,
					output logic [7:0] row, output logic [7:0] col)

	always_latch begin
		// if clock phase 1 and LED should be on
		if (ph1) begin
			row <= (8'b00000001 << addr[5:3]);
			col <= ~BitIn;
		end	
	end	
	
endmodule