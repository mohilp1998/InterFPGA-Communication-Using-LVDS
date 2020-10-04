module FPGA2_rst_TopInterface(
CLK,
RST_N_key,
RST_N_gpio,

//signals for LVDS
tx_out_fpga2,
tx_outclock_fpga2,
tx_align_done_fpga2,
rx_in_fpga2,
rx_inclock_fpga2,
rx_align_done_fpga2,

led);

input CLK,RST_N_key,RST_N_gpio;

//conduit signals
output 	[1:0]	tx_out_fpga2;
output			tx_outclock_fpga2;
input			tx_align_done_fpga2;
input	[1:0] 	rx_in_fpga2;
input			rx_inclock_fpga2;
output			rx_align_done_fpga2;

// actionvalue method deq_serial4_get
wire [31 : 0]   deq_serial5_get;
wire            RDY_deq_serial5_get;
wire            EN_deq_serial5_get;

// action method enq_serial4_put
wire  [31 : 0]  enq_serial5_put;
wire            RDY_enq_serial5_put;
wire            EN_enq_serial5_put;

output [7 : 0] led;

wire RST_N;
wire CLK_clkinX5;

assign RST_N = RST_N_key && RST_N_gpio;
assign CLK_clkinX5 = rx_inclock_fpga2;

mkTop_fpga2 T1(
	     .CLK(CLK),
	     .RST_N(RST_N),

	     .CLK_clkinX5(CLK_clkinX5),
	     .RST_N_rstinX5(RST_N),
         .EN_deq_serial5_get(EN_deq_serial5_get),
	     .deq_serial5_get(deq_serial5_get),
	     .RDY_deq_serial5_get(RDY_deq_serial5_get),
	     .enq_serial5_put(enq_serial5_put),
	     .EN_enq_serial5_put(EN_enq_serial5_put),
	     .RDY_enq_serial5_put(RDY_enq_serial5_put));

LVDS_fpga fpga2(
    .reset_n(RST_N),
	.tx_inclock(CLK),
	.tx_out(tx_out_fpga2),
	.tx_outclock(tx_outclock_fpga2),
	.tx_align_done(tx_align_done_fpga2),
	.rx_in(rx_in_fpga2),
	.rx_inclock(rx_inclock_fpga2),
	.rx_align_done(rx_align_done_fpga2),
	.led_out(led),
	
	.enq_tx(deq_serial5_get),
	.EN_enq_tx(EN_deq_serial5_get),
	.RDY_enq_tx(RDY_deq_serial5_get),

	.deq_rx(enq_serial5_put),
	.EN_deq_rx(EN_enq_serial5_put),
    .RDY_deq_rx(RDY_enq_serial5_put)
);

endmodule

