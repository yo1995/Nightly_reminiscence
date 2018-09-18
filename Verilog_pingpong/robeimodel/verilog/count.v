
module count(
	clk,
	countmax);

	//---Ports declearation---
	input clk;
	output countmax;

	wire clk;
	wire countmax;

	//----Code starts here-----
	reg [18:0] count;
	
	assign countmax = (count == 200000);
	assign count =0;
	
	always @(posedge clk)
	begin
	if(countmax)
	count <= 0;
	else
	count <= count + 1;
	end
endmodule    //count

