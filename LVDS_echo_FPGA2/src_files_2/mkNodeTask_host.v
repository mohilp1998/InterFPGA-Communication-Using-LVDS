//
// Generated by Bluespec Compiler, version 2017.04.beta1 (build 35065, 2017-04-17)
//
// On Tue Jun 19 14:36:23 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// getFlit                        O    32 reg
// RDY_getFlit                    O     1
// RDY_setNonFullVC               O     1 const
// RDY_setRecvFlit                O     1 const
// getRecvVCMask                  O     2
// RDY_getRecvVCMask              O     1 const
// RDY_setRecvPortID              O     1 const
// RDY_putFlitSoft_put            O     1 reg
// getFlitSoft_get                O    32 reg
// RDY_getFlitSoft_get            O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// setNonFullVC_vcmask            I     2
// setRecvFlit_flit               I    32
// setRecvPortID_portid           I     4 reg
// putFlitSoft_put                I    32
// EN_setNonFullVC                I     1
// EN_setRecvFlit                 I     1
// EN_setRecvPortID               I     1
// EN_putFlitSoft_put             I     1
// EN_getFlit                     I     1
// EN_getFlitSoft_get             I     1
//
// Combinational paths from inputs to outputs:
//   (setNonFullVC_vcmask, EN_setNonFullVC) -> RDY_getFlit
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

