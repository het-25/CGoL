//==========================================================================
//                       CMOS Game of Life 
// 	Vaibhav Viswanathan, vviswanathan@hmc.edu
//  Evan Kahn, ekahn@hmc.edu
// 	
// 
//  A hardware implementation of Conway's Game of Life for an 8x8 LED grid
//==========================================================================


//==========================================================================
//                       TOP-LEVEL MODULE 
// 	top-level module for CMOS Game of Life
//  inputs: 2-phase clock and reset
// 	outputs: row and column logic for 8x8 LED grid
// 
//==========================================================================
module cgol #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               reset, 
                 output logic [WIDTH-1:0]   row, col);
	//instantiate wires
	logic [REGBITS-1:0] addr;
	logic 		RWSelect;
	logic [WIDTH-1:0]   wd; 
   	logic [WIDTH-1:0]   rd1, rd2, rd3, new_r;
	
	//instantiate submodules
	controller		controller1(ph1, ph2, reset, RWSelect, addr);
	prev_state 		prev_state1(ph1, ph2, RWSelect, reset, addr, addr, wd, rd1, rd2, rd3);
	decoder_top		top_decoder(rd2, rd1, rd3, new_r);
	current_state	current_state1(ph1, ph2, ~RWSelect, reset, addr, addr, new_r, wd);
	dispcontrol		disp_control(addr, wd, ph1, ph2, row, col);
	
endmodule

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

   	logic	[WIDTH-1:0] RAM [2**REGBITS-1:0];

  // 4 ported register file
  // read three ports combinationally
  // write fourth port during phase2 (second half-cycle)
  
  always_latch
    if (ph2 & regwrite) begin
		RAM[wa] <= wd;
	 end
	 
	// 3 rows of data
	logic [REGBITS-1:0] ra1, ra2, ra3;
	
	assign ra1 = ra - 'b1;
	assign ra2 = ra;
	assign ra3 = ra + 'b1;

   assign rd1 = RAM[ra1];
   assign rd2 = RAM[ra2];
   assign rd3 = RAM[ra3];  
  
endmodule

//==========================================================================
//                       CURRENT STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL
// 
//==========================================================================

module current_state #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               regwrite, reset,
                 input  logic [REGBITS-1:0] ra, wa, 
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd);

   logic [WIDTH-1:0] RAM [2**REGBITS-1:0];

  // two ported register file
  // read one ports combinationally
  // write second port during phase2 (second half-cycle)
  
  always_latch
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
   else if (ph2 & regwrite) RAM[wa] <= wd;

  assign rd = RAM[ra];
endmodule

//==========================================================================
//                         TOP-LEVEL DECODER MODULE
// computes the next state of an entire row using 8 decoder modules
//==========================================================================
module decoder_top (input logic [7:0] row_in, row_a, row_b,
					output logic [7:0] row_out);
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
//                              CONTROLLER
// RWSelect 1 for write, 0 for read
// every clock cycle, increment addr
// every 64 clock cycles is one frame
// every frame, increment count
// every 64 frames, switch from read to write for one frame
//==========================================================================

module controller (input logic ph1, input logic ph2, input logic reset,
				   output logic RWSelect, output logic [2:0] addr);

	logic [2:0] count;

	always_latch begin
	
		if (reset) begin
			addr = 3'b000;
			count = 6'b000000;
			RWSelect = 1'b1;
		end

		else if ((addr == 3'b111)&(ph1)) begin
			//increment counter every time the entire matrix is read or written through
			count <= count + 1'b1;
			
			//if we have gone through 64 life cycles, do a write
			if (count == 3'b111) RWSelect <= 1'b0;
			else RWSelect <= 1'b1;
			
			end
		
		if (ph1) begin
			//increment address value
			addr = addr + 1'b1;
		end
		
	end
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
		logic [2:0] sum;
		sum = sides[0] + sides[1] + sides[2] + sides[3] + sides[4] + sides[5] + sides[6] + sides[7];

		//consider center bits and bits of sum
		casex ({center, sum})
			4'b0011:
				// a dead cell with 3 neighbors comes back to life
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
// given inputs of bitline in and 3-bit address for bit to consider, choose
//                          which bits to output 
//==========================================================================

module dispcontrol (input logic [2:0] addr, input logic [7:0] BitIn, input logic ph1, input logic ph2,
					output logic [7:0] row, output logic [7:0] col);

	always_latch begin
		// if clock phase 1 and LED should be on
		if (ph1) begin
			row <= (8'b00000001 << addr);
			col <= ~BitIn;
		end	
	end	
endmodule