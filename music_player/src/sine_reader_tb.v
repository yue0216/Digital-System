`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module sine_reader_tb_v;
   parameter delay=10;
	// Inputs
	reg clk;
	reg reset;
	reg [19:0] step_size;
	reg generate_next;

	// Outputs
	wire sample_ready;
	wire [15:0] sample;

	// Instantiate the Unit Under Test (UUT)
	sine_reader uut (
		.clk(clk), 
		.reset(reset), 
		.step_size(step_size), 
		.generate_next_sample(generate_next), 
		.new_sample_ready(sample_ready), 
		.sample_out(sample)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		step_size ={10'd58, 10'd360};
		generate_next= 0;
		//  
		#(delay*1.5+1) reset=0; 
		repeat (100)
		begin 
        #(delay*5)  generate_next= 1;
		  #(delay)  generate_next= 0;
		end 
		// 
		 #(delay) step_size ={10'd98, 10'd68} ;
		
		repeat (108)
      begin 
        #(delay*5)  generate_next= 1;
        #(delay)  generate_next= 0;
      end   
		   
		  #(delay) step_size ={10'd30, 10'd68} ;
          
     repeat (250)
         begin 
           #(delay*5)  generate_next= 1;
           #(delay)  generate_next= 0;
        end       
		   
		   #(delay*5) $stop;
		
	end
	
	//clock
always 		#(delay/2) clk=~clk;
      
endmodule

