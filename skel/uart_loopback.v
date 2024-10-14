`timescale 1ns / 1ps

module uart_loopback
  (
   input	clk,
   output	UART_TX,
   input	UART_RX,
   output [1:0]	state_out
   );

   wire	      rx_dv;
   wire [7:0] tx_byte;
   wire [7:0] rx_byte;
   wire	      tx_done, tx_ready;
   wire	      tx_dv;
   
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
   
endmodule

