//
// Generated by Bluespec Compiler, version 2017.04.beta1 (build 35065, 2017-04-17)
//
// On Mon Jun 18 16:53:12 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// RDY_putFlit0_put               O     1 reg
// getFlit0_get                   O    32 reg
// RDY_getFlit0_get               O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// putFlit0_put                   I    32 reg
// EN_putFlit0_put                I     1
// EN_getFlit0_get                I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMFpgaTop(CLK,
		  RST_N,

		  putFlit0_put,
		  EN_putFlit0_put,
		  RDY_putFlit0_put,

		  EN_getFlit0_get,
		  getFlit0_get,
		  RDY_getFlit0_get);
  input  CLK;
  input  RST_N;

  // action method putFlit0_put
  input  [31 : 0] putFlit0_put;
  input  EN_putFlit0_put;
  output RDY_putFlit0_put;

  // actionvalue method getFlit0_get
  input  EN_getFlit0_get;
  output [31 : 0] getFlit0_get;
  output RDY_getFlit0_get;

  // signals for module outputs
  wire [31 : 0] getFlit0_get;
  wire RDY_getFlit0_get, RDY_putFlit0_put;

  // ports of submodule xfpga1
  wire [31 : 0] xfpga1$deq_serial4_get,
		xfpga1$enq_serial4_put,
		xfpga1$getFlit0_get,
		xfpga1$putFlit0_put;
  wire xfpga1$EN_deq_serial4_get,
       xfpga1$EN_enq_serial4_put,
       xfpga1$EN_getFlit0_get,
       xfpga1$EN_putFlit0_put,
       xfpga1$RDY_deq_serial4_get,
       xfpga1$RDY_enq_serial4_put,
       xfpga1$RDY_getFlit0_get,
       xfpga1$RDY_putFlit0_put;

  // ports of submodule xfpga2
  wire [31 : 0] xfpga2$deq_serial5_get, xfpga2$enq_serial5_put;
  wire xfpga2$EN_deq_serial5_get,
       xfpga2$EN_enq_serial5_put,
       xfpga2$RDY_deq_serial5_get,
       xfpga2$RDY_enq_serial5_put;

  // action method putFlit0_put
  assign RDY_putFlit0_put = xfpga1$RDY_putFlit0_put ;

  // actionvalue method getFlit0_get
  assign getFlit0_get = xfpga1$getFlit0_get ;
  assign RDY_getFlit0_get = xfpga1$RDY_getFlit0_get ;

  // submodule xfpga1
  mkTop_fpga1 xfpga1(.CLK_clkinX4(CLK),
		     .CLK(CLK),
		     .RST_N(RST_N),
		     .enq_serial4_put(xfpga1$enq_serial4_put),
		     .putFlit0_put(xfpga1$putFlit0_put),
		     .EN_putFlit0_put(xfpga1$EN_putFlit0_put),
		     .EN_getFlit0_get(xfpga1$EN_getFlit0_get),
		     .EN_deq_serial4_get(xfpga1$EN_deq_serial4_get),
		     .EN_enq_serial4_put(xfpga1$EN_enq_serial4_put),
		     .RDY_putFlit0_put(xfpga1$RDY_putFlit0_put),
		     .getFlit0_get(xfpga1$getFlit0_get),
		     .RDY_getFlit0_get(xfpga1$RDY_getFlit0_get),
		     .deq_serial4_get(xfpga1$deq_serial4_get),
		     .RDY_deq_serial4_get(xfpga1$RDY_deq_serial4_get),
		     .RDY_enq_serial4_put(xfpga1$RDY_enq_serial4_put));

  // submodule xfpga2
  mkTop_fpga2 xfpga2(.CLK_clkinX5(CLK),
		     .CLK(CLK),
		     .RST_N(RST_N),
		     .enq_serial5_put(xfpga2$enq_serial5_put),
		     .EN_deq_serial5_get(xfpga2$EN_deq_serial5_get),
		     .EN_enq_serial5_put(xfpga2$EN_enq_serial5_put),
		     .deq_serial5_get(xfpga2$deq_serial5_get),
		     .RDY_deq_serial5_get(xfpga2$RDY_deq_serial5_get),
		     .RDY_enq_serial5_put(xfpga2$RDY_enq_serial5_put));

  // submodule xfpga1
  assign xfpga1$enq_serial4_put = xfpga2$deq_serial5_get ;
  assign xfpga1$putFlit0_put = putFlit0_put ;
  assign xfpga1$EN_putFlit0_put = EN_putFlit0_put ;
  assign xfpga1$EN_getFlit0_get = EN_getFlit0_get ;
  assign xfpga1$EN_deq_serial4_get =
	     xfpga2$RDY_enq_serial5_put && xfpga1$RDY_deq_serial4_get ;
  assign xfpga1$EN_enq_serial4_put =
	     xfpga2$RDY_deq_serial5_get && xfpga1$RDY_enq_serial4_put ;

  // submodule xfpga2
  assign xfpga2$enq_serial5_put = xfpga1$deq_serial4_get ;
  assign xfpga2$EN_deq_serial5_get =
	     xfpga2$RDY_deq_serial5_get && xfpga1$RDY_enq_serial4_put ;
  assign xfpga2$EN_enq_serial5_put =
	     xfpga2$RDY_enq_serial5_put && xfpga1$RDY_deq_serial4_get ;
endmodule  // mkMFpgaTop

