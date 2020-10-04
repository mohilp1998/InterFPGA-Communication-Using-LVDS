/*
 * These source files contain a hardware description of a network
 * automatically generated by CONNECT (CONfigurable NEtwork Creation Tool).
 *
 * This product includes a hardware design developed by Carnegie Mellon
 * University.
 *
 * Copyright (c) 2012 by Michael K. Papamichael, Carnegie Mellon University
 *
 * For more information, see the CONNECT project website at:
 *   http://www.ece.cmu.edu/~mpapamic/connect
 *
 * This design is provided for internal, non-commercial research use only, 
 * cannot be used for, or in support of, goods or services, and is not for
 * redistribution, with or without modifications.
 * 
 * You may not use the name "Carnegie Mellon University" or derivations
 * thereof to endorse or promote products derived from this software.
 *
 * THE SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY WARRANTY OF ANY KIND, EITHER
 * EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO ANY WARRANTY
 * THAT THE SOFTWARE WILL CONFORM TO SPECIFICATIONS OR BE ERROR-FREE AND ANY
 * IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
 * TITLE, OR NON-INFRINGEMENT.  IN NO EVENT SHALL CARNEGIE MELLON UNIVERSITY
 * BE LIABLE FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO DIRECT, INDIRECT,
 * SPECIAL OR CONSEQUENTIAL DAMAGES, ARISING OUT OF, RESULTING FROM, OR IN
 * ANY WAY CONNECTED WITH THIS SOFTWARE (WHETHER OR NOT BASED UPON WARRANTY,
 * CONTRACT, TORT OR OTHERWISE).
 *
 */


