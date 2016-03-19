//==========================================================================
//                              CONTROLLER
// RWSelect 1 for write, 0 for read
// every clock cycle, increment addr
// every 64 clock cycles is one frame
// every frame, increment count
// every 64 frames, switch from read to write for one frame
//==========================================================================

module controller (input logic ph1, input logic ph2, input logic reset,
				   output logic RWSelect, output logic [5:0] addr);

	logic [5:0] addr;
	logic [5:0] count;
	logic RWSelect;

	always @posedge(reset) begin
		addr = 6b'000000;
		count = 6b'000000;
		RWSelect = 1b'1;
	end

	always_latch begin

		if (addr == 7b'11111111) begin
			//increment counter every time the entire matrix is read or written through
			count <= count + 1b'1;
			
			//if we have gone through 64 life cycles, do a write
			if (count == 6b'000001) RWSelect <= 1b'0;
			
			//once the write is over, do a read
			if (count == 6b'000000) RWSelect <= 1b'1;
		end
		
		if (ph1) begin
			//increment address value
			addr = addr + 1b'1;
		end
		
	end
end


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