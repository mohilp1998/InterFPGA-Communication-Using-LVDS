module	Both_FPGA_Top(
//FPGA1
CLK,
RST_N,
RST_N_out,

//Conduit signals for InterFPGA
tx_out_fpga1,
tx_outclock_fpga1,
RDY_from_recv_fpga1,
rx_in_fpga1,
rx_inclock_fpga1,
RDY_for_trans_fpga1,
led_fpga1,
		  
//Avalon Bus interface
address,
read,
readdata,
write,
writedata,
irq,

//FPGA2
RST_N_gpio,

//signals for LVDS
tx_out_fpga2,
tx_outclock_fpga2,
RDY_from_recv_fpga2,
rx_in_fpga2,
rx_inclock_fpga2,
RDY_for_trans_fpga2,
led_fpga2
);

input CLK,RST_N;
output RST_N_out;
input RST_N_gpio;

//Avalon interface signals
input [2:0] address;
input read;
output [31:0]readdata;
input write;
input [31:0]writedata;
output irq;

//conduit signals
output 	[0:0]	tx_out_fpga1;
output			tx_outclock_fpga1;
input			RDY_from_recv_fpga1;
input	[0:0] 	rx_in_fpga1;
input			rx_inclock_fpga1;
output			RDY_for_trans_fpga1;
output [7:0] 	led_fpga1;

//conduit signals
output 	[0:0]	tx_out_fpga2;
output			tx_outclock_fpga2;
input			RDY_from_recv_fpga2;
input	[0:0] 	rx_in_fpga2;
input			rx_inclock_fpga2;
output			RDY_for_trans_fpga2;
output [7:0] 	led_fpga2;


FPGA1_TopNiosInterface F1(
	.CLK(CLK),
	.RST_N(RST_N),
	.RST_N_out(RST_N_out),

	.tx_out_fpga1(tx_out_fpga1),
	.tx_outclock_fpga1(tx_outclock_fpga1),
	.RDY_from_recv_fpga1(RDY_from_recv_fpga1),
	.rx_in_fpga1(rx_in_fpga1),
	.rx_inclock_fpga1(rx_inclock_fpga1),
	.RDY_for_trans_fpga1(RDY_for_trans_fpga1),
	.led(led_fpga1),
			  

	.address(address),
	.read(read),
	.readdata(readdata),
	.write(write),
	.writedata(writedata),
	.irq(irq)
	);


FPGA2_rst_TopInterface F2(
	.CLK(CLK),
	.RST_N_key(RST_N),
	.RST_N_gpio(RST_N_gpio),

	.tx_out_fpga2(tx_out_fpga2),
	.tx_outclock_fpga2(tx_outclock_fpga2),
	.RDY_from_recv_fpga2(RDY_from_recv_fpga2),
	.rx_in_fpga2(rx_in_fpga2),
	.rx_inclock_fpga2(rx_inclock_fpga2),
	.RDY_for_trans_fpga2(RDY_for_trans_fpga2),

	.led(led_fpga2)
	);

endmodule