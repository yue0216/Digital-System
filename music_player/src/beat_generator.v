module beat_generator(clk,ci,co);
  parameter N=10;
  parameter CounterBits=4;
  input ci,clk;
  output co;
  reg [CounterBits:1] qout=0;
  assign co=(qout==(N-1))&ci;
  always @(posedge clk)
    begin if (ci) 
       begin if (qout==(N-1)) qout=0;
             else qout=qout+1;
       end
    end
endmodule
