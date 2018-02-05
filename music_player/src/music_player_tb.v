`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module music_player_tb_v;
   parameter delay=10; 
	// Inputs
	reg clk;
	reg reset;
	reg play_button;
	reg next;
	reg New_Frame;

	// Outputs
	wire [15:0] sample_out;
	wire play ;
	wire [1:0] song ;

	// Instantiate the Unit Under Test (UUT)
	music_player uut (
		.clk(clk), 
		.reset(reset), 
		.play_button(play_button), 
		.next(next), 
		.New_Frame(New_Frame), 
		.sample_out(sample_out), 
		.play (play), 
		.song (song));

	initial 
	  begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		play_button = 1;
		next = 0;
		New_Frame = 0;

		// 
		#(delay+1)  reset=0;
		#(delay)  play_button = 0;
		#(delay*1.5)  play_button = 1;
		repeat (200_000)
		 begin
			#(delay*5)  New_Frame = 1;
			#(delay) 	New_Frame = 0;
		 end
	  #(delay*10) $stop;
         
    end
	
	//clock
  always 		#(delay/2) clk=~clk;
endmodule

