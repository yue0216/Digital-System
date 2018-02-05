module song_reader(
		   note, duration, new_note, song_done,		   
		   clk, reset, note_done, play, song
		   );
   input clk,reset,note_done;
   input play;
   input [1:0] song;
   output [5:0] note;
   output [5:0] duration;
   output 	new_note, song_done;
   

   wire [6:0] 	addr;

   
   wire 	co;			
   wire [11:0] 	dout;			
   wire [4:0] 	q;			
   

   assign {note, duration} = dout;
   addresscounter addresscounter(
		  .q			(q[4:0]),
		  .co			(co),
		  
		  .clk			(clk),
		  .reset			(reset),
		  .note_done		(note_done));
   assign addr={song,q};
   song_rom  song_rom(
		 .dout			(dout[11:0]),
		 
		 .clk			(clk),
		 .addr			(addr[6:0]));	
   judge  judge(
		   .song_done		(song_done),
		   
		   .duration		(duration[5:0]),
		   .clk			(clk),
		   .co			(co));
   song_readerctrl  cotroller(
				     .new_note		(new_note),
				     
				     .clk		(clk),
				     .reset		(reset),
				     .note_done		(note_done),
				     .play		(play));
endmodule
							
	