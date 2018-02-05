
module codec_conditioner(
   clk, reset,
   new_sample_in,
	latch_new_sample_in, 
   valid_sample,
   New_Frame,
	generate_next_sample );
   
   input clk;
   input reset;
   // The new sample for the next new_frame
   input [15:0] new_sample_in;
   // Latches the value in new_sample_in
   input latch_new_sample_in;
   // Indicates that it is time to generate a new sample
   output generate_next_sample;
   // Input from the codec saying we need to output the next sample
   input New_Frame;
   // The valid sample out. This will not change while new_frame is high.
   output [15:0] valid_sample;
   
   
   // Generate a one-pulse signal when new_frame goes high.
   wire previous_new_frame;
   D_FFRE #(1) New_Frame_state(
      .clk(clk),
      .r(reset),
      .en(1'b1),
      .d(New_Frame),
      .q(previous_new_frame));
   assign generate_next_sample = New_Frame && ~previous_new_frame;
   
   
   // The next sample we are storing so we can output
   // it immediately on the next new_frame.
   wire [15:0] next_sample_latched;
   D_FFRE #(16) next_sample_latch(
      .clk(clk),
      .r(reset),
      .en(latch_new_sample_in),
      .d(new_sample_in),
      .q(next_sample_latched) );
     
   // The sample we are currently outputting.
   // We latch in the new next_sample when we get a new_frame.
   wire [15:0] latched_current_sample;
   D_FFRE #(16) current_sample_latch(
      .clk(clk),
      .r(reset),
      .en(generate_next_sample),
      .d(next_sample_latched),
      .q(latched_current_sample)   );

   // To make sure we always output the next sample immediately when 
   // new_frame goes high we define our output to be either what we've
   // stored or the next one.
   assign valid_sample = (generate_next_sample) ? next_sample_latched 
	                                             : latched_current_sample;

endmodule
   
