//******************************************************************************

// debouncer.v 

//******************************************************************************

module debouncer(
       clk, 
		 in, 
		 out, 
		 reset, 
		 en);

	input clk;
	input reset;
	input en;//T=1.31ms����
	input in;
	output out;
	reg out;

//timer
	parameter WIDTH = 3;
	reg  timer_clr;
	wire [WIDTH-1:0] timer_q;
	    D_FFRE #(WIDTH) counter(.clk(clk), .d(timer_q+1'b1), .q(timer_q), .r(timer_clr || reset), .en(en));
   wire timer_done;
	assign  timer_done=&timer_q;//��ʱʱ��Լ1.31*8ms
	

// *** DEBOUNCING FSM ***
	// Define our states-- I've selected one-hot encoding
	`define HIGH 2'b00
	`define WAIT_LOW 2'b01
	`define LOW 2'b10
	`define WAIT_HIGH 2'b11

	
	reg [1:0] next_state_d;
	wire [1:0] current_state_q;

// Next state logic
	always @(*)
		begin
		  	case (current_state_q)
			
         `HIGH : begin
				out = 1'b0;
				timer_clr = 1'b1;
				if (~in) begin
					next_state_d = `WAIT_LOW;
					end
				else begin
					next_state_d = `HIGH;
					end
				end
 
          `WAIT_LOW : begin
				out = 1'b1;
				timer_clr = 1'b0;
				if (timer_done) begin
					next_state_d = `LOW;
					end
				else begin
					next_state_d = `WAIT_LOW;
					end
				end
 
		   	`LOW: begin
				out = 1'b1;
				timer_clr = 1'b1;
				if (in) begin
					next_state_d = `WAIT_HIGH;
					end
				else begin
					next_state_d = `LOW;
					end
				end

			`WAIT_HIGH : begin
				out = 1'b1;
				timer_clr = 1'b0;
				if (timer_done) begin
					next_state_d = `HIGH;
					end
				else begin
					next_state_d = `WAIT_HIGH;
					end
				end

			default : begin
				out = 1'b0;
				timer_clr = 1'b1;
				next_state_d = `HIGH;
				end
			endcase
		end

	// State register
	D_FFRE #(2) state(.clk(clk), .d(next_state_d), .q(current_state_q), .r(reset), .en(1'b1));

endmodule
