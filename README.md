![](../../workflows/gds/badge.svg) ![](../../workflows/test/badge.svg)

# Micro tile test for GF180MCU (experimental)

A micro tile is a small hardened macro. Four micro tiles are placed inside an ordinary Tiny Tapeout 1x1 project
(the [container](https://github.com/ttcodebot/ttgf-microtile-container)), which selects one of them at a time.

This repository hardens the test design `tt_um_micro_test` (an 8-bit counter that mirrors its inputs while in reset)
as a micro tile for the `gf180mcuD` PDK.

| Property        | Value                                                                           |
| --------------- | ------------------------------------------------------------------------------- |
| Size            | 151.2 x 66.64 um (270 x 17 standard cell sites)                                 |
| Ports           | `clk`, `rst_n`, `ui_in[7:0]`, `uo_out[7:0]`                                     |
| Signal pins     | Metal3, east edge, 3.36 um pitch                                                |
| Routing layers  | Metal1 to Metal3 (Metal4 belongs to the container)                              |
| Standard cells  | 15 rows of 258 sites; 16 sites per row are blocked by the Metal2 power stripes  |
| Power, vertical | Metal2, two VPWR/VGND pairs, 1.6 um wide, connected to the Metal1 rails         |
| Power pins      | Metal3, two horizontal VPWR/VGND pairs, 1.6 um wide, across the whole core area |

The container runs its vertical Metal4 power stripes over the micro tile and connects them to the Metal3 stripes
where they cross.

The micro tile needs the `microtile-gf180` branch of [tt-support-tools](https://github.com/ttcodebot/tt-support-tools/tree/microtile-gf180),
which defines the tile size, the pin template and the power grid (`micro_librelane_config` in `tech.py`).
