
module LVDS_echo_FPGA1_qsys (
	clk_clk,
	lvds_echo_fpga1_component_0_conduit_end_rst_n_out,
	lvds_echo_fpga1_component_0_conduit_end_led,
	lvds_echo_fpga1_component_0_conduit_end_rx_align_done_fpga1,
	lvds_echo_fpga1_component_0_conduit_end_rx_inclock_fpga1,
	lvds_echo_fpga1_component_0_conduit_end_tx_align_done_fpga1,
	lvds_echo_fpga1_component_0_conduit_end_tx_out_fpga1,
	lvds_echo_fpga1_component_0_conduit_end_rx_in_fpga1,
	lvds_echo_fpga1_component_0_conduit_end_tx_outclock_fpga1,
	reset_reset_n);	

	input		clk_clk;
	output		lvds_echo_fpga1_component_0_conduit_end_rst_n_out;
	output	[7:0]	lvds_echo_fpga1_component_0_conduit_end_led;
	output		lvds_echo_fpga1_component_0_conduit_end_rx_align_done_fpga1;
	input		lvds_echo_fpga1_component_0_conduit_end_rx_inclock_fpga1;
	input		lvds_echo_fpga1_component_0_conduit_end_tx_align_done_fpga1;
	output	[1:0]	lvds_echo_fpga1_component_0_conduit_end_tx_out_fpga1;
	input	[1:0]	lvds_echo_fpga1_component_0_conduit_end_rx_in_fpga1;
	output		lvds_echo_fpga1_component_0_conduit_end_tx_outclock_fpga1;
	input		reset_reset_n;
endmodule
