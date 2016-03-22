module testbench_current();
	logic ph1, ph2, regwrite, reset;
	logic [7:0] wd, rd, rd_exp;
	logic [3:0] addr;
	
	logic [31:0] vectornum, errors;
	logic [20:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	current_state dut(ph1, ph2, regwrite, reset, addr, addr, wd, rd);
	
	always begin
		clk = 1'b1; #5; clk = 1'b0; #5;
	end
	
	initial begin
		$readmemb("current.tv", testvectors)
		vectornum = 0; errors = 0;
	end
	
	always @(posedge ph1) begin
		#1; {regwrite, reset, addr, wd, rd_exp} = testvectors[vectornum];
	end
	
	always @(negedge ph2)
		if (rd !== rd_exp)
		begin
			$display("Error: inputs = %b; %b; %b; %b", regwrite, reset, addr, wd);
			$display("outputs = %b (%b expected)", rd, rd_exp)
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (testvectors[vectornum] === 10'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
		end
		$finish;
	
endmodule