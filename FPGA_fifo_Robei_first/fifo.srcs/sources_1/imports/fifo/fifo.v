
module fifo(
	rst,
	clr,
	clk,
	data_in,
	wr,
	rd,
	data_out,
	full,
	empty,
	fifo_cnt);

	//---Ports declearation---
	input rst;
	input clr;
	input clk;
	input [3:0] data_in;
	input wr;
	input rd;
	output [3:0] data_out;
	output full;
	output empty;
	output [3:0] fifo_cnt;

	wire rst;
	wire clr;
	wire clk;
	wire [3:0] data_in;
	wire wr;
	wire rd;
	reg [3:0] data_out;
	wire full;
	wire empty;
	reg [3:0] fifo_cnt;

	//----Code starts here-----
	reg [7:0] fifo_ram[0:7];
	  reg [2:0] rd_ptr, wr_ptr;
	  assign empty = (fifo_cnt==0);
	  assign full = (fifo_cnt==8);
	always @( posedge clk ) begin: write
	if(wr && !full)
	fifo_ram[wr_ptr] <= data_in;
	else if(wr && rd)
	fifo_ram[wr_ptr] <= data_in;
	end
	always @( posedge clk ) begin: read
	if(rd && !empty)
	data_out <= fifo_ram[rd_ptr];
	else if(rd && wr)
	data_out <= fifo_ram[rd_ptr];
	end
	always @( posedge clk or posedge clr) begin: pointer
	if( !rst || clr ) 
	begin
	wr_ptr <= 0;
	rd_ptr <= 0;
	end 
	else 
	begin
	wr_ptr <= ((wr && !full)||(wr && rd)) ? wr_ptr+1 :
	wr_ptr;
	rd_ptr <= ((rd && !empty)||(wr && rd)) ? rd_ptr+1 :
	rd_ptr;
	end
	end
	always @( posedge clk or posedge clr ) begin: count
	if( !rst || clr) 
	fifo_cnt <= 0;
	else begin
	case ({wr,rd})
	2'b00 : fifo_cnt <= fifo_cnt;
	2'b01 : fifo_cnt <= (fifo_cnt==0) ? 0 : fifo_cnt-1;
	2'b10 : fifo_cnt <= (fifo_cnt==8) ? 8 : fifo_cnt+1;
	2'b11 : fifo_cnt<=fifo_cnt;
	default: fifo_cnt <= fifo_cnt;
	endcase
	end
	end
	
endmodule    //fifo
