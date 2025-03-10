`timescale 1ns / 1ps

module uart_loopback
  (
   input	clk,
   output	UART_TX,
   input	UART_RX,
   output [6:0]	inv_leds,
   output [7:0]	enb_leds,
   output [1:0]	state_out
   );

   wire	      rx_dv;
   wire [7:0] tx_byte;
   wire [7:0] rx_byte;
   wire	      tx_done, tx_ready;
   wire	      tx_dv;

   wire [11:0] b_bcd;     // for the 7-segment display
   wire [2:0]  sel;       // for the 7-segment display
   wire [3:0]  bcd_digit; // for the 7-segment display
   
   uart_tx_vlog tx0 (clk, tx_dv, tx_byte, UART_TX, tx_done, tx_ready);

   uart_rx_vlog rx0 (clk, UART_RX, rx_dv, rx_byte);

   uart_loopback_fsm u_fsm (
			    // Outputs
			    .tx_byte		(tx_byte[7:0]),
			    .tx_dv		(tx_dv),
			    .state_out		(state_out),
			    // Inputs
			    .clk		(clk),
			    .rx_dv		(rx_dv),
			    .rx_byte		(rx_byte[7:0]),
			    .tx_ready		(tx_ready),
			    .tx_done		(tx_done));

   // ***** 
   // you need to add and wire up the modules to display tx_byte on the 7-segment display
   //
   // i.e. you will need doubdab_8bits, count_3bit_select, decode_enb_leds, mux_4in_8to1, and seven_seg_decoder
   // ***** 
   
endmodule

