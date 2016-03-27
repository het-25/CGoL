module testbench_top_decoder();
	logic [7:0] row_in, row_a, row_b, row_out, row_out_exp;
	logic ph1, ph2;
	
	logic [31:0] vectornum, errors;
	logic [31:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	decoder_top dut(row_in, row_a, row_b, row_out);

	initial $readmemb("top_decoder.tv", testvectors);
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
		#1; {row_in, row_a, row_b, row_out_exp} = testvectors[vectornum];
	end
	
	always @(posedge ph2) begin
		if (row_out !== row_out_exp)
		begin
			$display("Error: inputs = %b; %b; %b", row_in, row_a, row_b);
			$display("outputs = %b (%b expected)", row_out, row_out_exp);
			errors = errors + 1;
		end
		
		assign vectornum = vectornum + 1;
		
		if (testvectors[vectornum] === 32'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
			$finish;
		end

	end
	
endmodule
