module testbench_decoder();
	logic center;
	logic [7:0] sides;
	logic nexton, nexton_exp;
	logic ph1, ph2;
	
	logic [31:0] vectornum, errors;
	logic [9:0] testvectors[500:0];
	//10-bit testvector format: {center, sides[7:0]}_nexton
	decoder dut(center, sides, nexton);
	
	always begin
		ph1 = 0; ph2 = 0;
		#1; ph1 = 1;
		#4; ph1 = 0;
		#1; ph2 = 1;
		#4; ph2 = 0;
	end
	
	initial begin
		$readmemb("decoder.tv", testvectors);
		vectornum = 0; errors = 0;
	end
	
	always @(ph1) begin
		#1; {center, sides, nexton_exp} = testvectors[vectornum];
	end
	
	always @(ph2) begin
		if (nexton !== nexton_exp)
		begin
			$display("Error: inputs = %b; %b", center, sides);
			$display("outputs = %b (%b expected)", nexton, nexton_exp);
			errors = errors + 1;
		end
		
		assign vectornum = vectornum + 1;
		
		if (testvectors[vectornum] === 10'bx) begin
			$display("Finished: %d vectors with %d errors", vectornum, errors);
		end
		$finish;
	end
	
endmodule

//not really actually a testbench; will just display stuff on LED matrix
module LEDTest(input logic clk, input logic reset, output logic[7:0] row, output logic[7:0] col);

	logic [2:0] addr;
	logic [7:0] testvectors[7:0];
	logic [7:0] BitIn;
	
	assign testvectors[0] = 8'b11100000;
	assign testvectors[1] =	8'b10001010;
	assign testvectors[2] = 8'b11101010;
	assign testvectors[3] =	8'b10001110;
	assign testvectors[4] =	8'b00000000;
	assign testvectors[5] =	8'b11101011;
	assign testvectors[6] =	8'b10001100;
	assign testvectors[7] = 8'b11101011;

	//10-bit testvector format: {center, sides[7:0]}_nexton
	dispcontrol dut(addr, BitIn, ph1, ph2, row, col);
	
	assign ph1 = clk;
	assign ph2 = ~clk;
	
	always_ff @(posedge clk) begin
		BitIn <= testvectors[addr];
		addr <= addr + 1'b1;
	end
	
		
endmodule