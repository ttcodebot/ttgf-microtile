/*
 * tt_um_mgf_r0_d0b: micro tile without uio pins (baseline) (day-0, uio not used, counter with uio).
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mgf_r0_d0b (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // While in reset: a combinational loopback through every pin
  localparam [7:0] K = 8'h5a;
  wire [7:0] lb_uo = ui_in ^ K;

  reg rst_n_i;
  reg [7:0] cnt;

  always @(posedge clk or negedge rst_n)
    if (~rst_n) rst_n_i <= 1'b0;
    else rst_n_i <= 1'b1;

  always @(posedge clk or negedge rst_n_i)
    if (~rst_n_i) cnt <= 0;
    else cnt <= cnt + 1;

  assign uo_out  = rst_n ? cnt ^ K : lb_uo;

  // Day-0 micro tile: uio not used

endmodule
