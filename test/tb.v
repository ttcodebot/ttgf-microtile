`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a FST file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs. A micro tile only has clk, rst_n, ui_in and uo_out:
  reg clk;
  reg rst_n;
  reg [7:0] ui_in;
  wire [7:0] uo_out;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  tt_um_micro_test user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in (ui_in),   // Dedicated inputs
      .uo_out(uo_out),  // Dedicated outputs
      .clk   (clk),     // clock
      .rst_n (rst_n)    // not reset
  );

endmodule
