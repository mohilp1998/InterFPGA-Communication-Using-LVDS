`timescale 1 ns / 1 ps

module testbench();
  reg  CLK,RST_N;
  
  reg  [31 : 0] putFlit_put;
  reg  EN_putFlit_put;
  wire RDY_putFlit_put;

  // actionvalue method getFlit_get
  reg  EN_getFlit_get;
  wire [31 : 0] getFlit_get;
  wire RDY_getFlit_get;

  initial 
  begin
  	$dumpfile("waveform.vcd");
   	$dumpvars(0,testbench); 
	CLK = 1;
	RST_N = 1;

	putFlit_put = 32'h00000000;
	EN_putFlit_put = 0;
	EN_getFlit_get = 0;

	#120
	RST_N = 0;

	#20
	RST_N = 1;

	#20;
	putFlit_put = 32'h98000000;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF00;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000001;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF01;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000002;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF02;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000003;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF03;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000004;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF04;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000005;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF05;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000006;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF06;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000007;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF07;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000008;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF08;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000009;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF09;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000A;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0A;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000B;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0B;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000C;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0C;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000D;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0D;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000E;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0E;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h9800000F;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF0F;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000010;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF10;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000011;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF11;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000012;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF12;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000013;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF13;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;

	#20;
	putFlit_put = 32'h98000014;
//	putFlit_put = 32'h84000000;
	EN_putFlit_put = 1;
	EN_getFlit_get = 1;

	#20
	putFlit_put = 32'hD80FFF14;
//	putFlit_put = 32'hC40FFF00;
	EN_putFlit_put = 1;



	#20;
	putFlit_put = 32'h00000000;
	EN_putFlit_put = 0;
	EN_getFlit_get = 1;
 end

always #10 CLK=~CLK;

mkMFpgaTop dut(   .CLK(CLK),
	     .RST_N(RST_N),

	     .putFlit0_put(putFlit_put),
	     .EN_putFlit0_put(EN_putFlit_put),
	     .RDY_putFlit0_put(RDY_putFlit_put),

	     .EN_getFlit0_get(EN_getFlit_get),
	     .getFlit0_get(getFlit_get),
	     .RDY_getFlit0_get(RDY_getFlit_get));

endmodule

	
