//==========================================================================
//                       CMOS Game of Life 
// 	Vaibhav Viswanathan, vviswanathan@hmc.edu
//  Evan Kahn, ekahn@hmc.edu
// 	
// 
//  A hardware implementation of Conway's Game of Life for an 8x8 LED grid
//==========================================================================

// Set delay unit to 1 ns and simulation precision to 0.1 ns (100 ps)
`timescale 1ns / 100ps 

    module testbench_overall();
    //initialize variables
	logic ph1, ph2, reset;
	logic [7:0] row, col, row_exp, col_exp;
	logic [31:0] vectornum, errors;
	logic [15:0] testvectors[500:0];
	cgol dut(ph1, ph2, reset, row, col);
	
	initial $readmemb("overall.tv", testvectors); //read in testvectors
	initial vectornum = 0;
	initial errors = 0;

	// start with reset
	initial begin
		reset <= 1; 
		#10;
		reset <= 0;
	end
	
	// initialize two phase clock
	always begin
		ph1 = 0; ph2 = 0;
		#1; ph1 = 1;
		#4; ph1 = 0;
		#1; ph2 = 1;
		#4; ph2 = 0;
	end

	// apply testvectors on ph1
	always @(posedge ph1) begin
		{row_exp, col_exp} = testvectors[vectornum];
	end


	// compare expected to actual values on ph2
	always @(posedge ph2) begin
		if (!reset) begin
			if ((row !== row_exp)|(col !== col_exp))
			begin
				//$display("Error: inputs = %b; %b; %b; %b", row, row_exp, col, col_exp);
				$display("outputs = %b (%b expected) and %b (%b expected)\n vectornum: %d", row, row_exp, col, col_exp, vectornum);
				errors = errors + 1;
			end
			assign vectornum = vectornum + 1;
			
			if (testvectors[vectornum] === 16'bx) begin
				$display("Finished: %d vectors with %d errors", vectornum, errors);
				$finish;
			end
		end

	end
	
endmodule


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
	
	all_synth all_synth1(ph1, ph2, reset,
						 rd1, rd2, rd3, wd,
						 row, col,
						 RWSelect, addr[REGBITS-1:0], new_r);
						 
	current_state	current_state1(ph1, ph2, ~RWSelect, reset, addr, addr, new_r, wd);	
	prev_state 		prev_state1(ph1, ph2, RWSelect, reset, addr, addr, wd, rd1, rd2, rd3);

	
endmodule

//==========================================================================
//						   ALL SYNTHESIZED MODULES
//			module containing all logic intended for synthesis
//
//
//==========================================================================

module all_synth (input logic ph1, input logic ph2, input logic reset,
				  input logic [7:0] rd1, rd2, rd3, wd,
				  output logic [7:0] row, col,
				  output logic RWSelect, output logic [2:0] addr, output logic [7:0] new_r);

	controller		controller1(ph1, ph2, reset, RWSelect, addr);
	decoder_top		top_decoder(rd2, rd1, rd3, new_r);
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
                 output logic [WIDTH-1:0]   row_a, row, row_b);

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

   assign row_a = RAM[ra1];
   assign row = RAM[ra2];
   assign row_b = RAM[ra3];  
  
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
//                           SUBMODULES
//
// Basic submodules for cgol
//==========================================================================

module flop #(parameter WIDTH = 8)
             (input  logic             ph1, ph2, 
              input  logic [WIDTH-1:0] d, 
              output logic [WIDTH-1:0] q);

  logic [WIDTH-1:0] mid;

  latch #(WIDTH) master(ph2, d, mid);
  latch #(WIDTH) slave(ph1, mid, q);
endmodule

module flopr #(parameter WIDTH = 8)
               (input  logic             ph1, ph2, reset,
                input  logic [WIDTH-1:0] d, 
                output logic [WIDTH-1:0] q);

  logic [WIDTH-1:0] d2, resetval;

  assign resetval = 0;

  mux2 #(WIDTH) enmux(q, 1'b0, en, d2);
  flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

module flopen #(parameter WIDTH = 8)
               (input  logic             ph1, ph2, en,
                input  logic [WIDTH-1:0] d, 
                output logic [WIDTH-1:0] q);

  logic [WIDTH-1:0] d2;

  mux2 #(WIDTH) enmux(q, d, en, d2);
  flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

module flopenr #(parameter WIDTH = 8)
                (input  logic             ph1, ph2, reset, en,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);
 
  logic [WIDTH-1:0] d2, resetval;

  assign resetval = 0;

  mux3 #(WIDTH) enrmux(q, d, resetval, {reset, en}, d2);
  flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

module latch #(parameter WIDTH = 8)
              (input  logic             ph, 
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

  always_latch
    if (ph) q <= d;
endmodule

module mux2 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, 
              input  logic             s, 
              output logic [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);

  always_comb 
    casez (s)
      2'b00: y = d0;
      2'b01: y = d1;
      2'b1?: y = d2;
    endcase
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

module controller #(parameter COUNT_W = 3)
				(input logic ph1, input logic ph2, input logic reset,
				   output logic RWSelect, output logic [2:0] addr);

	logic [2:0] count;

	flopenr #(COUNT_W) count_flop (ph1, ph2, reset, 1'b1, count + {(COUNT_W-1)'b0, (1'b1 && (&addr))}, count);
	flopenr #(3) addr_flop (ph1, ph2, reset, 1'b1, addr + 3'b001, addr);
	assign RWSelect = ~&count;
	
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
			if (ph1) begin
				row <= (8'b00000001 << addr);
				col <= ~BitIn;
			end
		end
endmodule