module testbench_overall();
	logic ph1, ph2, reset;
	logic [7:0] row, col;
	cgol dut(ph1, ph2, reset, row, col);
	
	initial begin
		#5;
		reset <= 1;
		#5;
		reset <= 0;
	end
	
	always begin
		ph1 = 0; ph2 = 0;
		#1; ph1 = 1;
		#4; ph1 = 0;
		#1; ph2 = 1;
		#4; ph2 = 0;
	end
	
endmodule
