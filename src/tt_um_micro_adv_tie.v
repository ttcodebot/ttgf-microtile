/*
 * Copyright (c) 2026 Tiny Tapeout
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Adversarial micro tile for antenna checks (gf180mcuD): every output is tied to a constant
// by a tie cell (the cell with the least diffusion of the library) at the far (west) end of
// the tile; every input drives exactly one smallest gate (dlya_1 I, 0.396 um2), at
// increasing distances from the pins.
module tt_um_micro_adv_tie (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire       clk,
    input  wire       rst_n
);

  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tiel adv_t0 (.ZN(uo_out[0]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tieh adv_t1 (.Z(uo_out[1]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tiel adv_t2 (.ZN(uo_out[2]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tieh adv_t3 (.Z(uo_out[3]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tiel adv_t4 (.ZN(uo_out[4]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tieh adv_t5 (.Z(uo_out[5]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tiel adv_t6 (.ZN(uo_out[6]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__tieh adv_t7 (.Z(uo_out[7]));

  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i0 (.I(ui_in[0]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i1 (.I(ui_in[1]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i2 (.I(ui_in[2]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i3 (.I(ui_in[3]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i4 (.I(ui_in[4]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i5 (.I(ui_in[5]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i6 (.I(ui_in[6]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i7 (.I(ui_in[7]), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i8 (.I(clk), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i9 (.I(rst_n), .Z());

endmodule
