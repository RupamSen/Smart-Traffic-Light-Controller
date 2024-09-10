// Design Module: Smart Traffic Light Controller

`timescale 1s/1ms

module traffic_signal ( input logic rstn, 
			                  input logic clk, 
			                  input logic traffic,
			                  output logic [1:0] signal
			                );
  
	
  	typedef enum {RED = 0, YELLOW = 1, GREEN = 2} state_type;

	  state_type pr_state, nxt_state;
  
	  logic [7:0] count;
	


  	always @(negedge rstn or negedge clk) begin   
            if (~rstn)	begin pr_state <= RED; end
            else 	begin pr_state <= nxt_state; end   
  	end
  

    //Traffic Signal Control  
  	always @(negedge rstn or posedge clk) begin   
		        if (~rstn)	      begin count <= 'd0; end
		        else 
		         begin
    			      case(pr_state)      
      				            RED:	begin
						                    signal <= RED; 
				
						                    if (traffic) begin
							                                if (count < 'd5)	begin nxt_state <= RED;     count <= count + 1; end
							                                else			        begin nxt_state <= YELLOW;  count <= 0;        end
						                    end else begin
							                                if (count < 'd2)	begin nxt_state <= RED;     count <= count + 1; end
							                                else			        begin nxt_state <= YELLOW;  count <= 0;         end
						                          end
                  			        end
     		
      			           YELLOW: 	begin
                  				        signal <= YELLOW;
          				  	            nxt_state <= GREEN;
        				                end
        			      			
      			            GREEN:	begin
						                    signal <= GREEN; 
				
						                    if (traffic) begin
							                                if (count < 'd5)	begin nxt_state <= GREEN; count <= count + 1; end
							                                else			        begin nxt_state <= RED;   count <= 0;         end
						                    end else begin
							                                if (count < 'd2)	begin nxt_state <= GREEN; count <= count + 1; end
							                                else			        begin nxt_state <= RED;   count <= 0;         end
						                        end
                  			        end

      			        default:	begin  nxt_state = RED;  end
    			  endcase    
		    end
  	end
      
endmodule
