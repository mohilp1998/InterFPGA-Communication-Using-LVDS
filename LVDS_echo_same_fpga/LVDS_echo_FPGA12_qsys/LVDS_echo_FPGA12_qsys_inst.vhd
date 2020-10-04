	component LVDS_echo_FPGA12_qsys is
		port (
			clk_clk                                                      : in  std_logic                    := 'X';             -- clk
			reset_reset_n                                                : in  std_logic                    := 'X';             -- reset_n
			lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga1        : out std_logic_vector(1 downto 0);                    -- tx_out_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga1   : out std_logic;                                       -- tx_outclock_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga2   : out std_logic;                                       -- tx_outclock_fpga2
			lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga1 : in  std_logic                    := 'X';             -- tx_align_done_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga1         : in  std_logic_vector(1 downto 0) := (others => 'X'); -- rx_in_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga1    : in  std_logic                    := 'X';             -- rx_inclock_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga1 : out std_logic;                                       -- rx_align_done_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga2        : out std_logic_vector(1 downto 0);                    -- tx_out_fpga2
			lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga2 : in  std_logic                    := 'X';             -- tx_align_done_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga2         : in  std_logic_vector(1 downto 0) := (others => 'X'); -- rx_in_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga2    : in  std_logic                    := 'X';             -- rx_inclock_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga2 : out std_logic;                                       -- rx_align_done_fpga2
			lvds_echo_fpga12_component_0_conduit_end_led_out             : out std_logic_vector(7 downto 0)                     -- led_out
		);
	end component LVDS_echo_FPGA12_qsys;

	u0 : component LVDS_echo_FPGA12_qsys
		port map (
			clk_clk                                                      => CONNECTED_TO_clk_clk,                                                      --                                      clk.clk
			reset_reset_n                                                => CONNECTED_TO_reset_reset_n,                                                --                                    reset.reset_n
			lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga1        => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga1,        -- lvds_echo_fpga12_component_0_conduit_end.tx_out_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga1   => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga1,   --                                         .tx_outclock_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga2   => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_outclock_fpga2,   --                                         .tx_outclock_fpga2
			lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga1 => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga1, --                                         .tx_align_done_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga1         => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga1,         --                                         .rx_in_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga1    => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga1,    --                                         .rx_inclock_fpga1
			lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga1 => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga1, --                                         .rx_align_done_fpga1
			lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga2        => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_out_fpga2,        --                                         .tx_out_fpga2
			lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga2 => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_tx_align_done_fpga2, --                                         .tx_align_done_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga2         => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_in_fpga2,         --                                         .rx_in_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga2    => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_inclock_fpga2,    --                                         .rx_inclock_fpga2
			lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga2 => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_rx_align_done_fpga2, --                                         .rx_align_done_fpga2
			lvds_echo_fpga12_component_0_conduit_end_led_out             => CONNECTED_TO_lvds_echo_fpga12_component_0_conduit_end_led_out              --                                         .led_out
		);

