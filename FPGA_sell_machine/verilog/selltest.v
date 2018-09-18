`include "sell.v"

module selltest();

	reg one_dollar;
	reg half_dollar;
	reg reset;
	reg clk;
	wire collect;
	wire half_out;
	wire dispense;

	//---Module instantiation---
	sell sell1(
		.one_dollar(one_dollar),
		.half_dollar(half_dollar),
		.reset(reset),
		.clk(clk),
		.collect(collect),
		.half_out(half_out),
		.dispense(dispense));
	//----Code starts here-----
	initial begin
	one_dollar=0;
	half_dollar=0;
	reset=1;
	clk=0;
	
	#100 reset=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	#20 reset=1;
	
	#100 reset=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	repeat(2)@(posedge clk);
	#2 one_dollar=1;
	repeat(1)@(posedge clk);
	#2 one_dollar=0;
	#20 reset=1;
	#5 $finish;
	end
	always#10 clk=~clk;
	initial begin
		$dumpfile ("C:/Users/Administrator/Desktop/robei/selltest.vcd");
		$dumpvars;
	end
endmodule    //selltest

