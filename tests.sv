module testbench_decoder();
	logic center;
	logic [7:0] sides;
	logic nexton;
	
	logic [31:0] vectornum, errors;
	logic [9:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	decoder dut(center, sides, nexton);
	
	always begin
		clk = 1'b1; #5; clk = 1'b0; #5;
	end
	
	initial begin
		$readmemb("decoder.tv", testvectors)
		vectornum = 0; errors = 0;
	end
	
	always @(posedge clk) begin
		#1; 8{center, sides, nexton_exp} = testvectors[vectornum]
	end
	
	always @(negedge clk)
		if (nexton !== nexton_exp)
		begin
			$display("Error: inputs = %b; %b", center, sides);
			$display("outputs = %b (%b expected)", nexton, nexton_exp)
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (testvectors[vectornum] === 10'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
		end
		$finish;
	
endmodule

//not really actually a testbench; will just display stuff on LED matrix
module testbench_led(input logic clk; output logic[7:0] row; output logic[7:0] col);

	logic [2:0] linenum;
	logic [7:0] testvectors[7:0];

	//10-bit testvector format: {center, sides[7:0]}_nexton
	dispcontrol dut(addr, BitIn, ph1, ph2, row, col);
	
	always begin
		ph1 = 1'b1; ph2 = 1'b0; #5; ph1 = 1'b0; ph2 = 1'b1; #5;
		linenum = 0;
	end
	
	initial begin
		$readmemb("led.tv", testvectors)
	end
	
	always @(posedge clk) begin
		BitIn <= testvectors[linenum];
		ph1 <= 1b'1;
		ph2 <= 1b'0;
		linenum <= linenum + 1'b1;
	end
	
	always @(negedge clk) begin
		ph1 <= 1b'0;
		ph2 <= 1b'1;
	end
		
endmodule