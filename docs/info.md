## How it works

Micro tile test with 6 bidirectional pins (day-0, uio not used, synthetic capacity design, 4 stages + 0 bits, with uio).

While `rst_n` is low it is a combinational loopback: `uo_out = ui_in ^ 0x69`, `uio_out` and `uio_oe` are 0.

## How to test

Hold `rst_n` low, drive `ui_in` and `uio_in`, and compare the outputs with the formulas above.

## External hardware

None
