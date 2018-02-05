module mcu(
  clk,
  reset,
  play_button,
  next,
  play,
  reset_play,
  song_done,
  song);
  
  
  input clk,reset,play_button,next,song_done;
  output reg play;
  output reg reset_play;
  output reg [1:0] song;
  parameter RESET=3'b000,WAIT=3'b001,END=3'b010,NEXT=3'b011,PLAY=3'b100;
  reg[2:0] state;
  always @(posedge clk)
    if(reset) begin state<=RESET ; play<=0;song<=2'b00;reset_play<=1;end
    else
      case(state)
        RESET: begin state<=WAIT;reset_play<=0; end
        WAIT: if(song_done) begin state<=END;play<=0;reset_play<=1;end
              else if(next) begin state<=NEXT;play<=1;reset_play<=1;song<=song+1;end
                   else if(!play_button) begin state<=PLAY;play<=1;reset_play<=0;end
                        else begin state<=WAIT;reset_play<=0;end
        END : begin state<=WAIT ;reset_play<=0;end
        PLAY: begin state<=WAIT ;reset_play<=0;end
        default: begin state<=WAIT;  reset_play<=0;end
      endcase
endmodule
        