module cgol #(parameter WIDTH = 8, REGBITS = 3)
                (input  logic               ph1, ph2, 
                 input  logic               reset, 
                 output logic [WIDTH-1:0]   row, column);
	//instantiate wires
	logic [2:0] addr;
	logic 		RWSelect;
	
	//instantiate submodules
	controller	controller1(ph1, ph2, reset, RWSelect, addr);
endmodule
