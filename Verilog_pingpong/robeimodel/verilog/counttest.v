`include "count.v"

module counttest();

	wire clk;
	wire countmax;

	//---Module instantiation---
	count count1(
		.clk(clk),
		.countmax(countmax));
	//----Code starts here-----
	initial
	begin
		clk=1'b0;
		#800000 $finish;
	end
	
	always #1 clk=~clk;
	
	initial begin
		$dumpfile ("C:/Users/Administrator/Desktop/robeimodel/counttest.vcd");
		$dumpvars;
	end
endmodule    //counttest

