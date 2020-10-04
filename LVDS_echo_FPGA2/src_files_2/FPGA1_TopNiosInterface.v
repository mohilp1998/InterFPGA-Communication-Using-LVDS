module FPGA1_TopNiosInterface(
CLK,
RST_N,
RST_N_out,

//Conduit signals for InterFPGA
tx_out_fpga1,
tx_outclock_fpga1,
tx_align_done_fpga1,
rx_in_fpga1,
rx_inclock_fpga1,
rx_align_done_fpga1,
led,
		  
//Avalon Bus interface
address,
read,
readdata,
write,
writedata,
irq
);

input CLK,RST_N;
output RST_N_out;

//conduit signals
output 	[1:0]	tx_out_fpga1;
output			tx_outclock_fpga1;
input			tx_align_done_fpga1;
input	[1:0] 	rx_in_fpga1;
input			rx_inclock_fpga1;
output			rx_align_done_fpga1;



wire CLK_clkinX4;
// actionvalue method deq_serial4_get
wire [31 : 0]   deq_serial4_get;
wire            RDY_deq_serial4_get;
wire            EN_deq_serial4_get;

// action method enq_serial4_put
wire  [31 : 0]  enq_serial4_put;
wire            RDY_enq_serial4_put;
wire            EN_enq_serial4_put;


output [7:0] led;

//Avalon interface signals
input [2:0] address;
input read;
output [31:0]readdata;
input write;
input [31:0]writedata;
output irq;

//get-put to be interfaced with NIOS
wire [31 : 0] putFlit_put;
wire EN_putFlit_put;
wire RDY_putFlit_put;
wire EN_getFlit_get;
wire [31 : 0] getFlit_get;
wire RDY_getFlit_get;
	
wire [31:0] d_in_tx_fpga1;
wire        enq_tx_fpga1;
wire        full_n_tx_fpga1;

wire [31:0] d_out_rx_fpga1;
wire        deq_rx_fpga1;
wire        empty_n_rx_fpga1;

assign RST_N_out = RST_N;
assign putFlit_put = writedata;
assign readdata = (2'b00 == address) ? {30'b0,RDY_getFlit_get,RDY_putFlit_put} : getFlit_get;
assign EN_putFlit_put = (2'b01 == address) ? write : 1'b0;
assign EN_getFlit_get = (2'b10 == address) ? read : 1'b0;

assign CLK_clkinX4 = rx_inclock_fpga1;
assign irq = RDY_getFlit_get;


mkTop_fpga1 T1(
	     .CLK(CLK),
	     .RST_N(RST_N),

	     .putFlit0_put(putFlit_put),
	     .EN_putFlit0_put(EN_putFlit_put),
	     .RDY_putFlit0_put(RDY_putFlit_put),

	     .EN_getFlit0_get(EN_getFlit_get),
	     .getFlit0_get(getFlit_get),
	     .RDY_getFlit0_get(RDY_getFlit_get),

	     .CLK_clkinX4(CLK_clkinX4),
		  .RST_N_rstinX4(RST_N),
	     .EN_deq_serial4_get(EN_deq_serial4_get),
	     .deq_serial4_get(deq_serial4_get),
	     .RDY_deq_serial4_get(RDY_deq_serial4_get),
	     .enq_serial4_put(enq_serial4_put),
	     .EN_enq_serial4_put(EN_enq_serial4_put),
	     .RDY_enq_serial4_put(RDY_enq_serial4_put)
         );
LVDS_fpga fpga1(
	.reset_n(RST_N),
	.tx_inclock(CLK),
	.tx_out(tx_out_fpga1),
	.tx_outclock(tx_outclock_fpga1),
	.tx_align_done(tx_align_done_fpga1),
	.rx_in(rx_in_fpga1),
	.rx_inclock(rx_inclock_fpga1),
	.rx_align_done(rx_align_done_fpga1),
	.led_out(led),
	
	.enq_tx(deq_serial4_get),
	.EN_enq_tx(EN_deq_serial4_get),
	.RDY_enq_tx(RDY_deq_serial4_get),

	.deq_rx(enq_serial4_put),
	.EN_deq_rx(EN_enq_serial4_put),
    .RDY_deq_rx(RDY_enq_serial4_put)
);

endmodule

