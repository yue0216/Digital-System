module ModeComparator(a,b,m,y);
	parameter N=8;
	input [N-1:0] a;
	input [N-1:0] b;
	input m;
	output[N-1:0] y;
	wire agb;
	comp #(.N(8))comp_inst(.a(a), .b(b), .agb(agb), .aeb(), .alb());
	reg sel;
  always @(agb or m) begin
    if((m==0)&&(agb==0)) sel=1;
    if((m==0)&&(agb==1)) sel=0;
    if((m==1)&&(agb==0)) sel=0;
    if((m==1)&&(agb==1)) sel=1;
  end
  mux_2to1 #(.N(8)) mux(.out(y),.in0(a),.in1(b),.sel(sel));
endmodule
	