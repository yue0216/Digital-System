module address(raw_addr,rom_addr);
 input wire [21:0] raw_addr; 
 output reg [9:0] rom_addr; 
 always@(*) 
 begin  
  case(raw_addr[21:20])  2'b00:rom_addr<=raw_addr[19:10]; 2'b01:  if(raw_addr[20:10]==1024) rom_addr<=1023;
   else rom_addr<=(~raw_addr[19:10]+1); 2'b10:rom_addr<=raw_addr[19:10]; 2'b11:  if(raw_addr[20:10]==1024) rom_addr<=1023;
   else rom_addr<=(~raw_addr[19:10]+1); default:rom_addr<=10'b0; 
  endcase 
 end  
endmodule