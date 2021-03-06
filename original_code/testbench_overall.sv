    module testbench_overall();
    //initialize variables
	logic ph1, ph2;
	logic [3:0] reset_lines;
	logic [7:0] row, col, row_exp, col_exp;
	logic [31:0] vectornum, errors;
	logic [15:0] testvectors[1000:0];

	
	initial $readmemb("gen.tv", testvectors); //read in testvectors
	initial vectornum = 0;
	initial errors = 0;
	assign reset = reset_lines[0]|reset_lines[1]|reset_lines[2]|reset_lines[3];

	cgol dut(ph1, ph2, reset_lines, row, col);

	// start with reset
	initial begin
		reset_lines <= 4'b0001; 
		#10;
		reset_lines <= 4'b0000;
	end
	
	// initialize two phase clock
	always begin
		ph1 = 0; ph2 = 0;
		#1; ph1 = 1;
		#4; ph1 = 0;
		#1; ph2 = 1;
		#4; ph2 = 0;
	end

	// apply testvectors on ph1
	always @(posedge ph1) begin
		{row_exp, col_exp} = testvectors[vectornum];
	end


	// compare expected to actual values on ph2
	always @(posedge ph2) begin
		if (!reset) begin
			if ((row !== row_exp)|(col !== col_exp))
			begin
				//$display("Error: inputs = %b; %b; %b; %b", row, row_exp, col, col_exp);
				$display("outputs = %b (%b expected) and %b (%b expected)\n vectornum: %d", row, row_exp, col, col_exp, vectornum);
				errors = errors + 1;
			end
			assign vectornum = vectornum + 1;
			
			if (testvectors[vectornum] === 16'bx) begin
				$display("Finished: %d vectors with %d errors", vectornum, errors);
				$finish;
			end
		end

	end
	
endmodule
