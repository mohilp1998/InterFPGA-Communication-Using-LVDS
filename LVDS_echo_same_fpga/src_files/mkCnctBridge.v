//
// Generated by Bluespec Compiler, version 2017.04.beta1 (build 35065, 2017-04-17)
//
// On Mon Jun 18 16:53:01 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// nocPort_getFlit                O    32 reg
// RDY_nocPort_getFlit            O     1
// RDY_nocPort_setNonFullVC       O     1 const
// RDY_nocPort_setRecvFlit        O     1 const
// nocPort_getRecvVCMask          O     2
// RDY_nocPort_getRecvVCMask      O     1 const
// RDY_nocPort_setRecvPortID      O     1 const
// RDY_nocPort_putFlitSoft_put    O     1 reg
// nocPort_getFlitSoft_get        O    32 reg
// RDY_nocPort_getFlitSoft_get    O     1 reg
// RDY_corePort_0_put             O     1 reg
// corePort_0_get                 O    32 reg
// RDY_corePort_0_get             O     1 reg
// RDY_corePort_1_put             O     1 reg
// corePort_1_get                 O    32 reg
// RDY_corePort_1_get             O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// nocPort_setNonFullVC_vcmask    I     2
// nocPort_setRecvFlit_flit       I    32
// nocPort_setRecvPortID_portid   I     4 reg
// nocPort_putFlitSoft_put        I    32
// corePort_0_put_flit            I    32
// corePort_1_put_flit            I    32
// EN_nocPort_setNonFullVC        I     1
// EN_nocPort_setRecvFlit         I     1
// EN_nocPort_setRecvPortID       I     1
// EN_nocPort_putFlitSoft_put     I     1
// EN_corePort_0_put              I     1
// EN_corePort_1_put              I     1
// EN_nocPort_getFlit             I     1
// EN_nocPort_getFlitSoft_get     I     1
// EN_corePort_0_get              I     1
// EN_corePort_1_get              I     1
//
// Combinational paths from inputs to outputs:
//   (nocPort_setNonFullVC_vcmask,
//    EN_nocPort_setNonFullVC) -> RDY_nocPort_getFlit
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

