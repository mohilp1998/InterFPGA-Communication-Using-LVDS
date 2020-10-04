`timescale 1 ps / 1ps

module LVDS_fpga(
	input 	 		reset_n,
	input 			tx_inclock,
	output 	[0:0]	tx_out,
	output			tx_outclock,
	input			RDY_from_recv,
	input	[0:0] 	rx_in,
	input			rx_inclock,
	output	reg		RDY_for_trans,
	output 			rx_outclock,
	
	
	// input 	[31:0] 	d_in_tx,
	// input			enq_tx,
	// output 			full_n_tx,

	// output 	[31:0] 	d_out_rx,
	// input			deq_rx,
	// output 			empty_n_rx

	input 	[31:0] 		enq_tx,
	output	reg			EN_enq_tx,
	input 					RDY_enq_tx,

	output 	reg [31:0] 	deq_rx,
	output 	reg			EN_deq_rx,
	input 					RDY_deq_rx,


	output 	[7:0]	led_out
);
	
	
	parameter SIZE = 4;
	parameter  t0 = 4'b0000;
	parameter  t1 = 4'b0001;
	parameter  t2 = 4'b0010;
	parameter  t3 = 4'b0011;
	parameter  t4 = 4'b0100;
	parameter  t5 = 4'b0101;
	parameter  t6 = 4'b0110;
	parameter  t7 = 4'b0111;
	parameter  t8 = 4'b1000;
	parameter  t9 = 4'b1001;
	parameter  t10 = 4'b1010;
	parameter  t11 = 4'b1011;

	reg [SIZE-1:0]	state_tx;
	reg	[SIZE-1:0]	next_state_tx;

	reg [SIZE-1:0]	state_rx;
	reg	[SIZE-1:0]	next_state_rx;

	wire pll_areset,rx_locked,tx_locked;
	reg rx_data_align;
	reg [3:0] tx_in;
	// reg align_done;
	wire [3:0] rx_out;
	reg [2:0] count;
	// wire RDY_from_recv;
	// reg RDY_for_trans;

	//reg 	flag;

	//FIFO_TX

	// wire [31:0] enq_tx;
	// reg EN_enq_tx;
	// wire RDY_enq_tx;
	reg [3:0] sub_0_tx;
	reg [3:0] sub_1_tx;
	reg [3:0] sub_2_tx;
	reg [3:0] sub_3_tx;
	reg [3:0] sub_4_tx;
	reg [3:0] sub_5_tx;
	reg [3:0] sub_6_tx;
	reg [3:0] sub_7_tx;

	//FIFO_RX

	// reg [31:0] deq_rx;
	// reg EN_deq_rx;
	// wire RDY_deq_rx;
	reg [3:0] sub_0_rx;
	reg [3:0] sub_1_rx;
	reg [3:0] sub_2_rx;
	reg [3:0] sub_3_rx;
	reg [3:0] sub_4_rx;
	reg [3:0] sub_5_rx;
	reg [3:0] sub_6_rx;
	reg [3:0] sub_7_rx;

	reg [2:0] led_tx_state,led_rx_state;	

    	//assign led_out = deq_rx[7:0];
	assign led_out = {tx_locked,rx_locked,led_tx_state,led_rx_state};


tx tx1(

	.pll_areset(pll_areset),
	.tx_in(tx_in),
	.tx_inclock(tx_inclock),
	.tx_locked(tx_locked),
	.tx_out(tx_out),
	.tx_outclock(tx_outclock)

	);


rx rx1(

	.pll_areset(pll_areset),
	.rx_data_align(rx_data_align),
	.rx_in(rx_in),
	.rx_inclock(rx_inclock),
	.rx_locked(rx_locked),
	.rx_out(rx_out),
	.rx_outclock(rx_outclock)
	);


//assign pll_areset = ~reset_n;
assign  pll_areset = 1'b0;
// assign RDY_from_recv = tx_align_done;
// assign rx_align_done = RDY_for_trans;

// always @(posedge tx_inclock) begin
// 	if (reset_n == 0) begin
// 		state_tx = t0;
// 	end
// 	else  begin
// 		state_tx = next_state_tx;
// 	end
// end


always @(posedge tx_inclock) 
begin: TX_FSM
	if(reset_n == 0) begin
		// state_tx = t0;
		led_tx_state = 3'b000;
		next_state_tx = t0;
		tx_in = 4'b000;
		EN_enq_tx = 1'b0;
		sub_0_tx = 4'b000;
		sub_1_tx = 4'b000;
		sub_2_tx = 4'b000;
		sub_3_tx = 4'b000;
		sub_4_tx = 4'b000;
		sub_5_tx = 4'b000;
		sub_6_tx = 4'b000;
		sub_7_tx = 4'b000;
	end
	else begin
		case(state_tx)
			t0: begin
				led_tx_state = 3'b000;
				if (tx_locked == 1) begin
					next_state_tx = t1;
					tx_in = 4'b0001;

					EN_enq_tx = 1'b0;
					sub_0_tx = 4'b000;
					sub_1_tx = 4'b000;
					sub_2_tx = 4'b000;
					sub_3_tx = 4'b000;
					sub_4_tx = 4'b000;
					sub_5_tx = 4'b000;
					sub_6_tx = 4'b000;
					sub_7_tx = 4'b000;
				end
				else begin
					next_state_tx = t0;
					tx_in = 4'b000;

					EN_enq_tx = 1'b0;
					sub_0_tx = 4'b000;
					sub_1_tx = 4'b000;
					sub_2_tx = 4'b000;
					sub_3_tx = 4'b000;
					sub_4_tx = 4'b000;
					sub_5_tx = 4'b000;
					sub_6_tx = 4'b000;
					sub_7_tx = 4'b000;					
				end
			end
			t1: begin
				if (RDY_from_recv) begin
					tx_in = 4'b0111;
					EN_enq_tx = 1'b0;
					next_state_tx = t2;

					led_tx_state = 3'b001;
					sub_0_tx = 4'b000;
					sub_1_tx = 4'b000;
					sub_2_tx = 4'b000;
					sub_3_tx = 4'b000;
					sub_4_tx = 4'b000;
					sub_5_tx = 4'b000;
					sub_6_tx = 4'b000;
					sub_7_tx = 4'b000;
				end
				else begin
					tx_in = 4'b0001;
					next_state_tx = t1;
					EN_enq_tx = 1'b0;

					led_tx_state = 3'b000;
					sub_0_tx = 4'b000;
					sub_1_tx = 4'b000;
					sub_2_tx = 4'b000;
					sub_3_tx = 4'b000;
					sub_4_tx = 4'b000;
					sub_5_tx = 4'b000;
					sub_6_tx = 4'b000;
					sub_7_tx = 4'b000;
				end
			end
			t2: begin
				if (RDY_from_recv) begin
					if (RDY_enq_tx) begin
						EN_enq_tx = 1'b1;
						sub_0_tx = enq_tx [31:28];
						sub_1_tx = enq_tx [27:24];
						sub_2_tx = enq_tx [23:20];
						sub_3_tx = enq_tx [19:16];
						sub_4_tx = enq_tx [15:12];
						sub_5_tx = enq_tx [11:8];
						sub_6_tx = enq_tx [7:4];
						sub_7_tx = enq_tx [3:0];

						led_tx_state = 3'b011;
						tx_in = sub_0_tx;
						next_state_tx = t3;
					end
					else begin
						EN_enq_tx = 1'b0;
						sub_0_tx = 4'b000;
						sub_1_tx = 4'b000;
						sub_2_tx = 4'b000;
						sub_3_tx = 4'b000;
						sub_4_tx = 4'b000;
						sub_5_tx = 4'b000;
						sub_6_tx = 4'b000;
						sub_7_tx = 4'b000;

						led_tx_state = 3'b001;
						tx_in = sub_0_tx;
						next_state_tx = t3;
					end
				end
				else begin
					EN_enq_tx = 1'b0;
					sub_0_tx = 4'b000;
					sub_1_tx = 4'b000;
					sub_2_tx = 4'b000;
					sub_3_tx = 4'b000;
					sub_4_tx = 4'b000;
					sub_5_tx = 4'b000;
					sub_6_tx = 4'b000;
					sub_7_tx = 4'b000;

					led_tx_state = 3'b000;
					tx_in = sub_0_tx;
					next_state_tx = t3;
				end
			end
			t3: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_1_tx;
				next_state_tx = t4;
			end
			t4: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_2_tx;
				next_state_tx = t5;
			end
			t5: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_3_tx;
				next_state_tx = t6;
			end
			t6: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_4_tx;
				next_state_tx = t7;
			end
			t7: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_5_tx;
				next_state_tx = t8;
			end
			t8: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_6_tx;
				next_state_tx = t9;
			end
			t9: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_7_tx;
				next_state_tx = t2;
			end
		endcase
	end
	state_tx = next_state_tx;	
end

// initial	
// begin
// 	flag = 1'b1;
// end

// always @(negedge rx_outclock) begin
// 	if (reset_n == 0) begin
// 		state_rx = t1;
// 	//	flag = ~flag;
// 	end
// 	else begin
// 		state_rx = next_state_rx;
// 	end
//  end

always @(posedge rx_outclock) begin

	if (reset_n == 0) begin
		// state_rx = t1;
		next_state_rx = t1;
		RDY_for_trans = 1'b0;
		rx_data_align = 1'b0;
		count = 3'b000;
		led_rx_state = 3'b000;

		EN_deq_rx = 1'b0;
		sub_0_rx = 4'b000;
		sub_1_rx = 4'b000;
		sub_2_rx = 4'b000;
		sub_3_rx = 4'b000;
		sub_4_rx = 4'b000;
		sub_5_rx = 4'b000;
		sub_6_rx = 4'b000;
		sub_7_rx = 4'b000;
	//	flag = ~flag;
	end
	else begin
		case(state_rx)
			// t0: begin
			// 	led_rx_state = 4'b0000;
			// 	if (rx_locked) begin
			// 		next_state_rx = t1;
			// 		align_done = 1'b0;
			// 		rx_data_align = 1'b1;
			// 		count = 3'b000;

			// 		EN_deq_rx = 1'b0;
			// 		sub_0_rx = 8'b00000000;
			// 		sub_1_rx = 8'b00000000;
			// 		sub_2_rx = 8'b00000000;
			// 		sub_3_rx = 8'b00000000;
			// 		deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
			// 	end
			// 	else begin
			// 		next_state_rx = t0;
			// 		align_done = 1'b0;
			// 		rx_data_align = 1'b1;
			// 		count = 3'b000;

			// 		EN_deq_rx = 1'b0;
			// 		sub_0_rx = 8'b00000000;
			// 		sub_1_rx = 8'b00000000;
			// 		sub_2_rx = 8'b00000000;
			// 		sub_3_rx = 8'b00000000;
			// 		deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
			// 	end
			// end
			t1: begin
				//if (rx_out == 8'b01101010) begin
				if (rx_out == 4'b0001) begin
					next_state_rx = t2;
					RDY_for_trans = 1'b0;
					rx_data_align = 1'b0;
					count = 3'b000;
					led_rx_state = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
				else begin
					next_state_rx = t1;
					RDY_for_trans = 1'b0;
					rx_data_align = ~rx_data_align;
					count = 3'b000;
					led_rx_state = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
			end
			t2: begin
				// led_rx_state = 4'b0010;
				if (count == 3'b101) begin
					next_state_rx = t3;
					RDY_for_trans = RDY_deq_rx;
					rx_data_align = 1'b0;
					count = 3'b000;
					led_rx_state = 3'b001;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
				else begin
					next_state_rx = t2;
					RDY_for_trans = 1'b0;
					rx_data_align = ~rx_data_align;
					count = count + 1'b1;
					led_rx_state = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
			end
			t3: begin
				if (rx_out == 4'b0111) begin
					next_state_rx = t4;
					RDY_for_trans = RDY_deq_rx;
					rx_data_align = 1'b0;
					count = 3'b000;
					led_rx_state = 3'b010;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
				else begin
					next_state_rx = t3;
					RDY_for_trans = RDY_deq_rx;
					rx_data_align = 1'b0;
					count = 3'b000;
					led_rx_state = 3'b001;

					EN_deq_rx = 1'b0;
					sub_0_rx = 4'b000;
					sub_1_rx = 4'b000;
					sub_2_rx = 4'b000;
					sub_3_rx = 4'b000;
					sub_4_rx = 4'b000;
					sub_5_rx = 4'b000;
					sub_6_rx = 4'b000;
					sub_7_rx = 4'b000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				end
				
			end
			t4: begin
				sub_0_rx = rx_out;
				next_state_rx = t5;
				EN_deq_rx = 1'b0;
				
				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t5: begin
				sub_1_rx = rx_out;
				next_state_rx = t6;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t6: begin
				sub_2_rx = rx_out;
				next_state_rx = t7;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t7: begin
				sub_3_rx = rx_out;
				next_state_rx = t8;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t8: begin
				sub_4_rx = rx_out;
				next_state_rx = t9;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t9: begin
				sub_5_rx = rx_out;
				next_state_rx = t10;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t10: begin
				sub_6_rx = rx_out;
				next_state_rx = t11;
				EN_deq_rx = 1'b0;

				RDY_for_trans = RDY_deq_rx;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t11: begin
				sub_7_rx = rx_out;
				next_state_rx = t4;
				deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx,sub_4_rx,sub_5_rx,sub_6_rx,sub_7_rx};
				RDY_for_trans = RDY_deq_rx;
				if (deq_rx[31] == 1) begin
					if (RDY_deq_rx) begin
						led_rx_state = 3'b011;
						EN_deq_rx = 1'b1;
					end
					else begin
						led_rx_state = 3'b101;
						EN_deq_rx = 1'b0;
					end
				end
				else begin
					EN_deq_rx = 1'b0;
					led_rx_state = 3'b001;
	//				led_rx_state = 4'b0111;
				end
			end
		endcase
	end
state_rx = next_state_rx;
end



endmodule
