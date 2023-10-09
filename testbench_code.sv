// Testbench

module tb;
  
  //Declare Ports
  reg clk, rst, traffic;
  wire [1:0] signal;
  
  //Instantiate Design Module
  traffic_signal dut(rst,clk,traffic,signal);
  
  //Generate a Clock of timeperiod 10 second
  always #5 clk = ~ clk;
  
  //Create a task to Reset the Design Module
  task reset();
    rst <= 1'b1;
    repeat(3) @(posedge clk);
    rst <= 1'b0;
    $display("Reset Done !");
  endtask
  
  //Generate stimuli
  initial begin
    clk = 1'b0;
    @(posedge clk);
    reset();
    forever begin
      traffic = $urandom();
      @(posedge clk);
    end
  end
  
  //Generate Waveform
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    #2000 $finish();
  end
