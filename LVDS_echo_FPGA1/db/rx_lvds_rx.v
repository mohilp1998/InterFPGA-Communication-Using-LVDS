//altlvds_rx BUFFER_IMPLEMENTATION="RAM" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" COMMON_RX_TX_PLL="OFF" CYCLONEII_M4K_COMPATIBILITY="ON" DATA_ALIGN_ROLLOVER=4 DATA_RATE="200.0 Mbps" DESERIALIZATION_FACTOR=4 DEVICE_FAMILY="Cyclone IV E" DPA_INITIAL_PHASE_VALUE=0 DPLL_LOCK_COUNT=0 DPLL_LOCK_WINDOW=0 ENABLE_DPA_ALIGN_TO_RISING_EDGE_ONLY="OFF" ENABLE_DPA_CALIBRATION="ON" ENABLE_DPA_INITIAL_PHASE_SELECTION="OFF" ENABLE_DPA_MODE="OFF" ENABLE_DPA_PLL_CALIBRATION="OFF" ENABLE_SOFT_CDR_MODE="OFF" IMPLEMENT_IN_LES="ON" INCLOCK_BOOST=0 INCLOCK_DATA_ALIGNMENT="EDGE_ALIGNED" INCLOCK_PERIOD=20000 INCLOCK_PHASE_SHIFT=0 INPUT_DATA_RATE=200 NUMBER_OF_CHANNELS=2 OUTCLOCK_RESOURCE="AUTO" PLL_SELF_RESET_ON_LOSS_LOCK="ON" PORT_RX_CHANNEL_DATA_ALIGN="PORT_UNUSED" PORT_RX_DATA_ALIGN="PORT_USED" REGISTERED_OUTPUT="ON" SIM_DPA_IS_NEGATIVE_PPM_DRIFT="OFF" SIM_DPA_NET_PPM_VARIATION=0 SIM_DPA_OUTPUT_CLOCK_PHASE_SHIFT=0 USE_CORECLOCK_INPUT="OFF" USE_DPLL_RAWPERROR="OFF" USE_EXTERNAL_PLL="OFF" USE_NO_PHASE_SHIFT="ON" X_ON_BITSLIP="ON" pll_areset rx_data_align rx_in rx_inclock rx_locked rx_out rx_outclock CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48 LOW_POWER_MODE="AUTO" ALTERA_INTERNAL_OPTIONS=AUTO_SHIFT_REGISTER_RECOGNITION=OFF
//VERSION_BEGIN 16.0 cbx_altaccumulate 2016:04:20:18:35:29:SJ cbx_altclkbuf 2016:04:20:18:35:29:SJ cbx_altddio_in 2016:04:20:18:35:29:SJ cbx_altddio_out 2016:04:20:18:35:29:SJ cbx_altera_syncram_nd_impl 2016:04:20:18:35:29:SJ cbx_altiobuf_bidir 2016:04:20:18:35:29:SJ cbx_altiobuf_in 2016:04:20:18:35:29:SJ cbx_altiobuf_out 2016:04:20:18:35:29:SJ cbx_altlvds_rx 2016:04:20:18:35:29:SJ cbx_altpll 2016:04:20:18:35:29:SJ cbx_altsyncram 2016:04:20:18:35:29:SJ cbx_arriav 2016:04:20:18:35:27:SJ cbx_cyclone 2016:04:20:18:35:29:SJ cbx_cycloneii 2016:04:20:18:35:29:SJ cbx_lpm_add_sub 2016:04:20:18:35:29:SJ cbx_lpm_compare 2016:04:20:18:35:29:SJ cbx_lpm_counter 2016:04:20:18:35:29:SJ cbx_lpm_decode 2016:04:20:18:35:29:SJ cbx_lpm_mux 2016:04:20:18:35:29:SJ cbx_lpm_shiftreg 2016:04:20:18:35:29:SJ cbx_maxii 2016:04:20:18:35:29:SJ cbx_mgl 2016:04:20:19:36:45:SJ cbx_nadder 2016:04:20:18:35:29:SJ cbx_stratix 2016:04:20:18:35:29:SJ cbx_stratixii 2016:04:20:18:35:29:SJ cbx_stratixiii 2016:04:20:18:35:29:SJ cbx_stratixv 2016:04:20:18:35:29:SJ cbx_util_mgl 2016:04:20:18:35:29:SJ  VERSION_END
//CBXI_INSTANCE_NAME="LVDS_echo_FPGA1_qsys_FPGA1_TopNiosInterface_lvds_echo_fpga1_component_0_LVDS_fpga_fpga1_rx_rx1_altlvds_rx_ALTLVDS_RX_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, the Altera Quartus Prime License Agreement,
//  the Altera MegaCore Function License Agreement, or other 
//  applicable license agreement, including, without limitation, 
//  that your use is for the sole purpose of programming logic 
//  devices manufactured by Altera and sold by Altera or its 
//  authorized distributors.  Please refer to the applicable 
//  agreement for further details.




