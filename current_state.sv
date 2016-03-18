//==========================================================================
//                       CURRENT STATE REGISTER FILE
// 	updates row when write is enabled
//	combinationally outputs the current row of the GoL
// 
//==========================================================================

module regfile #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               regwrite, 
                 input  logic [REGBITS-1:0] ra, wa, 
                 input  logic [WIDTH-1:0]   wd, 
                 output logic [WIDTH-1:0]   rd);

   logic [WIDTH-1:0] RAM [2**REGBITS-1:0];

  // three ported register file
  // read two ports combinationally
  // write third port during phase2 (second half-cycle)
  // register 0 hardwired to 0
  always_latch
    if (ph2 & regwrite) RAM[wa] <= wd;

  assign rd = ra ? RAM[ra] : 0;
endmodule