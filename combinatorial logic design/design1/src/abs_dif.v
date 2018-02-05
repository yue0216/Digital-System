module abs_dif(aIn,bIn,out);
  input[3:0] aIn,bIn;
  output[3:0] out;
  wire agb;
  comp #(.N(4))comp_inst(.a(aIn),.b(bIn),.agb(agb),.aeb(),.alb());
  wire[3:0] Max,Min;
  mux_2to1 #(.N(4)) mux1(.out(Max),.in0(aIn),.in1(bIn),.sel(~agb));
  mux_2to1 #(.N(4)) mux2(.out(Min),.in0(aIn),.in1(bIn),.sel(agb));
  wire[2:0] c;
  full_adder adder0(.a(Max[0]),.b(~Min[0]),.s(out[0]),.ci(1'b1),.co(c[0]));
  full_adder adder1(.a(Max[1]),.b(~Min[1]),.s(out[1]),.ci(c[0]),.co(c[1]));
  full_adder adder2(.a(Max[2]),.b(~Min[2]),.s(out[2]),.ci(c[1]),.co(c[2]));
  full_adder adder3(.a(Max[3]),.b(~Min[3]),.s(out[3]),.ci(c[2]),.co());
endmodule  
  