module mkNodeTask_host(CLK,
		       RST_N,

		       EN_getFlit,
		       getFlit,
		       RDY_getFlit,

		       setNonFullVC_vcmask,
		       EN_setNonFullVC,
		       RDY_setNonFullVC,

		       setRecvFlit_flit,
		       EN_setRecvFlit,
		       RDY_setRecvFlit,

		       getRecvVCMask,
		       RDY_getRecvVCMask,

		       setRecvPortID_portid,
		       EN_setRecvPortID,
		       RDY_setRecvPortID,

		       putFlitSoft_put,
		       EN_putFlitSoft_put,
		       RDY_putFlitSoft_put,

		       EN_getFlitSoft_get,
		       getFlitSoft_get,
		       RDY_getFlitSoft_get);
  parameter [3 : 0] portid = 4'b0;
  input  CLK;
  input  RST_N;

  // actionvalue method getFlit
  input  EN_getFlit;
  output [31 : 0] getFlit;
  output RDY_getFlit;

  // action method setNonFullVC
  input  [1 : 0] setNonFullVC_vcmask;
  input  EN_setNonFullVC;
  output RDY_setNonFullVC;

  // action method setRecvFlit
  input  [31 : 0] setRecvFlit_flit;
  input  EN_setRecvFlit;
  output RDY_setRecvFlit;

  // value method getRecvVCMask
  output [1 : 0] getRecvVCMask;
  output RDY_getRecvVCMask;

  // action method setRecvPortID
  input  [3 : 0] setRecvPortID_portid;
  input  EN_setRecvPortID;
  output RDY_setRecvPortID;

  // action method putFlitSoft_put
  input  [31 : 0] putFlitSoft_put;
  input  EN_putFlitSoft_put;
  output RDY_putFlitSoft_put;

  // actionvalue method getFlitSoft_get
  input  EN_getFlitSoft_get;
  output [31 : 0] getFlitSoft_get;
  output RDY_getFlitSoft_get;

  // signals for module outputs
  wire [31 : 0] getFlit, getFlitSoft_get;
  wire [1 : 0] getRecvVCMask;
  wire RDY_getFlit,
       RDY_getFlitSoft_get,
       RDY_getRecvVCMask,
       RDY_putFlitSoft_put,
       RDY_setNonFullVC,
       RDY_setRecvFlit,
       RDY_setRecvPortID;

  // ports of submodule bridge
  wire [31 : 0] bridge$corePort_0_put_flit,
		bridge$corePort_1_put_flit,
		bridge$nocPort_getFlit,
		bridge$nocPort_getFlitSoft_get,
		bridge$nocPort_putFlitSoft_put,
		bridge$nocPort_setRecvFlit_flit;
  wire [3 : 0] bridge$nocPort_setRecvPortID_portid;
  wire [1 : 0] bridge$nocPort_getRecvVCMask,
	       bridge$nocPort_setNonFullVC_vcmask;
  wire bridge$EN_corePort_0_get,
       bridge$EN_corePort_0_put,
       bridge$EN_corePort_1_get,
       bridge$EN_corePort_1_put,
       bridge$EN_nocPort_getFlit,
       bridge$EN_nocPort_getFlitSoft_get,
       bridge$EN_nocPort_putFlitSoft_put,
       bridge$EN_nocPort_setNonFullVC,
       bridge$EN_nocPort_setRecvFlit,
       bridge$EN_nocPort_setRecvPortID,
       bridge$RDY_nocPort_getFlit,
       bridge$RDY_nocPort_getFlitSoft_get,
       bridge$RDY_nocPort_getRecvVCMask,
       bridge$RDY_nocPort_putFlitSoft_put;

  // actionvalue method getFlit
  assign getFlit = bridge$nocPort_getFlit ;
  assign RDY_getFlit = bridge$RDY_nocPort_getFlit ;

  // action method setNonFullVC
  assign RDY_setNonFullVC = 1'd1 ;

  // action method setRecvFlit
  assign RDY_setRecvFlit = 1'd1 ;

  // value method getRecvVCMask
  assign getRecvVCMask = bridge$nocPort_getRecvVCMask ;
  assign RDY_getRecvVCMask = bridge$RDY_nocPort_getRecvVCMask ;

  // action method setRecvPortID
  assign RDY_setRecvPortID = 1'd1 ;

  // action method putFlitSoft_put
  assign RDY_putFlitSoft_put = bridge$RDY_nocPort_putFlitSoft_put ;

  // actionvalue method getFlitSoft_get
  assign getFlitSoft_get = bridge$nocPort_getFlitSoft_get ;
  assign RDY_getFlitSoft_get = bridge$RDY_nocPort_getFlitSoft_get ;

  // submodule bridge
  mkCnctBridge #(.port_id(portid)) bridge(.CLK(CLK),
					  .RST_N(RST_N),
					  .corePort_0_put_flit(bridge$corePort_0_put_flit),
					  .corePort_1_put_flit(bridge$corePort_1_put_flit),
					  .nocPort_putFlitSoft_put(bridge$nocPort_putFlitSoft_put),
					  .nocPort_setNonFullVC_vcmask(bridge$nocPort_setNonFullVC_vcmask),
					  .nocPort_setRecvFlit_flit(bridge$nocPort_setRecvFlit_flit),
					  .nocPort_setRecvPortID_portid(bridge$nocPort_setRecvPortID_portid),
					  .EN_nocPort_getFlit(bridge$EN_nocPort_getFlit),
					  .EN_nocPort_setNonFullVC(bridge$EN_nocPort_setNonFullVC),
					  .EN_nocPort_setRecvFlit(bridge$EN_nocPort_setRecvFlit),
					  .EN_nocPort_setRecvPortID(bridge$EN_nocPort_setRecvPortID),
					  .EN_nocPort_putFlitSoft_put(bridge$EN_nocPort_putFlitSoft_put),
					  .EN_nocPort_getFlitSoft_get(bridge$EN_nocPort_getFlitSoft_get),
					  .EN_corePort_0_put(bridge$EN_corePort_0_put),
					  .EN_corePort_0_get(bridge$EN_corePort_0_get),
					  .EN_corePort_1_put(bridge$EN_corePort_1_put),
					  .EN_corePort_1_get(bridge$EN_corePort_1_get),
					  .nocPort_getFlit(bridge$nocPort_getFlit),
					  .RDY_nocPort_getFlit(bridge$RDY_nocPort_getFlit),
					  .RDY_nocPort_setNonFullVC(),
					  .RDY_nocPort_setRecvFlit(),
					  .nocPort_getRecvVCMask(bridge$nocPort_getRecvVCMask),
					  .RDY_nocPort_getRecvVCMask(bridge$RDY_nocPort_getRecvVCMask),
					  .RDY_nocPort_setRecvPortID(),
					  .RDY_nocPort_putFlitSoft_put(bridge$RDY_nocPort_putFlitSoft_put),
					  .nocPort_getFlitSoft_get(bridge$nocPort_getFlitSoft_get),
					  .RDY_nocPort_getFlitSoft_get(bridge$RDY_nocPort_getFlitSoft_get),
					  .RDY_corePort_0_put(),
					  .corePort_0_get(),
					  .RDY_corePort_0_get(),
					  .RDY_corePort_1_put(),
					  .corePort_1_get(),
					  .RDY_corePort_1_get());

  // submodule bridge
  assign bridge$corePort_0_put_flit = 32'h0 ;
  assign bridge$corePort_1_put_flit = 32'h0 ;
  assign bridge$nocPort_putFlitSoft_put = putFlitSoft_put ;
  assign bridge$nocPort_setNonFullVC_vcmask = setNonFullVC_vcmask ;
  assign bridge$nocPort_setRecvFlit_flit = setRecvFlit_flit ;
  assign bridge$nocPort_setRecvPortID_portid = setRecvPortID_portid ;
  assign bridge$EN_nocPort_getFlit = EN_getFlit ;
  assign bridge$EN_nocPort_setNonFullVC = EN_setNonFullVC ;
  assign bridge$EN_nocPort_setRecvFlit = EN_setRecvFlit ;
  assign bridge$EN_nocPort_setRecvPortID = EN_setRecvPortID ;
  assign bridge$EN_nocPort_putFlitSoft_put = EN_putFlitSoft_put ;
  assign bridge$EN_nocPort_getFlitSoft_get = EN_getFlitSoft_get ;
  assign bridge$EN_corePort_0_put = 1'b0 ;
  assign bridge$EN_corePort_0_get = 1'b0 ;
  assign bridge$EN_corePort_1_put = 1'b0 ;
  assign bridge$EN_corePort_1_get = 1'b0 ;
endmodule  // mkNodeTask_host

