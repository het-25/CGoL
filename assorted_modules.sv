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



