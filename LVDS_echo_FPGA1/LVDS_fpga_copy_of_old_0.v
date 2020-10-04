`timescale 1 ps / 1ps

module LVDS_fpga_old(
	input 	 		reset_n,
	input 			tx_inclock,
	output 	[1:0]	tx_out,
	output			tx_outclock,
	input			tx_align_done,
	input	[1:0] 	rx_in,
	input			rx_inclock,
	output			rx_align_done,
	output 	[7:0]	led_out,

	input 	[31:0] 	enq_tx_put,
	input 			EN_enq_tx_put,
	output 			RDY_enq_tx_put,

	output 	[31:0] 	deq_rx_get,
	input 			EN_deq_rx_get
	//output 			RDY_deq_rx_get
	

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

	wire pll_areset,rx_outclock,rx_locked,tx_locked;
	reg rx_data_align;
	reg [7:0] tx_in;
	reg align_done;
	wire [7:0] rx_out;
	reg [2:0] count;

	//FIFO_TX

	
	reg [7:0] sub_0_tx;
	reg [7:0] sub_1_tx;
	reg [7:0] sub_2_tx;
	reg [7:0] sub_3_tx;

	//FIFO_RX

	
	reg [7:0] sub_0_rx;
	reg [7:0] sub_1_rx;
	reg [7:0] sub_2_rx;
	reg [7:0] sub_3_rx;

    assign led_out = deq_rx_get[7:0];

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


assign pll_areset = ~reset_n;

assign rx_align_done = align_done;

always @(negedge tx_inclock) begin
	if (pll_areset) begin
		state_tx = t0;
	end
	else  begin
		state_tx = next_state_tx;
	end
end


always @(posedge tx_inclock) 
begin: TX_FSM
	if(pll_areset) begin
		next_state_tx = t0;
		tx_in = 8'b00000000;
		RDY_enq_tx_put = 1'b0;
		sub_0_tx = 8'b01010010;
		sub_1_tx = 8'b01010010;
		sub_2_tx = 8'b01010010;
		sub_3_tx = 8'b01010010;
	end
	else begin
		case(state_tx)
			t0: begin
				if (tx_locked == 1) begin
					next_state_tx = t1;
					tx_in = 8'b01101010;

					RDY_enq_tx_put = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end
				else begin
					next_state_tx = t0;
					tx_in = 8'b00000000;

					RDY_enq_tx_put = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;					
				end
			end
			t1: begin
				if (tx_align_done) begin
					next_state_tx = t2;
					tx_in = 8'b10100101;

					RDY_enq_tx_put = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end 
				else begin
					next_state_tx = t1;
					tx_in = 8'b00110101;

					RDY_enq_tx_put = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;
				end
			end
			t2: begin
				next_state_tx = t3;
				tx_in = 8'b01110111;

				RDY_enq_tx_put = 1'b0;
				sub_0_tx = 8'b01010010;
				sub_1_tx = 8'b01010010;
				sub_2_tx = 8'b01010010;
				sub_3_tx = 8'b01010010;
			end
			t3: begin
				RDY_enq_tx_put = 1'b1;
				if (EN_enq_tx_put) begin
					sub_0_tx = enq_tx_put [31:24];
					sub_1_tx = enq_tx_put [23:16];
					sub_2_tx = enq_tx_put [15:8];
					sub_3_tx = enq_tx_put [7:0];
					// RDY_enq_tx_put = 1'b0;					
					tx_in = sub_0_tx;
					next_state_tx = t4;
				end
				else begin
					// RDY_enq_tx_put = 1'b0;
					sub_0_tx = 8'b01010010;
					sub_1_tx = 8'b01010010;
					sub_2_tx = 8'b01010010;
					sub_3_tx = 8'b01010010;

					tx_in = sub_0_tx;
					next_state_tx = t4;
				end
			end
			t4: begin
				RDY_enq_tx_put = 1'b0;
				tx_in = sub_1_tx;
				next_state_tx = t5;
			end
			t5: begin
				RDY_enq_tx_put = 1'b0;
				tx_in = sub_2_tx;
				next_state_tx = t6;
			end
			t6: begin
				// RDY_enq_tx_put = 1'b0;
				tx_in = sub_3_tx;
				next_state_tx = t3;
			end
		endcase
	end
	
end

always @(negedge rx_inclock) begin
	if (pll_areset) begin
		state_rx = t0;
	end
	else begin
		state_rx = next_state_rx;
	end
end

always @(posedge rx_inclock) begin
	if (pll_areset) begin
		next_state_rx = t0;
		align_done = 1'b0;
		rx_data_align = 1'b1;
		count = 3'b000;

		// RDY_deq_rx_get = 1'b0;
		sub_0_rx = 8'b00000000;
		sub_1_rx = 8'b00000000;
		sub_2_rx = 8'b00000000;
		sub_3_rx = 8'b00000000;
		deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
	end
	else begin
		case(state_rx)
			t0: begin
				if (rx_locked) begin
					next_state_rx = t1;
					align_done = 1'b0;
					rx_data_align = 1'b1;
					count = 3'b000;

					// RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t0;
					align_done = 1'b0;
					rx_data_align = 1'b1;
					count = 3'b000;

					// RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t1: begin
				if (rx_out == 8'b01101010) begin
					next_state_rx = t2;
					align_done = 1'b0;
					rx_data_align = 1'b0;
					count = 3'b000;

					// RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t1;
					align_done = 1'b0;
					rx_data_align = ~rx_data_align;
					count = 3'b000;

					// RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t2: begin
				if (count == 3'b111) begin
					next_state_rx = t3;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					//RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t2;
					align_done = 1'b0;
					rx_data_align = ~rx_data_align;
					count = count + 1'b1;

					//RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t3: begin
				if (rx_out == 8'b01110111 ) begin
					next_state_rx = t4;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					//RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
				else begin
					next_state_rx = t3;
					align_done = 1'b1;
					rx_data_align = 1'b0;
					count = 3'b000;

					//RDY_deq_rx_get = 1'b0;
					sub_0_rx = 8'b00000000;
					sub_1_rx = 8'b00000000;
					sub_2_rx = 8'b00000000;
					sub_3_rx = 8'b00000000;
					deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
				end
			end
			t4: begin
				sub_0_rx = rx_out;
				next_state_rx = t5;
				//RDY_deq_rx_get = 1'b0;
				
				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
				deq_rx_get = 32'h000000000;
			end
			t5: begin
				sub_1_rx = rx_out;
				next_state_rx = t6;
				//RDY_deq_rx_get = 1'b0;
				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
				deq_rx_get = 32'h000000000;
			end
			t6: begin
				sub_2_rx = rx_out;
				next_state_rx = t7;
				//RDY_deq_rx_get = 1'b0;

				align_done = 1'b1;
				rx_data_align = 1'b0;
				count = 3'b000;
				deq_rx_get = 32'h000000000;
			end
			t7: begin
				sub_3_rx = rx_out;
				next_state_rx = t4;
				deq_rx_get = {sub_0_rx,sub_1_rx,sub_2_rx,sub_3_rx};
			end
		endcase
	end
end


endmodule
