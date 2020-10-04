	component LVDS_echo_FPGA12_qsys is
		port (
			clk_clk                                                 : in  std_logic                    := 'X'; -- clk
			reset_reset_n                                           : in  std_logic                    := 'X'; -- reset_n
			lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga1        : out std_logic;                           -- tx_out_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga1   : out std_logic;                           -- tx_outclock_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga1 : in  std_logic                    := 'X'; -- rdy_from_recv_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga1         : in  std_logic                    := 'X'; -- rx_in_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga1    : in  std_logic                    := 'X'; -- rx_inclock_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga1 : out std_logic;                           -- rdy_for_trans_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga2        : out std_logic;                           -- tx_out_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga2   : out std_logic;                           -- tx_outclock_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga2 : in  std_logic                    := 'X'; -- rdy_from_recv_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga2         : in  std_logic                    := 'X'; -- rx_in_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga2    : in  std_logic                    := 'X'; -- rx_inclock_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga2 : out std_logic;                           -- rdy_for_trans_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rst_n_out           : out std_logic;                           -- rst_n_out
			lvds_echo_fpga12_4bit_0_conduit_end_rst_n_gpio          : in  std_logic                    := 'X'; -- rst_n_gpio
			lvds_echo_fpga12_4bit_0_conduit_end_led_fpga2           : out std_logic_vector(7 downto 0);        -- led_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_led_fpga1           : out std_logic_vector(7 downto 0)         -- led_fpga1
		);
	end component LVDS_echo_FPGA12_qsys;

	u0 : component LVDS_echo_FPGA12_qsys
		port map (
			clk_clk                                                 => CONNECTED_TO_clk_clk,                                                 --                                 clk.clk
			reset_reset_n                                           => CONNECTED_TO_reset_reset_n,                                           --                               reset.reset_n
			lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga1        => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga1,        -- lvds_echo_fpga12_4bit_0_conduit_end.tx_out_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga1   => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga1,   --                                    .tx_outclock_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga1 => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga1, --                                    .rdy_from_recv_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga1         => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga1,         --                                    .rx_in_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga1    => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga1,    --                                    .rx_inclock_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga1 => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga1, --                                    .rdy_for_trans_fpga1
			lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga2        => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_tx_out_fpga2,        --                                    .tx_out_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga2   => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_tx_outclock_fpga2,   --                                    .tx_outclock_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga2 => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rdy_from_recv_fpga2, --                                    .rdy_from_recv_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga2         => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rx_in_fpga2,         --                                    .rx_in_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga2    => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rx_inclock_fpga2,    --                                    .rx_inclock_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga2 => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rdy_for_trans_fpga2, --                                    .rdy_for_trans_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_rst_n_out           => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rst_n_out,           --                                    .rst_n_out
			lvds_echo_fpga12_4bit_0_conduit_end_rst_n_gpio          => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_rst_n_gpio,          --                                    .rst_n_gpio
			lvds_echo_fpga12_4bit_0_conduit_end_led_fpga2           => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_led_fpga2,           --                                    .led_fpga2
			lvds_echo_fpga12_4bit_0_conduit_end_led_fpga1           => CONNECTED_TO_lvds_echo_fpga12_4bit_0_conduit_end_led_fpga1            --                                    .led_fpga1
		);

