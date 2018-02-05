module mux_2to1(out,in0,in1,sel);
  parameter N=1;
  output[N-1:0] out;
  input[N-1:0] in0,in1;
  input sel;
  assign out=sel?in1:in0;
endmodule