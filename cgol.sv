module cgol #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               clk, 
                 input  logic               reset, 
                 output logic [WIDTH-1:0]   row, col,
					  output logic ph1, ph2,
					  output logic RWSelect);
	//instantiate wires
	logic [REGBITS-1:0] addr;
	//logic 		RWSelect;
	//logic ph1, ph2;
	logic ph1_prev;
	logic [WIDTH-1:0]   wd; 
   logic [WIDTH-1:0]   rd1, rd2, rd3, new_r;
	logic [29:0] top_count;
	
	always_ff begin
		if (reset) begin
			ph1 <= 1;
			ph2 <= 0;
		end
		
		@(posedge clk) begin
				top_count <= top_count + 1'b1;
				if (|top_count == 0) begin
					ph1 <= ~ph1;
					ph2 <= ~ph2;
				end
		end
	end
	
	
	
	//instantiate submodules
	controller		controller1(ph1, ph2, reset, RWSelect, addr);
	prev_state 		prev_state1(ph1, ph2, RWSelect, reset, addr, addr, wd, rd1, rd2, rd3);
	decoder_top		top_decoder(rd2, rd1, rd3, new_r);
	current_state	current_state1(ph1, ph2, ~RWSelect, reset, addr, addr, new_r, wd);
	dispcontrol		disp_control(addr, wd, ph1, ph2, row, col);
	
endmodule
