module cgol #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               reset_lines[3:0],, 
                 output logic [WIDTH-1:0]   row, col);
	//instantiate wires
	logic [REGBITS-1:0] addr;
	logic 		RWSelect;
	logic [WIDTH-1:0]   wd; 
   	logic [WIDTH-1:0]   rd1, rd2, rd3;

	//instantiate submodules
	
	all_synth all_synth1(ph1, ph2, reset_lines,
						 rd1, rd2, rd3,
						 row, col, wd,
						 RWSelect, addr[REGBITS-1:0]);
						 
//	current_state		current_state1(ph1, ph2, ~RWSelect, reset, addr, new_r, wd);	
	prev_state 		prev_state1(ph1, ph2, RWSelect, reset, addr, wd, rd1, rd2, rd3);

	
endmodule

//==========================================================================
//						   ALL SYNTHESIZED MODULES
//			module containing all logic intended for synthesis
//
//
//==========================================================================

module all_synth (input logic ph1, input logic ph2, input logic reset_lines[3:0],
				  input logic [7:0] rd1, rd2, rd3,
				  output logic [7:0] row, col, wd,
				  output logic RWSelect, output logic [2:0] addr);
	logic [7:0] new_r;

	assign reset = |reset_lines;

	controller		controller1(ph1, ph2, reset, RWSelect, addr);
	decoder_top		top_decoder(rd2, rd1, rd3, new_r);
	dispcontrol		disp_control(addr, wd, ph1, ph2, row, col);
	current_state		current_state1(ph1, ph2, ~RWSelect, reset_lines, addr, new_r, wd);

endmodule
