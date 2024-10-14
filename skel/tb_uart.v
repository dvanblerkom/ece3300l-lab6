`timescale 1ns / 1ps

module tb_uart;
    // Signal declaration
   reg clk;
   reg tx_start;
   reg [7:0] tx_data1;
   wire [7:0] rx_data1;
   wire	       tx_done1;
   wire	       tx_ready1;
   wire	       UART_RX, UART_TX;
   wire	       rx_dv1;
   reg [7:0]   testdata;
   wire [1:0]  state_out;
 
    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10 ns

    // Testbench UART instances
    uart_tx_vlog uart_tx_tb (
        .i_Clock(clk),
        .i_Tx_DV(tx_start),
        .i_Tx_Byte(tx_data1),
        .o_Tx_Serial(UART_RX),
        .o_Tx_Done(tx_done1),
        .o_Tx_Ready(tx_ready1) 
    );

    uart_rx_vlog uart_rx_tb (
        .i_Clock(clk),
        .i_Rx_Serial(UART_TX), 
        .o_Rx_Byte(rx_data1),
        .o_Rx_DV(rx_dv1)
    );

   uart_loopback dut0 (
		       // Outputs
		       .UART_TX		(UART_TX),
		       .state_out	(state_out[1:0]),
		       // Inputs
		       .clk		(clk),
		       .UART_RX		(UART_RX));
   


    initial begin
       clk = 0;
       tx_start = 0;

       for (testdata = 0; testdata <= 127; testdata = testdata + 1) begin
          #20;
	  tx_data1 = testdata[7:0]; 
          #20;
	  
          tx_start = 1; 
          #10 tx_start = 0;
	  $display("SENT: 'h%x", tx_data1);
          #100;
	  
          wait (rx_dv1);
	  $display("RECEIVED: 'h%x", rx_data1);
          #200;
       end 
       
    end

//    initial begin
//       $dumpfile("tb_uart.vcd");
//       $dumpvars(0,tb_uart);
//    end

endmodule
