
module LVDS_echo_FPGA12_qsys (
	clk_clk,
	reset_reset_n,
	lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga1,
	lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_rst_n_out,
	lvds_echo_fpga12_4bit_0_conduit_end_rst_n_gpio,
	lvds_echo_fpga12_4bit_0_conduit_end_led_fpga2,
	lvds_echo_fpga12_4bit_0_conduit_end_led_fpga1);	

	input		clk_clk;
	input		reset_reset_n;
	output		lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga1;
	output		lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga1;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga1;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga1;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga1;
	output		lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga1;
	output		lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga2;
	output		lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga2;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga2;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga2;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga2;
	output		lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga2;
	output		lvds_echo_fpga12_4bit_0_conduit_end_rst_n_out;
	input		lvds_echo_fpga12_4bit_0_conduit_end_rst_n_gpio;
	output	[7:0]	lvds_echo_fpga12_4bit_0_conduit_end_led_fpga2;
	output	[7:0]	lvds_echo_fpga12_4bit_0_conduit_end_led_fpga1;
endmodule
