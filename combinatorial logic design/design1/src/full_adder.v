module full_adder(a,b,s,ci,co);
  input a,b,ci;
  output s,co;
  wire S1,T1,T2,T3;
  assign S1=a^b;
  assign s=S1^ci;
  assign T1=a&b;
  assign T2=a&ci;
  assign T3=b&ci;
  assign co=T1|T2|T3;
endmodule