module mkCnctBridge(CLK,
		    RST_N,

		    EN_nocPort_getFlit,
		    nocPort_getFlit,
		    RDY_nocPort_getFlit,

		    nocPort_setNonFullVC_vcmask,
		    EN_nocPort_setNonFullVC,
		    RDY_nocPort_setNonFullVC,

		    nocPort_setRecvFlit_flit,
		    EN_nocPort_setRecvFlit,
		    RDY_nocPort_setRecvFlit,

		    nocPort_getRecvVCMask,
		    RDY_nocPort_getRecvVCMask,

		    nocPort_setRecvPortID_portid,
		    EN_nocPort_setRecvPortID,
		    RDY_nocPort_setRecvPortID,

		    nocPort_putFlitSoft_put,
		    EN_nocPort_putFlitSoft_put,
		    RDY_nocPort_putFlitSoft_put,

		    EN_nocPort_getFlitSoft_get,
		    nocPort_getFlitSoft_get,
		    RDY_nocPort_getFlitSoft_get,

		    corePort_0_put_flit,
		    EN_corePort_0_put,
		    RDY_corePort_0_put,

		    EN_corePort_0_get,
		    corePort_0_get,
		    RDY_corePort_0_get,

		    corePort_1_put_flit,
		    EN_corePort_1_put,
		    RDY_corePort_1_put,

		    EN_corePort_1_get,
		    corePort_1_get,
		    RDY_corePort_1_get);
  parameter [3 : 0] port_id = 4'b0;
  input  CLK;
  input  RST_N;

  // actionvalue method nocPort_getFlit
  input  EN_nocPort_getFlit;
  output [31 : 0] nocPort_getFlit;
  output RDY_nocPort_getFlit;

  // action method nocPort_setNonFullVC
  input  [1 : 0] nocPort_setNonFullVC_vcmask;
  input  EN_nocPort_setNonFullVC;
  output RDY_nocPort_setNonFullVC;

  // action method nocPort_setRecvFlit
  input  [31 : 0] nocPort_setRecvFlit_flit;
  input  EN_nocPort_setRecvFlit;
  output RDY_nocPort_setRecvFlit;

  // value method nocPort_getRecvVCMask
  output [1 : 0] nocPort_getRecvVCMask;
  output RDY_nocPort_getRecvVCMask;

  // action method nocPort_setRecvPortID
  input  [3 : 0] nocPort_setRecvPortID_portid;
  input  EN_nocPort_setRecvPortID;
  output RDY_nocPort_setRecvPortID;

  // action method nocPort_putFlitSoft_put
  input  [31 : 0] nocPort_putFlitSoft_put;
  input  EN_nocPort_putFlitSoft_put;
  output RDY_nocPort_putFlitSoft_put;

  // actionvalue method nocPort_getFlitSoft_get
  input  EN_nocPort_getFlitSoft_get;
  output [31 : 0] nocPort_getFlitSoft_get;
  output RDY_nocPort_getFlitSoft_get;

  // action method corePort_0_put
  input  [31 : 0] corePort_0_put_flit;
  input  EN_corePort_0_put;
  output RDY_corePort_0_put;

  // actionvalue method corePort_0_get
  input  EN_corePort_0_get;
  output [31 : 0] corePort_0_get;
  output RDY_corePort_0_get;

  // action method corePort_1_put
  input  [31 : 0] corePort_1_put_flit;
  input  EN_corePort_1_put;
  output RDY_corePort_1_put;

  // actionvalue method corePort_1_get
  input  EN_corePort_1_get;
  output [31 : 0] corePort_1_get;
  output RDY_corePort_1_get;

  // signals for module outputs
  wire [31 : 0] corePort_0_get,
		corePort_1_get,
		nocPort_getFlit,
		nocPort_getFlitSoft_get;
  wire [1 : 0] nocPort_getRecvVCMask;
  wire RDY_corePort_0_get,
       RDY_corePort_0_put,
       RDY_corePort_1_get,
       RDY_corePort_1_put,
       RDY_nocPort_getFlit,
       RDY_nocPort_getFlitSoft_get,
       RDY_nocPort_getRecvVCMask,
       RDY_nocPort_putFlitSoft_put,
       RDY_nocPort_setNonFullVC,
       RDY_nocPort_setRecvFlit,
       RDY_nocPort_setRecvPortID;

  // register port_id_unused
  reg [3 : 0] port_id_unused;
  wire [3 : 0] port_id_unused$D_IN;
  wire port_id_unused$EN;

  // ports of submodule flitsFromNw_0
  wire [31 : 0] flitsFromNw_0$D_IN, flitsFromNw_0$D_OUT;
  wire flitsFromNw_0$CLR,
       flitsFromNw_0$DEQ,
       flitsFromNw_0$EMPTY_N,
       flitsFromNw_0$ENQ,
       flitsFromNw_0$FULL_N;

  // ports of submodule flitsFromNw_1
  wire [31 : 0] flitsFromNw_1$D_IN, flitsFromNw_1$D_OUT;
  wire flitsFromNw_1$CLR,
       flitsFromNw_1$DEQ,
       flitsFromNw_1$EMPTY_N,
       flitsFromNw_1$ENQ,
       flitsFromNw_1$FULL_N;

  // ports of submodule flitsToNw_0
  wire [31 : 0] flitsToNw_0$D_IN, flitsToNw_0$D_OUT;
  wire flitsToNw_0$CLR,
       flitsToNw_0$DEQ,
       flitsToNw_0$EMPTY_N,
       flitsToNw_0$ENQ,
       flitsToNw_0$FULL_N;

  // ports of submodule flitsToNw_1
  wire [31 : 0] flitsToNw_1$D_IN, flitsToNw_1$D_OUT;
  wire flitsToNw_1$CLR,
       flitsToNw_1$DEQ,
       flitsToNw_1$EMPTY_N,
       flitsToNw_1$ENQ,
       flitsToNw_1$FULL_N;

  // ports of submodule sendFlit
  wire [31 : 0] sendFlit$D_IN, sendFlit$D_OUT;
  wire sendFlit$CLR,
       sendFlit$DEQ,
       sendFlit$EMPTY_N,
       sendFlit$ENQ,
       sendFlit$FULL_N;

  // rule scheduling signals
  wire CAN_FIRE_RL_r_send_flit_1, WILL_FIRE_RL_r_send_flit;

  // inputs to muxes for submodule ports
  wire MUX_flitsToNw_0$enq_1__SEL_1, MUX_sendFlit$enq_1__SEL_2;

  // remaining internal signals
  wire [1 : 0] IF_flitsFromNw_0FULL_N_THEN_1_ELSE_0__q1;

  // actionvalue method nocPort_getFlit
  assign nocPort_getFlit = sendFlit$D_OUT ;
  assign RDY_nocPort_getFlit =
	     sendFlit$EMPTY_N &&
	     nocPort_setNonFullVC_vcmask[sendFlit$D_OUT[25]] &&
	     EN_nocPort_setNonFullVC ;

  // action method nocPort_setNonFullVC
  assign RDY_nocPort_setNonFullVC = 1'd1 ;

  // action method nocPort_setRecvFlit
  assign RDY_nocPort_setRecvFlit = 1'd1 ;

  // value method nocPort_getRecvVCMask
  assign nocPort_getRecvVCMask =
	     { flitsFromNw_1$FULL_N,
	       IF_flitsFromNw_0FULL_N_THEN_1_ELSE_0__q1[0] } ;
  assign RDY_nocPort_getRecvVCMask = 1'b1 ;

  // action method nocPort_setRecvPortID
  assign RDY_nocPort_setRecvPortID = 1'd1 ;

  // action method nocPort_putFlitSoft_put
  assign RDY_nocPort_putFlitSoft_put = flitsToNw_0$FULL_N ;

  // actionvalue method nocPort_getFlitSoft_get
  assign nocPort_getFlitSoft_get = flitsFromNw_0$D_OUT ;
  assign RDY_nocPort_getFlitSoft_get = flitsFromNw_0$EMPTY_N ;

  // action method corePort_0_put
  assign RDY_corePort_0_put = flitsToNw_0$FULL_N ;

  // actionvalue method corePort_0_get
  assign corePort_0_get = flitsFromNw_0$D_OUT ;
  assign RDY_corePort_0_get = flitsFromNw_0$EMPTY_N ;

  // action method corePort_1_put
  assign RDY_corePort_1_put = flitsToNw_1$FULL_N ;

  // actionvalue method corePort_1_get
  assign corePort_1_get = flitsFromNw_1$D_OUT ;
  assign RDY_corePort_1_get = flitsFromNw_1$EMPTY_N ;

  // submodule flitsFromNw_0
  FIFO2 #(.width(32'd32), .guarded(32'd1)) flitsFromNw_0(.RST(RST_N),
							 .CLK(CLK),
							 .D_IN(flitsFromNw_0$D_IN),
							 .ENQ(flitsFromNw_0$ENQ),
							 .DEQ(flitsFromNw_0$DEQ),
							 .CLR(flitsFromNw_0$CLR),
							 .D_OUT(flitsFromNw_0$D_OUT),
							 .FULL_N(flitsFromNw_0$FULL_N),
							 .EMPTY_N(flitsFromNw_0$EMPTY_N));

  // submodule flitsFromNw_1
  FIFO2 #(.width(32'd32), .guarded(32'd1)) flitsFromNw_1(.RST(RST_N),
							 .CLK(CLK),
							 .D_IN(flitsFromNw_1$D_IN),
							 .ENQ(flitsFromNw_1$ENQ),
							 .DEQ(flitsFromNw_1$DEQ),
							 .CLR(flitsFromNw_1$CLR),
							 .D_OUT(flitsFromNw_1$D_OUT),
							 .FULL_N(flitsFromNw_1$FULL_N),
							 .EMPTY_N(flitsFromNw_1$EMPTY_N));

  // submodule flitsToNw_0
  FIFO2 #(.width(32'd32), .guarded(32'd1)) flitsToNw_0(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(flitsToNw_0$D_IN),
						       .ENQ(flitsToNw_0$ENQ),
						       .DEQ(flitsToNw_0$DEQ),
						       .CLR(flitsToNw_0$CLR),
						       .D_OUT(flitsToNw_0$D_OUT),
						       .FULL_N(flitsToNw_0$FULL_N),
						       .EMPTY_N(flitsToNw_0$EMPTY_N));

  // submodule flitsToNw_1
  FIFO2 #(.width(32'd32), .guarded(32'd1)) flitsToNw_1(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(flitsToNw_1$D_IN),
						       .ENQ(flitsToNw_1$ENQ),
						       .DEQ(flitsToNw_1$DEQ),
						       .CLR(flitsToNw_1$CLR),
						       .D_OUT(flitsToNw_1$D_OUT),
						       .FULL_N(flitsToNw_1$FULL_N),
						       .EMPTY_N(flitsToNw_1$EMPTY_N));

  // submodule sendFlit
  FIFO2 #(.width(32'd32), .guarded(32'd1)) sendFlit(.RST(RST_N),
						    .CLK(CLK),
						    .D_IN(sendFlit$D_IN),
						    .ENQ(sendFlit$ENQ),
						    .DEQ(sendFlit$DEQ),
						    .CLR(sendFlit$CLR),
						    .D_OUT(sendFlit$D_OUT),
						    .FULL_N(sendFlit$FULL_N),
						    .EMPTY_N(sendFlit$EMPTY_N));

  // rule RL_r_send_flit
  assign WILL_FIRE_RL_r_send_flit =
	     EN_nocPort_setNonFullVC && flitsToNw_0$EMPTY_N &&
	     sendFlit$FULL_N &&
	     nocPort_setNonFullVC_vcmask[0] ;

  // rule RL_r_send_flit_1
  assign CAN_FIRE_RL_r_send_flit_1 =
	     EN_nocPort_setNonFullVC && sendFlit$FULL_N &&
	     flitsToNw_1$EMPTY_N &&
	     nocPort_setNonFullVC_vcmask[1] ;

  // inputs to muxes for submodule ports
  assign MUX_flitsToNw_0$enq_1__SEL_1 =
	     EN_nocPort_putFlitSoft_put && nocPort_putFlitSoft_put[31] ;
  assign MUX_sendFlit$enq_1__SEL_2 =
	     CAN_FIRE_RL_r_send_flit_1 && !WILL_FIRE_RL_r_send_flit ;

  // register port_id_unused
  assign port_id_unused$D_IN = nocPort_setRecvPortID_portid ;
  assign port_id_unused$EN = EN_nocPort_setRecvPortID ;

  // submodule flitsFromNw_0
  assign flitsFromNw_0$D_IN = nocPort_setRecvFlit_flit ;
  assign flitsFromNw_0$ENQ =
	     EN_nocPort_setRecvFlit && flitsFromNw_0$FULL_N &&
	     nocPort_setRecvFlit_flit[31] &&
	     !nocPort_setRecvFlit_flit[25] ;
  assign flitsFromNw_0$DEQ = EN_nocPort_getFlitSoft_get || EN_corePort_0_get ;
  assign flitsFromNw_0$CLR = 1'b0 ;

  // submodule flitsFromNw_1
  assign flitsFromNw_1$D_IN = nocPort_setRecvFlit_flit ;
  assign flitsFromNw_1$ENQ =
	     EN_nocPort_setRecvFlit && flitsFromNw_1$FULL_N &&
	     nocPort_setRecvFlit_flit[31] &&
	     nocPort_setRecvFlit_flit[25] ;
  assign flitsFromNw_1$DEQ = EN_corePort_1_get ;
  assign flitsFromNw_1$CLR = 1'b0 ;

  // submodule flitsToNw_0
  assign flitsToNw_0$D_IN =
	     MUX_flitsToNw_0$enq_1__SEL_1 ?
	       nocPort_putFlitSoft_put :
	       corePort_0_put_flit ;
  assign flitsToNw_0$ENQ =
	     EN_nocPort_putFlitSoft_put && nocPort_putFlitSoft_put[31] ||
	     EN_corePort_0_put && corePort_0_put_flit[31] ;
  assign flitsToNw_0$DEQ = WILL_FIRE_RL_r_send_flit ;
  assign flitsToNw_0$CLR = 1'b0 ;

  // submodule flitsToNw_1
  assign flitsToNw_1$D_IN = corePort_1_put_flit ;
  assign flitsToNw_1$ENQ = EN_corePort_1_put && corePort_1_put_flit[31] ;
  assign flitsToNw_1$DEQ = MUX_sendFlit$enq_1__SEL_2 ;
  assign flitsToNw_1$CLR = 1'b0 ;

  // submodule sendFlit
  assign sendFlit$D_IN =
	     WILL_FIRE_RL_r_send_flit ?
	       flitsToNw_0$D_OUT :
	       flitsToNw_1$D_OUT ;
  assign sendFlit$ENQ =
	     WILL_FIRE_RL_r_send_flit ||
	     CAN_FIRE_RL_r_send_flit_1 && !WILL_FIRE_RL_r_send_flit ;
  assign sendFlit$DEQ = EN_nocPort_getFlit ;
  assign sendFlit$CLR = 1'b0 ;

  // remaining internal signals
  assign IF_flitsFromNw_0FULL_N_THEN_1_ELSE_0__q1 =
	     flitsFromNw_0$FULL_N ? 2'd1 : 2'd0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (port_id_unused$EN)
      port_id_unused <= `BSV_ASSIGNMENT_DELAY port_id_unused$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    port_id_unused = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkCnctBridge
