module addresscounter(q,co,clk,reset,note_done);
  parameter N=5;
  output [N:1]q;
  output co;
  input clk,reset,note_done;
  reg [N:1]q;
  always@(posedge clk)
    begin
      if(reset) q<=0;
      else
        q<=q+note_done;
      end
  assign co=&q&&note_done;
endmodule