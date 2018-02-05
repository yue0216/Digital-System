module judge(duration,co,clk,song_done);
  input [5:0] duration;
  input co,clk;
  output song_done;
  wire   song_done_temp;
  assign song_done_temp=(duration==6'b0)||co;
  one_pulse one_pulse1(.clk(clk), .in(song_done_temp), .out(song_done));
endmodule





