// Design Code
`timescale 1s/1ns

module traffic_signal (input rst, clk, traffic, output reg [1:0]signal);
  
// Declare the Parameters and Internal signals
  parameter RED = 2'b00, YELLOW = 2'b01, GREEN = 2'b10;
  
  reg [1:0] pr_state, nxt_state;
  
// Workflow of FSM
  always @(posedge clk) begin
    
    if (rst) pr_state <= RED;
    else 	 pr_state <= nxt_state;
    
  end
  
  
  //Function of every State
  always @(pr_state) begin
    
    case(pr_state)
      
      RED:			if (traffic) begin
                  		signal = RED;
          				repeat(9) @(posedge clk);
          				nxt_state = YELLOW;
        			end
        			else begin
                        signal = RED;
          				repeat(6) @(posedge clk);
          				nxt_state = YELLOW;
        			end
     		
      YELLOW:		begin
                      	signal = YELLOW;
          				@(posedge clk);
          				nxt_state = GREEN;
        			end
        			
      			
      GREEN:		if (traffic) begin
                      	signal = GREEN;
          				repeat(9) @(posedge clk);
          				nxt_state = RED;
        			end
        			else begin
                      	signal = GREEN;
          				repeat(6) @(posedge clk);
          				nxt_state = RED;
        			end

      default:	nxt_state = RED;
    endcase
    
  end
      
endmodule
      
          