//alt_lvds_ddio_in ADD_LATENCY_REG="TRUE" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" WIDTH=2 aclr clock datain dataout_h dataout_l
//VERSION_BEGIN 16.0 cbx_altaccumulate 2016:04:20:18:35:29:SJ cbx_altclkbuf 2016:04:20:18:35:29:SJ cbx_altddio_in 2016:04:20:18:35:29:SJ cbx_altddio_out 2016:04:20:18:35:29:SJ cbx_altera_syncram_nd_impl 2016:04:20:18:35:29:SJ cbx_altiobuf_bidir 2016:04:20:18:35:29:SJ cbx_altiobuf_in 2016:04:20:18:35:29:SJ cbx_altiobuf_out 2016:04:20:18:35:29:SJ cbx_altlvds_rx 2016:04:20:18:35:29:SJ cbx_altpll 2016:04:20:18:35:29:SJ cbx_altsyncram 2016:04:20:18:35:29:SJ cbx_arriav 2016:04:20:18:35:27:SJ cbx_cyclone 2016:04:20:18:35:29:SJ cbx_cycloneii 2016:04:20:18:35:29:SJ cbx_lpm_add_sub 2016:04:20:18:35:29:SJ cbx_lpm_compare 2016:04:20:18:35:29:SJ cbx_lpm_counter 2016:04:20:18:35:29:SJ cbx_lpm_decode 2016:04:20:18:35:29:SJ cbx_lpm_mux 2016:04:20:18:35:29:SJ cbx_lpm_shiftreg 2016:04:20:18:35:29:SJ cbx_maxii 2016:04:20:18:35:29:SJ cbx_mgl 2016:04:20:19:36:45:SJ cbx_nadder 2016:04:20:18:35:29:SJ cbx_stratix 2016:04:20:18:35:29:SJ cbx_stratixii 2016:04:20:18:35:29:SJ cbx_stratixiii 2016:04:20:18:35:29:SJ cbx_stratixv 2016:04:20:18:35:29:SJ cbx_util_mgl 2016:04:20:18:35:29:SJ  VERSION_END