//
// Generated by Bluespec Compiler, version 2012.01.A (build 26572, 2012-01-17)
//
// On Fri Oct 13 09:11:46 EDT 2017
//
// Method conflict info:
// Method: select
// Conflict-free: select
// Sequenced before: next
//
// Method: next
// Sequenced after: select
// Conflicts: next
//
//
// Ports:
// Name                         I/O  size props
// select                         O     8
// CLK                            I     1 clock
// RST_N                          I     1 reset
// select_requests                I     8
// EN_next                        I     1
//
// Combinational paths from inputs to outputs:
//   select_requests -> select
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkOutputArbiter(CLK,
		       RST_N,

		       select_requests,
		       select,

		       EN_next);
  input  CLK;
  input  RST_N;

  // value method select
  input  [7 : 0] select_requests;
  output [7 : 0] select;

  // action method next
  input  EN_next;

  // signals for module outputs
  wire [7 : 0] select;

  // register arb_token
  reg [7 : 0] arb_token;
  wire [7 : 0] arb_token$D_IN;
  wire arb_token$EN;

  // remaining internal signals
  wire [1 : 0] ab__h2470,
	       ab__h2485,
	       ab__h2500,
	       ab__h2515,
	       ab__h2530,
	       ab__h2545,
	       ab__h2560,
	       ab__h2575,
	       ab__h4703,
	       ab__h5381,
	       ab__h6005,
	       ab__h6580,
	       ab__h7106,
	       ab__h7583,
	       ab__h8011,
	       ab__h8390;
  wire NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d121,
       NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d95,
       NOT_gen_grant_carry_2_BIT_1_1_00_AND_NOT_gen_g_ETC___d119,
       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d111,
       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d67,
       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d87,
       NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d109,
       NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d85,
       NOT_gen_grant_carry_6_BIT_1_1_8_AND_NOT_gen_gr_ETC___d107,
       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d123,
       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d75,
       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d97,
       ab_BIT_0___h3355,
       ab_BIT_0___h3462,
       ab_BIT_0___h3569,
       ab_BIT_0___h3676,
       ab_BIT_0___h3783,
       ab_BIT_0___h3890,
       ab_BIT_0___h3997,
       ab_BIT_0___h4819,
       ab_BIT_0___h5057,
       ab_BIT_0___h5681,
       ab_BIT_0___h6256,
       ab_BIT_0___h6782,
       ab_BIT_0___h7259,
       ab_BIT_0___h7687,
       ab_BIT_0___h8066,
       arb_token_BIT_0___h3353,
       arb_token_BIT_1___h3460,
       arb_token_BIT_2___h3567,
       arb_token_BIT_3___h3674,
       arb_token_BIT_4___h3781,
       arb_token_BIT_5___h3888,
       arb_token_BIT_6___h3995,
       arb_token_BIT_7___h4102;

  // value method select
  assign select =
	     { ab__h2470[1] || ab__h4703[1],
	       !ab__h2470[1] && !ab__h4703[1] &&
	       (ab__h2485[1] || ab__h5381[1]),
	       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d67,
	       !ab__h2470[1] && !ab__h4703[1] &&
	       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d75,
	       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d87,
	       !ab__h2470[1] && !ab__h4703[1] &&
	       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d97,
	       NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d111,
	       !ab__h2470[1] && !ab__h4703[1] &&
	       NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d123 } ;

  // register arb_token
  assign arb_token$D_IN = { arb_token[0], arb_token[7:1] } ;
  assign arb_token$EN = EN_next ;

  // remaining internal signals
  module_gen_grant_carry instance_gen_grant_carry_15(.gen_grant_carry_c(1'd0),
						     .gen_grant_carry_r(select_requests[0]),
						     .gen_grant_carry_p(arb_token_BIT_0___h3353),
						     .gen_grant_carry(ab__h2575));
  module_gen_grant_carry instance_gen_grant_carry_1(.gen_grant_carry_c(ab_BIT_0___h3355),
						    .gen_grant_carry_r(select_requests[1]),
						    .gen_grant_carry_p(arb_token_BIT_1___h3460),
						    .gen_grant_carry(ab__h2560));
  module_gen_grant_carry instance_gen_grant_carry_0(.gen_grant_carry_c(ab_BIT_0___h3462),
						    .gen_grant_carry_r(select_requests[2]),
						    .gen_grant_carry_p(arb_token_BIT_2___h3567),
						    .gen_grant_carry(ab__h2545));
  module_gen_grant_carry instance_gen_grant_carry_2(.gen_grant_carry_c(ab_BIT_0___h3569),
						    .gen_grant_carry_r(select_requests[3]),
						    .gen_grant_carry_p(arb_token_BIT_3___h3674),
						    .gen_grant_carry(ab__h2530));
  module_gen_grant_carry instance_gen_grant_carry_3(.gen_grant_carry_c(ab_BIT_0___h3676),
						    .gen_grant_carry_r(select_requests[4]),
						    .gen_grant_carry_p(arb_token_BIT_4___h3781),
						    .gen_grant_carry(ab__h2515));
  module_gen_grant_carry instance_gen_grant_carry_4(.gen_grant_carry_c(ab_BIT_0___h3783),
						    .gen_grant_carry_r(select_requests[5]),
						    .gen_grant_carry_p(arb_token_BIT_5___h3888),
						    .gen_grant_carry(ab__h2500));
  module_gen_grant_carry instance_gen_grant_carry_5(.gen_grant_carry_c(ab_BIT_0___h3890),
						    .gen_grant_carry_r(select_requests[6]),
						    .gen_grant_carry_p(arb_token_BIT_6___h3995),
						    .gen_grant_carry(ab__h2485));
  module_gen_grant_carry instance_gen_grant_carry_6(.gen_grant_carry_c(ab_BIT_0___h3997),
						    .gen_grant_carry_r(select_requests[7]),
						    .gen_grant_carry_p(arb_token_BIT_7___h4102),
						    .gen_grant_carry(ab__h2470));
  module_gen_grant_carry instance_gen_grant_carry_7(.gen_grant_carry_c(ab_BIT_0___h4819),
						    .gen_grant_carry_r(select_requests[0]),
						    .gen_grant_carry_p(arb_token_BIT_0___h3353),
						    .gen_grant_carry(ab__h8390));
  module_gen_grant_carry instance_gen_grant_carry_8(.gen_grant_carry_c(ab_BIT_0___h8066),
						    .gen_grant_carry_r(select_requests[1]),
						    .gen_grant_carry_p(arb_token_BIT_1___h3460),
						    .gen_grant_carry(ab__h8011));
  module_gen_grant_carry instance_gen_grant_carry_9(.gen_grant_carry_c(ab_BIT_0___h7687),
						    .gen_grant_carry_r(select_requests[2]),
						    .gen_grant_carry_p(arb_token_BIT_2___h3567),
						    .gen_grant_carry(ab__h7583));
  module_gen_grant_carry instance_gen_grant_carry_10(.gen_grant_carry_c(ab_BIT_0___h7259),
						     .gen_grant_carry_r(select_requests[3]),
						     .gen_grant_carry_p(arb_token_BIT_3___h3674),
						     .gen_grant_carry(ab__h7106));
  module_gen_grant_carry instance_gen_grant_carry_11(.gen_grant_carry_c(ab_BIT_0___h6782),
						     .gen_grant_carry_r(select_requests[4]),
						     .gen_grant_carry_p(arb_token_BIT_4___h3781),
						     .gen_grant_carry(ab__h6580));
  module_gen_grant_carry instance_gen_grant_carry_12(.gen_grant_carry_c(ab_BIT_0___h6256),
						     .gen_grant_carry_r(select_requests[5]),
						     .gen_grant_carry_p(arb_token_BIT_5___h3888),
						     .gen_grant_carry(ab__h6005));
  module_gen_grant_carry instance_gen_grant_carry_13(.gen_grant_carry_c(ab_BIT_0___h5681),
						     .gen_grant_carry_r(select_requests[6]),
						     .gen_grant_carry_p(arb_token_BIT_6___h3995),
						     .gen_grant_carry(ab__h5381));
  module_gen_grant_carry instance_gen_grant_carry_14(.gen_grant_carry_c(ab_BIT_0___h5057),
						     .gen_grant_carry_r(select_requests[7]),
						     .gen_grant_carry_p(arb_token_BIT_7___h4102),
						     .gen_grant_carry(ab__h4703));
  assign NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d121 =
	     !ab__h2515[1] && !ab__h6580[1] && !ab__h2530[1] &&
	     !ab__h7106[1] &&
	     NOT_gen_grant_carry_2_BIT_1_1_00_AND_NOT_gen_g_ETC___d119 ;
  assign NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d95 =
	     !ab__h2515[1] && !ab__h6580[1] && !ab__h2530[1] &&
	     !ab__h7106[1] &&
	     (ab__h2545[1] || ab__h7583[1]) ;
  assign NOT_gen_grant_carry_2_BIT_1_1_00_AND_NOT_gen_g_ETC___d119 =
	     !ab__h2545[1] && !ab__h7583[1] && !ab__h2560[1] &&
	     !ab__h8011[1] &&
	     (ab__h2575[1] || ab__h8390[1]) ;
  assign NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d111 =
	     !ab__h2470[1] && !ab__h4703[1] && !ab__h2485[1] &&
	     !ab__h5381[1] &&
	     NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d109 ;
  assign NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d67 =
	     !ab__h2470[1] && !ab__h4703[1] && !ab__h2485[1] &&
	     !ab__h5381[1] &&
	     (ab__h2500[1] || ab__h6005[1]) ;
  assign NOT_gen_grant_carry_2_BIT_1_3_2_AND_NOT_gen_gr_ETC___d87 =
	     !ab__h2470[1] && !ab__h4703[1] && !ab__h2485[1] &&
	     !ab__h5381[1] &&
	     NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d85 ;
  assign NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d109 =
	     !ab__h2500[1] && !ab__h6005[1] && !ab__h2515[1] &&
	     !ab__h6580[1] &&
	     NOT_gen_grant_carry_6_BIT_1_1_8_AND_NOT_gen_gr_ETC___d107 ;
  assign NOT_gen_grant_carry_4_BIT_1_3_8_AND_NOT_gen_gr_ETC___d85 =
	     !ab__h2500[1] && !ab__h6005[1] && !ab__h2515[1] &&
	     !ab__h6580[1] &&
	     (ab__h2530[1] || ab__h7106[1]) ;
  assign NOT_gen_grant_carry_6_BIT_1_1_8_AND_NOT_gen_gr_ETC___d107 =
	     !ab__h2530[1] && !ab__h7106[1] && !ab__h2545[1] &&
	     !ab__h7583[1] &&
	     (ab__h2560[1] || ab__h8011[1]) ;
  assign NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d123 =
	     !ab__h2485[1] && !ab__h5381[1] && !ab__h2500[1] &&
	     !ab__h6005[1] &&
	     NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d121 ;
  assign NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d75 =
	     !ab__h2485[1] && !ab__h5381[1] && !ab__h2500[1] &&
	     !ab__h6005[1] &&
	     (ab__h2515[1] || ab__h6580[1]) ;
  assign NOT_gen_grant_carry_8_BIT_1_5_0_AND_NOT_gen_gr_ETC___d97 =
	     !ab__h2485[1] && !ab__h5381[1] && !ab__h2500[1] &&
	     !ab__h6005[1] &&
	     NOT_gen_grant_carry_0_BIT_1_1_8_AND_NOT_gen_gr_ETC___d95 ;
  assign ab_BIT_0___h3355 = ab__h2575[0] ;
  assign ab_BIT_0___h3462 = ab__h2560[0] ;
  assign ab_BIT_0___h3569 = ab__h2545[0] ;
  assign ab_BIT_0___h3676 = ab__h2530[0] ;
  assign ab_BIT_0___h3783 = ab__h2515[0] ;
  assign ab_BIT_0___h3890 = ab__h2500[0] ;
  assign ab_BIT_0___h3997 = ab__h2485[0] ;
  assign ab_BIT_0___h4819 = ab__h2470[0] ;
  assign ab_BIT_0___h5057 = ab__h5381[0] ;
  assign ab_BIT_0___h5681 = ab__h6005[0] ;
  assign ab_BIT_0___h6256 = ab__h6580[0] ;
  assign ab_BIT_0___h6782 = ab__h7106[0] ;
  assign ab_BIT_0___h7259 = ab__h7583[0] ;
  assign ab_BIT_0___h7687 = ab__h8011[0] ;
  assign ab_BIT_0___h8066 = ab__h8390[0] ;
  assign arb_token_BIT_0___h3353 = arb_token[0] ;
  assign arb_token_BIT_1___h3460 = arb_token[1] ;
  assign arb_token_BIT_2___h3567 = arb_token[2] ;
  assign arb_token_BIT_3___h3674 = arb_token[3] ;
  assign arb_token_BIT_4___h3781 = arb_token[4] ;
  assign arb_token_BIT_5___h3888 = arb_token[5] ;
  assign arb_token_BIT_6___h3995 = arb_token[6] ;
  assign arb_token_BIT_7___h4102 = arb_token[7] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        arb_token <= `BSV_ASSIGNMENT_DELAY 8'd1;
      end
    else
      begin
        if (arb_token$EN) arb_token <= `BSV_ASSIGNMENT_DELAY arb_token$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    arb_token = 8'hAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkOutputArbiter

