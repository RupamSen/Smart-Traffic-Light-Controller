// Testbench

`timescale 1s/1ms

module tb;
  
  //Declare Ports
  reg clk, rstn, traffic;
  wire [1:0] signal;
  
  //Instantiate Design Module
  traffic_signal dut(rstn,clk,traffic,signal);
  
  //Generate a Clock of timeperiod 10 second
  always #5 clk = ~ clk;
  
  //Create a task to Reset the Design Module
  task reset();
    rstn <= 1'b0;
    repeat(3) @(posedge clk);
    rstn <= 1'b1;
    $display("Reset Done !");
  endtask
  
  //Generate stimuli
  initial begin
    clk = 1'b0; rstn <= 0; traffic <= 0;
    @(posedge clk);
    reset();
    traffic = 1;
    repeat(30) @(posedge clk);
    $finish(); 
  end

endmodule
