module song_readerctrl(new_note,clk, reset, note_done, play);
   input clk,reset,note_done,play;
   output reg new_note;
   parameter RESET=2'b00,NEW_NOTE=2'b01,WAIT=2'b10,NEXT_NOTE=2'b11;
   reg [1:0]  state;
   always @(posedge clk)
     begin
       if(reset) begin state<=RESET;new_note<=0;end
       else case(state)
         RESET:begin
         if(play) begin state<=NEW_NOTE;new_note<=1;end
         else begin state<=RESET;new_note<=0;end
         end
         NEW_NOTE:begin state<=WAIT;new_note<=0;end
         WAIT:begin 
         if(play) begin
           if(note_done) begin state<=NEXT_NOTE;new_note<=0;end
           else begin state<=WAIT;new_note<=0;end
         end    
         else begin state<=RESET;new_note<=0;end
         end
         NEXT_NOTE:begin state<=NEW_NOTE;new_note<=1;end
         default:begin state<=RESET;new_note<=0;end
       endcase
     end
endmodule  