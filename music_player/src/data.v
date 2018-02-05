module data(raw_addr,raw_data,sample); 
  input wire raw_addr; 
  input wire [15:0] raw_data; 
  output reg [15:0] sample; 
 always @ (*) begin 
  case (raw_addr) 
    1:sample<=raw_data[15:0];  
    0:sample<=(~raw_data[15:0]+1); 
    default:sample<=16'b0; 
  endcase 
 end  
endmodule