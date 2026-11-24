## How it works

Micro tile test with 2 bidirectional pins (synthetic capacity design, 4 stages + 4 bits, with uio).

While `rst_n` is low it is a combinational loopback: `uo_out = {ui_in[7:2], uio_in} ^ 0xa5`,
`uio_oe = ui_in[1:0]`, `uio_out = ui_in[7:6] ^ 0xa5[7:6]`.

## How to test

Hold `rst_n` low, drive `ui_in` and `uio_in`, and compare the outputs with the formulas above.

## External hardware

None
