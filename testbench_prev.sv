module testbench_prev();
	logic ph1, ph2, regwrite, reset;
	logic [7:0] wd, rd, rda, rdb, rd_exp, rda_exp, rdb_exp;
	logic [3:0] addr;
	
	logic [31:0] vectornum, errors;
	logic [35:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	current_state dut(ph1, ph2, regwrite, reset, addr, addr, wd, rd);
	
	always begin
		ph1 = 0; ph2 = 0; #3;
		ph1 = 1; #4;
		ph1 = 0; #3;
		ph2 = 1; #4;
	end
	
	initial begin
		$readmemb("prev.tv", testvectors);
		vectornum = 0; errors = 0;
		reset = 1; #3;
		reset = 0;
	end
	
	always @(posedge ph1) begin
		#1; {regwrite, addr, wd, rd_exp, rda_exp, rdb_exp} = testvectors[vectornum];
	end
	
	always @(negedge ph2)
		if ((rd !== rd_exp)|(rda !== rda_exp)|(rdb !== rdb_exp))
		begin
			$display("Error: inputs = %b; %b; %b; %b", regwrite, reset, addr, wd);
			$display("outputs = %b (%b expected),%b (%b expected),%b (%b expected)", rd, rd_exp, rda, rda_exp, rdb, rdb_exp);
			errors = errors + 1;
		end
		assign vectornum = vectornum + 1;
		if (testvectors[vectornum] === 10'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
			$finish;
		end
		
	
endmodule