//

module music_player(
   clk,
   reset,
   play_button,//低电平有效
   next,       //高电平有效
   New_Frame, 
   sample_out,
  	play,
	song );
   
// The BEAT_COUNT is parameterized so you can reduce this in simulation.
// If you reduce this to 100 your simulation will be 10x faster.
   parameter BEAT_COUNT = 1000;
    
//	******************************************************************************
//  	Inputs and Outputs
//	******************************************************************************
   input clk;
   input reset;

	// Our debounced and one-pulsed button inputs.
   input play_button;
   input next;

	// The raw new_frame signal from the ac97_if codec.
   input New_Frame;

	// Our final output sample to the codec. This needs to be synced to new_frame.
   output [15:0] sample_out;

   //播放指示，曲目指示
   output play;
	output[1:0]song;

 
//	******************************************************************************
//  	Master Control Unit（主控制器）
//	******************************************************************************
   wire reset_play;
   wire song_done;
   mcu mcu(
      .clk(clk),
      .reset(reset),
      .play_button(play_button),
      .next(next),
      .play(play),
      .reset_play(reset_play),
      .song(song),
   //测试时mcu模块时，可将下一行注释符去掉，下??第二行加上注释符。?缬邪醇?常??初步认为mcu正常。		
	// .song_done(1'b0)
      .song_done(song_done)  );
	
//	******************************************************************************
//  	Song Reader
//	******************************************************************************
   wire [5:0] note_to_play;
   wire [5:0] duration_for_note;
   wire new_note;
   wire note_done;
	//wire [2:0] song_reader_state;
   song_reader song_reader(
      .clk(clk),
      .reset(reset || reset_play),
      .play(play),
      .song(song),
      .song_done(song_done),
      .note(note_to_play),
      .duration(duration_for_note),
      .new_note(new_note),
      .note_done(note_done) );
  
  
//	******************************************************************************
//  	Note Player
//	******************************************************************************

   wire beat;
   wire generate_next_sample;
   wire [15:0] note_sample;
   wire note_sample_ready;
   note_player note_player(
      .clk(clk),
      .reset(reset || reset_play),
      .play_enable(play),
      .note_to_load(note_to_play),
      .duration_to_load(duration_for_note),
      .load_new_note(new_note),
      .done_with_note(note_done),
      .beat(beat),
      .generate_next_sample(generate_next_sample),
      .sample_out(note_sample),
      .new_sample_ready(note_sample_ready)	     );
      
  
//	******************************************************************************
//  	Beat Generator
//	******************************************************************************

   beat_generator #(.N(1000),.CounterBits(10)) beat_generator(
      .clk(clk),
      .ci(generate_next_sample),
      .co(beat));
    
//	
//	******************************************************************************
//  	Codec Conditioner
//	******************************************************************************
//	
    wire new_sample_generated = generate_next_sample;
    codec_conditioner codec_conditioner(
       .clk(clk),
       .reset(reset),
       .new_sample_in(note_sample),
       .latch_new_sample_in(note_sample_ready),
       .generate_next_sample(generate_next_sample),
       .New_Frame(New_Frame),
       .valid_sample(sample_out) );
 
endmodule


