## How it works

Micro tile test with 4 bidirectional pins (counter with uio).

While `rst_n` is low it is a combinational loopback: `uo_out = {ui_in[7:4], uio_in} ^ 0x00`,
`uio_oe = ui_in[3:0]`, `uio_out = ui_in[7:4] ^ 0x00[7:4]`.

## How to test

Hold `rst_n` low, drive `ui_in` and `uio_in`, and compare the outputs with the formulas above.

## External hardware

None
