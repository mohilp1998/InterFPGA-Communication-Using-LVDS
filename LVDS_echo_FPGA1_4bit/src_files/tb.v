`timescale 1ns / 1ps

module tb;
  // Inputs
  reg CLK;
  reg RST_N;

  // Instantiate the Unit Under Test (UUT)
  mkTb tb (
    .CLK(CLK), 
    .RST_N(RST_N)
  );
  always #4 CLK = ~CLK;
  initial begin
    // Initialize Inputs
    CLK = 0;
    RST_N = 0;
    #4 RST_N = 0;
    #16 RST_N = 1;

    // Wait 100 ns for global reset to finish
    //#100;
    #50000000 $finish(); 
    // Add stimulus here

  end
  initial begin	
    //$dumpfile("dump.vcd");
    //$dumpvars(0);
  end 
endmodule
// vim: ft=verilog
