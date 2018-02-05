`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module note_player_tb_v;
  parameter delay=10;
	// Inputs
	reg clk;
	reg reset;
	reg play_enable;
	reg [5:0] note_to_load;
	reg [5:0] duration_to_load;
	reg load_new_note;
	reg beat;
	reg generate_next_sample;

// Outputs
	wire done_with_note;
	wire [15:0] sample_out;
	wire new_sample_ready;

// Instantiate the Unit Under Test (UUT)
	note_player uut (
		.clk(clk), 
		.reset(reset), 
		.play_enable(play_enable), 
		.note_to_load(note_to_load), 
		.duration_to_load(duration_to_load), 
		.done_with_note(done_with_note), 
		.load_new_note(load_new_note), 
		.beat(beat), 
		.generate_next_sample(generate_next_sample), 
		.sample_out(sample_out), 
		.new_sample_ready(new_sample_ready)
	);

	initial 
	  begin
		// Initialize Inputs
		clk = 0;
		reset =1;
		play_enable = 0;
		note_to_load = 0;
		duration_to_load = 0;
		load_new_note = 0;
		beat = 0;
		generate_next_sample = 0;
		//
 		#(delay*1.5+1) reset=0; 
		#(delay*5) play_enable = 1; 
		#(delay*2) note_to_load = 38;
		           duration_to_load = 17;
		           load_new_note = 1;
		#(delay)	  load_new_note = 0;	
	  
	   #(delay*250) $stop;
	  end	
	  
//clock
	  always #(delay/2) clk=~clk;
	
//generate_next_sample
	  reg[1:0] temp_1=0;

	  always @(posedge clk)
		  begin
			temp_1=temp_1+1;
         generate_next_sample=&temp_1;
		  end
//beat 
	 reg[3:0] temp_2=0; 
	 always @(posedge clk)
	  if(generate_next_sample)
		begin
		  temp_2=temp_2+1;
		  beat=&temp_2;
		end  
	 else beat=0;				  

endmodule

