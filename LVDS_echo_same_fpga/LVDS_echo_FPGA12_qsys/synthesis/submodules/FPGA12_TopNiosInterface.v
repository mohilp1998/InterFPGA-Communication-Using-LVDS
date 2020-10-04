module FPGA12_TopNiosInterface(
CLK,
RST_N,

//conduit signals
tx_out_fpga1,
tx_outclock_fpga1,
tx_align_done_fpga1,
rx_in_fpga1,
rx_inclock_fpga1,
rx_align_done_fpga1,
  
tx_out_fpga2,
tx_outclock_fpga2,
tx_align_done_fpga2,
rx_in_fpga2,
rx_inclock_fpga2,
rx_align_done_fpga2,

led_out, 

address,
read,
readdata,
write,
writedata,
irq
);

input CLK,RST_N;

//conduit signals

//Avalon interface signals
input [2:0] address;
input read;
output [31:0]readdata;
input write;
input [31:0]writedata;
output irq;

    output 	[1:0]	tx_out_fpga1;
    output			tx_outclock_fpga1;
	input			tx_align_done_fpga1;
	input	[1:0] 	rx_in_fpga1;
	input			rx_inclock_fpga1;
	output			rx_align_done_fpga1;
  
	output 	[1:0]	tx_out_fpga2;
	output			tx_outclock_fpga2;
	input			tx_align_done_fpga2;
	input	[1:0] 	rx_in_fpga2;
	input			rx_inclock_fpga2;
	output			rx_align_done_fpga2;

output 	[7:0]	led_out;
wire [7:0]	led_out_fpga1;
wire [7:0]	led_out_fpga2;

assign led_out = led_out_fpga1;
wire [31 : 0] putFlit_put;
wire EN_putFlit_put;
wire RDY_putFlit_put;
wire EN_getFlit_get;
wire [31 : 0] getFlit_get;
wire RDY_getFlit_get;

assign putFlit_put = writedata;
assign readdata = (2'b00 == address) ? {30'b0,RDY_getFlit_get,RDY_putFlit_put} : getFlit_get;
assign EN_putFlit_put = (2'b01 == address) ? write : 1'b0;
assign EN_getFlit_get = (2'b10 == address) ? read : 1'b0;

assign irq = RDY_getFlit_get;

mkMFpgaTop T1(
	     .CLK(CLK),
	     .RST_N(RST_N),

	     .putFlit0_put(putFlit_put),
	     .EN_putFlit0_put(EN_putFlit_put),
	     .RDY_putFlit0_put(RDY_putFlit_put),

	     .EN_getFlit0_get(EN_getFlit_get),
	     .getFlit0_get(getFlit_get),
	     .RDY_getFlit0_get(RDY_getFlit_get),
          
         .tx_out_fpga1(tx_out_fpga1),
         .tx_outclock_fpga1(tx_outclock_fpga1),
	     .tx_align_done_fpga1(tx_align_done_fpga1),
	     .rx_in_fpga1(rx_in_fpga1),
	     .rx_inclock_fpga1(rx_inclock_fpga1),
	     .rx_align_done_fpga1(rx_align_done_fpga1),
	     .led_out_fpga1(led_out_fpga1),
  
	     .tx_out_fpga2(tx_out_fpga2),
	     .tx_outclock_fpga2(tx_outclock_fpga2),
	     .tx_align_done_fpga2(tx_align_done_fpga2),
	     .rx_in_fpga2(rx_in_fpga2),
	     .rx_inclock_fpga2(rx_inclock_fpga2),
	     .rx_align_done_fpga2(rx_align_done_fpga2),
	     .led_out_fpga2(led_out_fpga2)
);
endmodule
