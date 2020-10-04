`timescale 1 ps / 1ps

module LVDS_fpga(
	input 	 		reset_n,
	input 			tx_inclock,
	output 	[1:0]	tx_out,
	output			tx_outclock,
	input			tx_align_done,
	input	[1:0] 	rx_in,
	input			rx_inclock,
	output			rx_align_done,
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
	
	
	parameter SIZE = 3;
	parameter  t0 = 3'b000;
	parameter  t1 = 3'b001;
	parameter  t2 = 3'b010;
	parameter  t3 = 3'b011;
	parameter  t4 = 3'b100;
	parameter  t5 = 3'b101;
	parameter  t6 = 3'b110;
	parameter  t7 = 3'b111;

	reg [SIZE-1:0]	state_tx;
	reg	[SIZE-1:0]	next_state_tx;

	reg [SIZE-1:0]	state_rx;
	reg	[SIZE-1:0]	next_state_rx;

	wire pll_areset,rx_locked,tx_locked;
	reg rx_data_align;
	reg [7:0] tx_in;
	reg align_done;
	wire [7:0] rx_out;
	reg [2:0] count;

	//reg 	flag;

	//FIFO_TX

	// wire [31:0] enq_tx;
	// reg EN_enq_tx;
	// wire RDY_enq_tx;
	reg [7:0] sub_0_tx;
	reg [7:0] sub_1_tx;
	reg [7:0] sub_2_tx;
	reg [7:0] sub_3_tx;

	//FIFO_RX

	// reg [31:0] deq_rx;
	// reg EN_deq_rx;
	// wire RDY_deq_rx;
	reg [7:0] sub_0_rx;
	reg [7:0] sub_1_rx;
	reg [7:0] sub_2_rx;
	reg [7:0] sub_3_rx;

	reg [3:0] led_tx_state,led_rx_state;	

    	//assign led_out = deq_rx[7:0];
	assign led_out = {led_tx_state,led_rx_state};


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
assign rx_align_done = align_done;

always @(posedge tx_inclock) begin
	if (reset_n == 0) begin
		state_tx = t0;
	end
	else  begin
		state_tx = next_state_tx;
	end
end


always @(posedge tx_inclock) 
begin: TX_FSM
	if(reset_n == 0) begin
		// state_tx = t0;
		next_state_tx = t0;
		tx_in = 8'b00000000;
		EN_enq_tx = 1'b0;
		sub_0_tx = 8'b01010010;
		sub_1_tx = 8'b01010010;
		sub_2_tx = 8'b01010010;
		sub_3_tx = 8'b01010010;
	end
	else begin
		case(state_tx)
			t0: begin
				led_tx_state = 4'b0000;
				if (tx_locked == 1) begin
					next_state_tx = t1;
					tx_in = 8'b00110101;

					EN_enq_tx = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end
				else begin
					next_state_tx = t0;
					tx_in = 8'b00000000;

					EN_enq_tx = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;					
				end
			end
			t1: begin
				led_tx_state = 4'b0001;
				if (tx_align_done) begin
					next_state_tx = t2;
					//tx_in = 8'b10100101;

					EN_enq_tx = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end 
				else begin
					next_state_tx = t1;
					tx_in = 8'b00110101;

					EN_enq_tx = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end
			end
			t2: begin
				next_state_tx = t3;
				led_tx_state = 4'b0010;
				tx_in = 8'b01110111;

				EN_enq_tx = 1'b0;
				sub_0_tx = 8'b01010010;
				sub_1_tx = 8'b01010010;
				sub_2_tx = 8'b01010010;
				sub_3_tx = 8'b01010010;
			end
			t3: begin
				if (RDY_enq_tx) begin
					EN_enq_tx = 1'b1;
					led_tx_state = 4'b1111;
					sub_0_tx = enq_tx [31:24];
					sub_1_tx = enq_tx [23:16];
					sub_2_tx = enq_tx [15:8];
					sub_3_tx = enq_tx [7:0];
					
					tx_in = sub_0_tx;
					next_state_tx = t4;
				end
				else begin
					EN_enq_tx = 1'b0;
					//led_tx_state = 4'b0100;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;

					tx_in = sub_0_tx;
					next_state_tx = t4;
				end
			end
			t4: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_1_tx;
				next_state_tx = t5;
			end
			t5: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_2_tx;
				next_state_tx = t6;
			end
			t6: begin
				EN_enq_tx = 1'b0;
				tx_in = sub_3_tx;
				next_state_tx = t3;
			end
		endcase
		// state_tx = next_state_tx;
	end
	
end

// initial	
// begin
// 	flag = 1'b1;
// end

always @(negedge rx_outclock) begin
	if (reset_n == 0) begin
		state_rx = t1;
	//	flag = ~flag;
	end
	else begin
		state_rx = next_state_rx;
	end
 end

always @(posedge rx_outclock) begin

	if (reset_n == 0) begin
		// state_rx = t1;
		next_state_rx = t1;
		align_done = 1'b0;
		rx_data_align = 1'b0;
		count = 3'b000;

		EN_deq_rx = 1'b0;
		sub_0_rx = 8'b00000000;
		sub_1_rx = 8'b00000000;
		sub_2_rx = 8'b00000000;
		sub_3_rx = 8'b00000000;
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
				led_rx_state = 4'b0001;
				//if (rx_out == 8'b01101010) begin
				if (rx_out == 8'b00110101) begin
					next_state_rx = t2;
					align_done = 1'b0;
					rx_data_align = 1'b0;
					count = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t1;
					align_done = 1'b0;
					rx_data_align = ~rx_data_align;
					count = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t2: begin
				led_rx_state = 4'b0010;
				if (count == 3'b101) begin
					next_state_rx = t3;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t2;
					align_done = 1'b0;
					rx_data_align = ~rx_data_align;
					count = count + 1'b1;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t3: begin
				led_rx_state = 4'b0011;
				if (rx_out == 8'b01110111 ) begin
					next_state_rx = t4;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t3;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					EN_deq_rx = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t4: begin
				sub_0_rx = rx_out;
				next_state_rx = t5;
				EN_deq_rx = 1'b0;
				
				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t5: begin
				sub_1_rx = rx_out;
				next_state_rx = t6;
				EN_deq_rx = 1'b0;
				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t6: begin
				sub_2_rx = rx_out;
				next_state_rx = t7;
				EN_deq_rx = 1'b0;

				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
			end
			t7: begin
				sub_3_rx = rx_out;
				next_state_rx = t4;
				deq_rx = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				if (deq_rx[31] == 1) begin
					if (RDY_deq_rx) begin
						led_rx_state = 4'b1111;
						EN_deq_rx = 1'b1;
					end
					else begin
						led_rx_state = 4'b0100;
						EN_deq_rx = 1'b0;
					end
				end
				else begin
					EN_deq_rx = 1'b0;
	//				led_rx_state = 4'b0111;
				end
			end
		endcase
	// state_rx = next_state_rx;
end
end



endmodule
