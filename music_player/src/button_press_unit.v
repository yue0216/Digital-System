//
// This module synchronizes, debounces, and one-pulses a button input.
//
module button_press_unit(
   clk,
   reset,
   in,
   out
   );
   
	// The WIDTH parameter determines how long to wait for the bouncing to stop.
   parameter WIDTH = 17;
   
	// Standard system clock and reset
   input clk;
   input reset;

	// The async, bouncy input
   input in;
	// The synchronous, clean, one-pulsed output
   output out;
	//------2^^17分频器：产生周期约1.31ms的脉冲en----//
	wire en;
	DIV_N  #(WIDTH)  div_inst(
	 .clk(clk), 
	 .reset(reset),
    .out(en));
	
	//---- Synchronize our input(同步器)--------//
   wire button_sync;
   wire ff1_out;
	D_FF ff1(.clk(clk), .d(in), .q(ff1_out));
   D_FF ff2(.clk(clk), .d(ff1_out), .q(button_sync));
	
	
	
	//--- Debounce our synchronized input(消颤)--//
  
    wire button_debounced;
   debouncer #(3) debounce(.clk(clk), .reset(reset), .en(en), .in(button_sync), .out(button_debounced));
   
   // One-pulse our debounced input(脉宽变换)
   one_pulse one_pulse(.clk(clk), .in(button_debounced), .out(out));

endmodule
   