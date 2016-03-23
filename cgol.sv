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
