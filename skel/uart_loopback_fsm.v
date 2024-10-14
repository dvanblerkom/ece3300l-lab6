`timescale 1ns / 1ps

module uart_loopback_fsm
  (
   input	clk,
   input	rx_dv,
   input [7:0]	rx_byte,
   input	tx_ready,
   input	tx_done,
   output [7:0]	tx_byte,
   output	tx_dv,
   output [1:0]	state_out
   );

   localparam	IDLE = 0;
   localparam	RECEIVED = 1;
   localparam	SEND = 2;
   localparam	WAITDONE = 3;

   reg [1:0]	state = IDLE;
   reg [1:0]	next_state;
   reg [7:0]	save_byte = 8'h00;

   assign tx_byte = save_byte;
   assign state_out = state;

   always @(posedge clk) begin
      state <= next_state;
   end

   // grab and store the receiver data when rx_dv is high
   always @(posedge clk) begin
      if (rx_dv)
	save_byte <= rx_byte;
   end
      
   always @(*) begin
//
// write the logic to determine the next state from the current state
//    
   end
     
//
// also, write an assign expression to create the output tx_dv from the current state
//    
   
endmodule



