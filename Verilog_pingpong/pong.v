// Pong VGA game

module pong(clkl16, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B, btn0, btn3);
input clkl16;
output vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B;
input btn0, btn3;

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

wire clk;

clk_wiz_0 thepll(.clk_in1(clkl16), .clk_out1(clk), .reset(), .locked());

hvsync_generator syncgen(.clk(clk), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));


  // Clock in ports
  // Clock out ports
  // Status and control signals
  
  
/////////////////////////////////////////////////////////////////
reg [8:0] PaddlePosition;
wire btn0;
wire btn3;

reg [19:0] count;
wire countmax = (count==800000);  //产生时钟防止按键按下变换过快，每�?0.16s给一个脉冲信�?
always @(posedge clk)
begin
if(countmax)
	begin
	count <= 0;
		if(btn0)
		begin
			if(~&PaddlePosition)        // make sure the value doesn't overflow左侧不越�?
				PaddlePosition <= PaddlePosition + 1;
		end
		else if(btn3)
		begin
			if(|PaddlePosition)        // make sure the value doesn't underflow右侧不越�?
				PaddlePosition <= PaddlePosition - 1;
		end
	end
else
	count <= count + 1;
end

/////////////////////////////////////////////////////////////////
reg [9:0] ballX;
reg [8:0] ballY;
reg ball_inX, ball_inY;

always @(posedge clk)
if(ball_inX==0) ball_inX <= (CounterX==ballX) & ball_inY; else ball_inX <= !(CounterX==ballX+16);

always @(posedge clk)
if(ball_inY==0) ball_inY <= (CounterY==ballY); else ball_inY <= !(CounterY==ballY+16);

wire ball = ball_inX & ball_inY;

/////////////////////////////////////////////////////////////////
wire border = (CounterX[9:3]==0) || (CounterX[9:3]==79) || (CounterY[8:3]==0) || (CounterY[8:3]==99);  //   使下边border远离，实现不显示的目的
wire paddle = (CounterX>=PaddlePosition+8) && (CounterX<=PaddlePosition+120) && (CounterY[8:4]==27);
wire BouncingObject = border | paddle; // active if the border or paddle is redrawing itself

reg ResetCollision;
always @(posedge clk) ResetCollision <= (CounterY==500) & (CounterX==0);  // active only once for every video frame

reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;
always @(posedge clk) if(ResetCollision) CollisionX1<=0; else if(BouncingObject & (CounterX==ballX   ) & (CounterY==ballY+ 8)) CollisionX1<=1;	//(0,8)�?
always @(posedge clk) if(ResetCollision) CollisionX2<=0; else if(BouncingObject & (CounterX==ballX+16) & (CounterY==ballY+ 8)) CollisionX2<=1;	//(16,8)�?
always @(posedge clk) if(ResetCollision) CollisionY1<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY   )) CollisionY1<=1;	//(8,0)�?
always @(posedge clk) if(ResetCollision) CollisionY2<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY+16)) CollisionY2<=1;	//(8,16)�? 不与下边碰撞

/////////////////////////////////////////////////////////////////
wire UpdateBallPosition = ResetCollision;  // update the ball position at the same time that we reset the collision detectors

reg ball_dirX, ball_dirY;
always @(posedge clk)
if(UpdateBallPosition)
begin
	if(~(CollisionX1 & CollisionX2))        // if collision on both X-sides, don't move in the X direction
	begin
		ballX <= ballX + (ball_dirX ? -1 : 1);
		if(CollisionX2) ball_dirX <= 1; 
		else if(CollisionX1) ball_dirX <= 0;
	end

	if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
	begin
		ballY <= ballY + (ball_dirY ? -1 : 1);
		if(CollisionY2) ball_dirY <= 1; 	//给定�?个初始位�?
		else if(CollisionY1) ball_dirY <= 0;	//ball_dirY <= 1
	end
end 

/////////////////////////////////////////////////////////////////
wire R = BouncingObject | ball | (CounterX[3] ^ CounterY[3]);  //8*8红白相间小方�?
wire G = BouncingObject | ball;
wire B = BouncingObject | ball;

reg vga_R, vga_G, vga_B;
always @(posedge clk)
begin
	vga_R <= R & inDisplayArea;
	vga_G <= G & inDisplayArea;
	vga_B <= B & inDisplayArea;
end

endmodule