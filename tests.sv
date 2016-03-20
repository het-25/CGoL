module testbench_decoder();
	logic center;
	logic [7:0] sides;
	logic nexton;
	
	logic [31:0] vectornum, errors;
	logic [9:0] testvectors[100:0];
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