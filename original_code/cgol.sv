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
