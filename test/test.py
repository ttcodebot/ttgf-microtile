# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge


@cocotb.test()
async def test_micro(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # While in reset, the inputs are mirrored on the outputs
    dut._log.info("Test input mirror in reset")
    dut.ui_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    for x in range(256):
        dut.ui_in.value = x
        await ClockCycles(dut.clk, 1)
        await FallingEdge(dut.clk)
        assert dut.uo_out.value == x

    # Out of reset, the outputs show a counter
    dut._log.info("Test counter")
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    for x in range(256):
        await FallingEdge(dut.clk)
        assert dut.uo_out.value == x
        await ClockCycles(dut.clk, 1)
