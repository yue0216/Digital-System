//

module music_player(
   clk,
   reset,
   play_button,//�͵�ƽ��Ч
   next,       //�ߵ�ƽ��Ч
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

   //����ָʾ����Ŀָʾ
   output play;
	output[1:0]song;

 
//	******************************************************************************
//  	Master Control Unit������������
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
   //����ʱmcuģ��ʱ���ɽ���һ��ע�ͷ�ȥ������??�ڶ��м���ע�ͷ���?��а����?��??������Ϊmcu������		
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


