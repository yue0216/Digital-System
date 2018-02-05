module comp(a,b,agb,aeb,alb);
  parameter N=1;
  input wire[N-1:0] a,b;
  output reg agb;
  output reg aeb;
  output reg alb;
  always @(a or b) begin
    agb=0;aeb=0;alb=0;
    if(a>b) agb=1;
    else if(a==b) aeb=1;
    else alb=1;
    end
endmodule