//synthesis_resources = reg 10 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"{-to ddio_h_reg*} PLL_COMPENSATE=ON;ADV_NETLIST_OPT_ALLOWED=\"NEVER_ALLOW\""} *)
module  rx_lvds_ddio_in
	( 
	aclr,
	clock,
	datain,
	dataout_h,
	dataout_l) /* synthesis synthesis_clearbox=1 */;
	input   aclr;
	input   clock;
	input   [1:0]  datain;
	output   [1:0]  dataout_h;
	output   [1:0]  dataout_l;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[1:0]	dataout_h_reg;
	reg	[1:0]	dataout_l_latch;
	reg	[1:0]	dataout_l_reg;
	(* ALTERA_ATTRIBUTE = {"LVDS_RX_REGISTER=HIGH;PRESERVE_REGISTER=ON;PRESERVE_FANOUT_FREE_NODE=ON"} *)
	reg	[1:0]	ddio_h_reg;
	(* ALTERA_ATTRIBUTE = {"LVDS_RX_REGISTER=LOW;PRESERVE_REGISTER=ON;PRESERVE_FANOUT_FREE_NODE=ON"} *)
	reg	[1:0]	ddio_l_reg;

	// synopsys translate_off
	initial
		dataout_h_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dataout_h_reg <= 2'b0;
		else  dataout_h_reg <= ddio_h_reg;
	// synopsys translate_off
	initial
		dataout_l_latch = 0;
	// synopsys translate_on
	always @ ( negedge clock or  posedge aclr)
		if (aclr == 1'b1) dataout_l_latch <= 2'b0;
		else  dataout_l_latch <= ddio_l_reg;
	// synopsys translate_off
	initial
		dataout_l_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dataout_l_reg <= 2'b0;
		else  dataout_l_reg <= dataout_l_latch;
	// synopsys translate_off
	initial
		ddio_h_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) ddio_h_reg <= 2'b0;
		else  ddio_h_reg <= datain;
	// synopsys translate_off
	initial
		ddio_l_reg = 0;
	// synopsys translate_on
	always @ ( negedge clock or  posedge aclr)
		if (aclr == 1'b1) ddio_l_reg <= 2'b0;
		else  ddio_l_reg <= datain;
	assign
		dataout_h = dataout_l_reg,
		dataout_l = dataout_h_reg;
endmodule //rx_lvds_ddio_in


//dffpipe CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DELAY=1 WIDTH=2 clock clrn d q ALTERA_INTERNAL_OPTIONS=AUTO_SHIFT_REGISTER_RECOGNITION=OFF
//VERSION_BEGIN 16.0 cbx_mgl 2016:04:20:19:36:45:SJ cbx_stratixii 2016:04:20:18:35:29:SJ cbx_util_mgl 2016:04:20:18:35:29:SJ  VERSION_END

//synthesis_resources = reg 2 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"AUTO_SHIFT_REGISTER_RECOGNITION=OFF"} *)
module  rx_dffpipe
	( 
	clock,
	clrn,
	d,
	q) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   clrn;
	input   [1:0]  d;
	output   [1:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   clock;
	tri1   clrn;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[1:0]	dffe13a;
	wire ena;
	wire prn;
	wire sclr;

	// synopsys translate_off
	initial
		dffe13a = 0;
	// synopsys translate_on
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe13a <= {2{1'b1}};
		else if (clrn == 1'b0) dffe13a <= 2'b0;
		else if  (ena == 1'b1)   dffe13a <= (d & {2{(~ sclr)}});
	assign
		ena = 1'b1,
		prn = 1'b1,
		q = dffe13a,
		sclr = 1'b0;
endmodule //rx_dffpipe


//lpm_counter CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" lpm_modulus=4 lpm_port_updown="PORT_UNUSED" lpm_width=2 clock cnt_en q
//VERSION_BEGIN 16.0 cbx_cycloneii 2016:04:20:18:35:29:SJ cbx_lpm_add_sub 2016:04:20:18:35:29:SJ cbx_lpm_compare 2016:04:20:18:35:29:SJ cbx_lpm_counter 2016:04:20:18:35:29:SJ cbx_lpm_decode 2016:04:20:18:35:29:SJ cbx_mgl 2016:04:20:19:36:45:SJ cbx_nadder 2016:04:20:18:35:29:SJ cbx_stratix 2016:04:20:18:35:29:SJ cbx_stratixii 2016:04:20:18:35:29:SJ  VERSION_END

//synthesis_resources = lut 2 reg 2 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  rx_cntr
	( 
	clock,
	cnt_en,
	q) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   cnt_en;
	output   [1:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   cnt_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]   wire_counter_comb_bita_0combout;
	wire  [0:0]   wire_counter_comb_bita_1combout;
	wire  [0:0]   wire_counter_comb_bita_0cout;
	wire	[1:0]	wire_counter_reg_bit_d;
	wire	[1:0]	wire_counter_reg_bit_asdata;
	reg	[1:0]	counter_reg_bit;
	wire	[1:0]	wire_counter_reg_bit_ena;
	wire	[1:0]	wire_counter_reg_bit_sload;
	wire  aclr_actual;
	wire clk_en;
	wire [1:0]  data;
	wire  external_cin;
	wire  [1:0]  s_val;
	wire  [1:0]  safe_q;
	wire sclr;
	wire sload;
	wire sset;
	wire  updown_dir;

	cycloneive_lcell_comb   counter_comb_bita_0
	( 
	.cin(external_cin),
	.combout(wire_counter_comb_bita_0combout[0:0]),
	.cout(wire_counter_comb_bita_0cout[0:0]),
	.dataa(counter_reg_bit[0]),
	.datab(updown_dir),
	.datad(1'b1),
	.datac(1'b0)
	);
	defparam
		counter_comb_bita_0.lut_mask = 16'h5A90,
		counter_comb_bita_0.sum_lutc_input = "cin",
		counter_comb_bita_0.lpm_type = "cycloneive_lcell_comb";
	cycloneive_lcell_comb   counter_comb_bita_1
	( 
	.cin(wire_counter_comb_bita_0cout[0:0]),
	.combout(wire_counter_comb_bita_1combout[0:0]),
	.cout(),
	.dataa(counter_reg_bit[1]),
	.datab(updown_dir),
	.datad(1'b1),
	.datac(1'b0)
	);
	defparam
		counter_comb_bita_1.lut_mask = 16'h5A90,
		counter_comb_bita_1.sum_lutc_input = "cin",
		counter_comb_bita_1.lpm_type = "cycloneive_lcell_comb";
	// synopsys translate_off
	initial
		counter_reg_bit[0:0] = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr_actual)
		if (aclr_actual == 1'b1) counter_reg_bit[0:0] <= 1'b0;
		else if  (wire_counter_reg_bit_ena[0:0] == 1'b1) 
			if (wire_counter_reg_bit_sload[0:0] == 1'b1) counter_reg_bit[0:0] <= wire_counter_reg_bit_asdata[0:0];
			else  counter_reg_bit[0:0] <= wire_counter_reg_bit_d[0:0];
	// synopsys translate_off
	initial
		counter_reg_bit[1:1] = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr_actual)
		if (aclr_actual == 1'b1) counter_reg_bit[1:1] <= 1'b0;
		else if  (wire_counter_reg_bit_ena[1:1] == 1'b1) 
			if (wire_counter_reg_bit_sload[1:1] == 1'b1) counter_reg_bit[1:1] <= wire_counter_reg_bit_asdata[1:1];
			else  counter_reg_bit[1:1] <= wire_counter_reg_bit_d[1:1];
	assign
		wire_counter_reg_bit_asdata = ({2{(~ sclr)}} & (({2{sset}} & s_val) | ({2{(~ sset)}} & data))),
		wire_counter_reg_bit_d = {wire_counter_comb_bita_1combout[0:0], wire_counter_comb_bita_0combout[0:0]};
	assign
		wire_counter_reg_bit_ena = {2{(clk_en & (((sclr | sset) | sload) | cnt_en))}},
		wire_counter_reg_bit_sload = {2{((sclr | sset) | sload)}};
	assign
		aclr_actual = 1'b0,
		clk_en = 1'b1,
		data = {2{1'b0}},
		external_cin = 1'b1,
		q = safe_q,
		s_val = {2{1'b1}},
		safe_q = counter_reg_bit,
		sclr = 1'b0,
		sload = 1'b0,
		sset = 1'b0,
		updown_dir = 1'b1;
endmodule //rx_cntr


//lpm_mux CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" LPM_SIZE=4 LPM_WIDTH=1 LPM_WIDTHS=2 data result sel
//VERSION_BEGIN 16.0 cbx_lpm_mux 2016:04:20:18:35:29:SJ cbx_mgl 2016:04:20:19:36:45:SJ  VERSION_END

//synthesis_resources = lut 2 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  rx_mux
	( 
	data,
	result,
	sel) /* synthesis synthesis_clearbox=1 */;
	input   [3:0]  data;
	output   [0:0]  result;
	input   [1:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [3:0]  data;
	tri0   [1:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]  result_node;
	wire  [1:0]  sel_node;
	wire  [3:0]  w_data104w;

	assign
		result = result_node,
		result_node = {(((w_data104w[1] & sel_node[0]) & (~ (((w_data104w[0] & (~ sel_node[1])) & (~ sel_node[0])) | (sel_node[1] & (sel_node[0] | w_data104w[2]))))) | ((((w_data104w[0] & (~ sel_node[1])) & (~ sel_node[0])) | (sel_node[1] & (sel_node[0] | w_data104w[2]))) & (w_data104w[3] | (~ sel_node[0]))))},
		sel_node = {sel[1:0]},
		w_data104w = {data[3:0]};
endmodule //rx_mux

//synthesis_resources = cycloneive_pll 1 lut 10 reg 41 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"AUTO_SHIFT_REGISTER_RECOGNITION=OFF;SUPPRESS_DA_RULE_INTERNAL=C104;{-to lvds_rx_pll} AUTO_MERGE_PLLS=OFF"} *)
module  rx_lvds_rx
	( 
	pll_areset,
	rx_data_align,
	rx_in,
	rx_inclock,
	rx_locked,
	rx_out,
	rx_outclock) /* synthesis synthesis_clearbox=1 */;
	input   pll_areset;
	input   rx_data_align;
	input   [1:0]  rx_in;
	input   rx_inclock;
	output   rx_locked;
	output   [7:0]  rx_out;
	output   rx_outclock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   pll_areset;
	tri0   rx_data_align;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [1:0]   wire_ddio_in_dataout_h;
	wire  [1:0]   wire_ddio_in_dataout_l;
	reg	[0:0]	cda_h_shiftreg3a;
	reg	[0:0]	cda_h_shiftreg9a;
	reg	[1:0]	cda_l_shiftreg10a;
	reg	[1:0]	cda_l_shiftreg4a;
	reg	[1:0]	h_shiftreg2a;
	reg	[1:0]	h_shiftreg8a;
	reg	int_bitslip_reg;
	reg	[1:0]	l_shiftreg1a;
	reg	[1:0]	l_shiftreg7a;
	(* ALTERA_ATTRIBUTE = {"SUPPRESS_DA_RULE_INTERNAL=D103"} *)
	reg	pll_lock_sync;
	reg	rx_data_align_reg;
	reg	[7:0]	rx_reg;
	wire  [1:0]   wire_h_dffpipe_q;
	wire  [1:0]   wire_l_dffpipe_q;
	wire  [1:0]   wire_bitslip_cntr_q;
	wire  [0:0]   wire_h_mux11a_result;
	wire  [0:0]   wire_h_mux5a_result;
	wire  [0:0]   wire_l_mux12a_result;
	wire  [0:0]   wire_l_mux6a_result;
	wire  [4:0]   wire_lvds_rx_pll_clk;
	wire  wire_lvds_rx_pll_fbout;
	wire  wire_lvds_rx_pll_locked;
	wire  bitslip;
	wire  [1:0]  bitslip_en;
	wire  [1:0]  ddio_dataout_h;
	wire  [1:0]  ddio_dataout_h_int;
	wire  [1:0]  ddio_dataout_l;
	wire  [1:0]  ddio_dataout_l_int;
	wire  fast_clock;
	wire  int_bitslip;
	wire  [7:0]  rx_out_wire;
	wire  slow_clock;
	wire  w_reset;

	rx_lvds_ddio_in   ddio_in
	( 
	.aclr(w_reset),
	.clock(fast_clock),
	.datain(rx_in),
	.dataout_h(wire_ddio_in_dataout_h),
	.dataout_l(wire_ddio_in_dataout_l));
	// synopsys translate_off
	initial
		cda_h_shiftreg3a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) cda_h_shiftreg3a <= 1'b0;
		else  cda_h_shiftreg3a <= {ddio_dataout_h[0]};
	// synopsys translate_off
	initial
		cda_h_shiftreg9a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) cda_h_shiftreg9a <= 1'b0;
		else  cda_h_shiftreg9a <= {ddio_dataout_h[1]};
	// synopsys translate_off
	initial
		cda_l_shiftreg10a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) cda_l_shiftreg10a <= 2'b0;
		else  cda_l_shiftreg10a <= {cda_l_shiftreg10a[0], ddio_dataout_l[1]};
	// synopsys translate_off
	initial
		cda_l_shiftreg4a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) cda_l_shiftreg4a <= 2'b0;
		else  cda_l_shiftreg4a <= {cda_l_shiftreg4a[0], ddio_dataout_l[0]};
	// synopsys translate_off
	initial
		h_shiftreg2a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) h_shiftreg2a <= 2'b0;
		else  h_shiftreg2a <= {h_shiftreg2a[0], wire_l_mux6a_result};
	// synopsys translate_off
	initial
		h_shiftreg8a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) h_shiftreg8a <= 2'b0;
		else  h_shiftreg8a <= {h_shiftreg8a[0], wire_l_mux12a_result};
	// synopsys translate_off
	initial
		int_bitslip_reg = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		  int_bitslip_reg <= int_bitslip;
	// synopsys translate_off
	initial
		l_shiftreg1a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) l_shiftreg1a <= 2'b0;
		else  l_shiftreg1a <= {l_shiftreg1a[0], wire_h_mux5a_result};
	// synopsys translate_off
	initial
		l_shiftreg7a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock or  posedge w_reset)
		if (w_reset == 1'b1) l_shiftreg7a <= 2'b0;
		else  l_shiftreg7a <= {l_shiftreg7a[0], wire_h_mux11a_result};
	// synopsys translate_off
	initial
		pll_lock_sync = 0;
	// synopsys translate_on
	always @ ( posedge wire_lvds_rx_pll_locked or  posedge pll_areset)
		if (pll_areset == 1'b1) pll_lock_sync <= 1'b0;
		else  pll_lock_sync <= 1'b1;
	// synopsys translate_off
	initial
		rx_data_align_reg = 0;
	// synopsys translate_on
	always @ ( posedge slow_clock)
		  rx_data_align_reg <= rx_data_align;
	// synopsys translate_off
	initial
		rx_reg = 0;
	// synopsys translate_on
	always @ ( posedge slow_clock or  posedge w_reset)
		if (w_reset == 1'b1) rx_reg <= 8'b0;
		else  rx_reg <= rx_out_wire;
	rx_dffpipe   h_dffpipe
	( 
	.clock(fast_clock),
	.clrn((~ w_reset)),
	.d(ddio_dataout_h_int),
	.q(wire_h_dffpipe_q));
	rx_dffpipe   l_dffpipe
	( 
	.clock(fast_clock),
	.clrn((~ w_reset)),
	.d(ddio_dataout_l_int),
	.q(wire_l_dffpipe_q));
	rx_cntr   bitslip_cntr
	( 
	.clock(fast_clock),
	.cnt_en(bitslip),
	.q(wire_bitslip_cntr_q));
	rx_mux   h_mux11a
	( 
	.data({cda_l_shiftreg10a[1], cda_h_shiftreg9a[0], cda_l_shiftreg10a[0], ddio_dataout_h[1]}),
	.result(wire_h_mux11a_result),
	.sel(bitslip_en));
	rx_mux   h_mux5a
	( 
	.data({cda_l_shiftreg4a[1], cda_h_shiftreg3a[0], cda_l_shiftreg4a[0], ddio_dataout_h[0]}),
	.result(wire_h_mux5a_result),
	.sel(bitslip_en));
	rx_mux   l_mux12a
	( 
	.data({cda_h_shiftreg9a[0], cda_l_shiftreg10a[0], ddio_dataout_h[1], ddio_dataout_l[1]}),
	.result(wire_l_mux12a_result),
	.sel(bitslip_en));
	rx_mux   l_mux6a
	( 
	.data({cda_h_shiftreg3a[0], cda_l_shiftreg4a[0], ddio_dataout_h[0], ddio_dataout_l[0]}),
	.result(wire_l_mux6a_result),
	.sel(bitslip_en));
	cycloneive_pll   lvds_rx_pll
	( 
	.activeclock(),
	.areset(pll_areset),
	.clk(wire_lvds_rx_pll_clk),
	.clkbad(),
	.fbin(wire_lvds_rx_pll_fbout),
	.fbout(wire_lvds_rx_pll_fbout),
	.inclk({1'b0, rx_inclock}),
	.locked(wire_lvds_rx_pll_locked),
	.phasedone(),
	.scandataout(),
	.scandone(),
	.vcooverrange(),
	.vcounderrange()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clkswitch(1'b0),
	.configupdate(1'b0),
	.pfdena(1'b1),
	.phasecounterselect({3{1'b0}}),
	.phasestep(1'b0),
	.phaseupdown(1'b0),
	.scanclk(1'b0),
	.scanclkena(1'b1),
	.scandata(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		lvds_rx_pll.clk0_divide_by = 1,
		lvds_rx_pll.clk0_multiply_by = 2,
		lvds_rx_pll.clk0_phase_shift = "-2500",
		lvds_rx_pll.clk1_divide_by = 2,
		lvds_rx_pll.clk1_multiply_by = 2,
		lvds_rx_pll.clk1_phase_shift = "-2500",
		lvds_rx_pll.inclk0_input_frequency = 20000,
		lvds_rx_pll.operation_mode = "source_synchronous",
		lvds_rx_pll.self_reset_on_loss_lock = "on",
		lvds_rx_pll.lpm_type = "cycloneive_pll";
	assign
		bitslip = ((~ int_bitslip_reg) & int_bitslip),
		bitslip_en = wire_bitslip_cntr_q,
		ddio_dataout_h = wire_h_dffpipe_q,
		ddio_dataout_h_int = wire_ddio_in_dataout_h,
		ddio_dataout_l = wire_l_dffpipe_q,
		ddio_dataout_l_int = wire_ddio_in_dataout_l,
		fast_clock = wire_lvds_rx_pll_clk[0],
		int_bitslip = rx_data_align_reg,
		rx_locked = (wire_lvds_rx_pll_locked & pll_lock_sync),
		rx_out = rx_reg,
		rx_out_wire = {l_shiftreg7a[1], h_shiftreg8a[1], l_shiftreg7a[0], h_shiftreg8a[0], l_shiftreg1a[1], h_shiftreg2a[1], l_shiftreg1a[0], h_shiftreg2a[0]},
		rx_outclock = slow_clock,
		slow_clock = wire_lvds_rx_pll_clk[1],
		w_reset = pll_areset;
endmodule //rx_lvds_rx
//VALID FILE
