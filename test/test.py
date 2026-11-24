# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

N = 2
K = 0x3c
MASK = (1 << N) - 1


DAY0 = True


def loopback(ui, uio):
    """uo_out, uio_oe, uio_out while rst_n is low"""
    if DAY0:
        return ui ^ K, 0, 0
    uo = (((ui >> N) << N) | (uio & MASK)) ^ K
    return uo & 0xFF, ui & MASK, ((ui >> (8 - N)) ^ (K >> (8 - N))) & MASK


@cocotb.test()
async def test_loopback(dut):
    """While in reset, every input reaches an output."""
    dut.clk.value = 0
    dut.rst_n.value = 0
    rng = random.Random(1)
    for _ in range(400):
        ui, uio = rng.randrange(256), rng.randrange(1 << N)
        dut.ui_in.value = ui
        dut.uio_in.value = uio
        await Timer(1, unit="us")
        uo, oe, out = loopback(ui, uio)
        assert dut.uo_out.value == uo
        assert dut.uio_oe.value == oe
        assert dut.uio_out.value == out
