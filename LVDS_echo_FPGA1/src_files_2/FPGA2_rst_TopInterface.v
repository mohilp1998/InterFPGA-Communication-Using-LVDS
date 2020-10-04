module FPGA2_rst_TopInterface(
CLK,
RST_N_key,
RST_N_gpio,

//signals for InterFPGA
CLK_clkinX5,
CLK_clkoutX5,
deq_serial5_get,
IN_RDY_deq_serial4_get,
OUT_RDY_deq_serial5_get,
enq_serial5_put,
IN_RDY_enq_serial4_put,
OUT_RDY_enq_serial5_put,

led);

input CLK,RST_N_key,RST_N_gpio;

//conduit signals
input CLK_clkinX5;
output CLK_clkoutX5;
// actionvalue method deq_serial5_get
input  IN_RDY_deq_serial4_get;
output [3 : 0] deq_serial5_get;
output OUT_RDY_deq_serial5_get;
// action method enq_serial5_put
input  [3 : 0] enq_serial5_put;
input  IN_RDY_enq_serial4_put;
output OUT_RDY_enq_serial5_put;

output [7 : 0] led;
//get-put to be interfaced with NIOS
//wire [31 : 0] putFlit_put;
//wire EN_putFlit_put;
//wire RDY_putFlit_put;
//wire EN_getFlit_get;
//wire [31 : 0] getFlit_get;
//wire RDY_getFlit_get;

wire EN_deq_serial5_get;
wire EN_enq_serial5_put;
wire RST_N;

assign CLK_clkoutX5 = CLK;

assign EN_enq_serial5_put = OUT_RDY_enq_serial5_put && IN_RDY_deq_serial4_get;
assign EN_deq_serial5_get = OUT_RDY_deq_serial5_get && IN_RDY_enq_serial4_put;
assign RST_N = RST_N_key && RST_N_gpio;

mkTop_fpga2 T1(
	     .CLK(CLK),
	     .RST_N(RST_N),

	     .CLK_clkinX5(CLK_clkinX5),
	     .EN_deq_serial5_get(EN_deq_serial5_get),
	     .deq_serial5_get(deq_serial5_get),
	     .RDY_deq_serial5_get(OUT_RDY_deq_serial5_get),
	     .enq_serial5_put(enq_serial5_put),
	     .EN_enq_serial5_put(EN_enq_serial5_put),
	     .RDY_enq_serial5_put(OUT_RDY_enq_serial5_put),
		  .led(led));

endmodule

