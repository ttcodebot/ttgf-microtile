/*
 * Copyright (c) 2026 Tiny Tapeout
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Adversarial micro tile for antenna checks (gf180mcuD): every output is driven by a weak
// inverter (clkinv_1, 0.748 um2 diffusion) at the far (west) end of the tile; every input
// drives exactly one gate there (clkinv_1 I for ui_in, dlya_1 I for clk and rst_n).
module tt_um_micro_adv_far (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire       clk,
    input  wire       rst_n
);

  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o0 (.I(ui_in[0]), .ZN(uo_out[0]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o1 (.I(ui_in[1]), .ZN(uo_out[1]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o2 (.I(ui_in[2]), .ZN(uo_out[2]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o3 (.I(ui_in[3]), .ZN(uo_out[3]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o4 (.I(ui_in[4]), .ZN(uo_out[4]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o5 (.I(ui_in[5]), .ZN(uo_out[5]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o6 (.I(ui_in[6]), .ZN(uo_out[6]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkinv_1 adv_o7 (.I(ui_in[7]), .ZN(uo_out[7]));
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i8 (.I(clk), .Z());
  (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlya_1 adv_i9 (.I(rst_n), .Z());

endmodule
