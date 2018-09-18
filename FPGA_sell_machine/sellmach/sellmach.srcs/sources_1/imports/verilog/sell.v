
module sell(
	one_dollar,
	half_dollar,
	reset,
	clk,
	collect,
	half_out,
	dispense);

	//---Ports declearation---
	input one_dollar;
	input half_dollar;
	input reset;
	input clk;
	output collect;
	output half_out;
	output dispense;

	wire one_dollar;
	wire half_dollar;
	wire reset;
	wire clk;
	reg collect;
	reg half_out;
	reg dispense;

	//----Code starts here-----
	parameter idle = 0,half = 1, one = 2, one_half = 3,two = 4;
	reg[2:0] D;
	always @(posedge clk)
		begin
			if(reset)
			begin
				dispense=0;collect=0;
				half_out=0;D=idle;
			end
		case (D)
		idle:
			if(half_dollar)
				D=half;
			else if(one_dollar)
				D=one;
		
		half:
			if(half_dollar)
				D=one;
			else if(one_dollar)
				D=one_half;
				
		one:
			if(half_dollar)
				D=one_half;
			else if(one_dollar)
				D=two;
		
		one_half:
			if(half_dollar)
				D=two;
			else if(one_dollar)
			begin
				dispense=1;
				collect=1;
				D=idle;
			end
		two:
			if(half_dollar)
			begin
				dispense=1;
				collect=1;
				D=idle;
			end
			else if(one_dollar)
			begin
				dispense=1;
				collect=1;
				half_out=1;
				D=idle;
			end
		endcase
	end
endmodule    //sell

