module testbench_decoder();
	logic center;
	logic [7:0] sides;
	logic nexton, nexton_exp;
	logic ph1, ph2;
	
	logic [31:0] vectornum, errors;
	logic [9:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	decoder dut(center, sides, nexton);

	initial $readmemb("decoder.tv", testvectors);
	initial vectornum = 0;
	initial errors = 0;
	

	always begin
		ph1 = 0; ph2 = 0;
		#1; ph1 = 1;
		#4; ph1 = 0;
		#1; ph2 = 1;
		#4; ph2 = 0;
	end
	
	always @(posedge ph1) begin
		#1; {center, sides, nexton_exp} = testvectors[vectornum];
	end
	
	always @(posedge ph2) begin
		if (nexton !== nexton_exp)
		begin
			$display("Error: inputs = %b; %b", center, sides);
			$display("outputs = %b (%b expected)", nexton, nexton_exp);
			errors = errors + 1;
		end
		
		assign vectornum = vectornum + 1;
		
		if (testvectors[vectornum] === 10'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
			$finish;
		end

	end
	
endmodule
