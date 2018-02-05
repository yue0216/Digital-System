`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: qmj
// Engineer:zju

////////////////////////////////////////////////////////////////////////////////

module mcu_tb_v;
   parameter delay=10; 
	// Inputs
	reg clk;
	reg reset;
	reg play_button;
	reg next;
	reg song_done;

	// Outputs
	wire play;
	wire [1:0] song;
	wire reset_play;

	// Instantiate the Unit Under Test (UUT)
	mcu uut (
		.clk(clk), 
		.reset(reset), 
		.play_button(play_button), 
		.next(next), 
		.play(play), 
		.song(song), 
		.reset_play(reset_play), 
		.song_done(song_done)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		play_button = 1;
		next = 0;
		song_done = 0;

		// 
		#(delay*1.5+1) reset=0;
		#(delay*5) play_button = 0;
		#(delay*2) play_button = 1;
    #(delay)   play_button = 0;
		#(delay*3) play_button = 1; 
    #(delay*10) song_done  = 1; 
    #(delay)    song_done  = 0;
    #(delay*5) next = 1;		
    #(delay)   next = 0;
    #(delay*10) song_done  = 1; 
    #(delay)    song_done  = 0;		
		#(delay*4)  $stop;	
	
	end
	//clock
  always 		#(delay/2) clk=~clk;
endmodule

