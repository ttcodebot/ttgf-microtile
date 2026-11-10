#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""
Capacity sweep: summarizes a LibreLane run (runs/wokwi) as one JSON object.

Works for failed runs too: the metrics come from the last step that wrote any,
and the first error of the flow is reported.
"""

import glob
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
RUN = os.path.join(ROOT, "runs", "wokwi")

# Cell classes that are not part of the design itself
OVERHEAD = ["fill_cell", "tap_cell", "endcap_cell", "antenna_cell"]


def last_metrics():
    best = (None, {})
    for state in sorted(glob.glob(os.path.join(RUN, "*", "state_out.json"))):
        try:
            with open(state) as f:
                metrics = json.load(f).get("metrics", {})
        except (OSError, ValueError):
            continue
        if metrics:
            best = (os.path.basename(os.path.dirname(state)), metrics)
    return best


def first_error():
    path = os.path.join(RUN, "error.log")
    if not os.path.exists(path):
        return None
    with open(path) as f:
        text = f.read().strip()
    if not text:
        return None
    return re.sub(r"\s+", " ", text)[:400]


def main():
    result = {}
    point = os.path.join(ROOT, "sweep", "point.json")
    if os.path.exists(point):
        with open(point) as f:
            result.update(json.load(f))

    step, m = last_metrics()
    steps = sorted(
        os.path.basename(d) for d in glob.glob(os.path.join(RUN, "[0-9]*-*"))
    )
    result["last_step"] = steps[-1] if steps else None
    result["finished"] = os.path.exists(os.path.join(RUN, "final", "metrics.csv"))
    result["error"] = first_error()

    def count(cls):
        return int(m.get(f"design__instance__count__class:{cls}", 0))

    def area(cls):
        return float(m.get(f"design__instance__area__class:{cls}", 0))

    classes = sorted(
        k.split("class:")[1]
        for k in m
        if k.startswith("design__instance__count__class:")
    )
    design_classes = [c for c in classes if c not in OVERHEAD]
    core = float(m.get("design__core__area", 0))
    design_area = sum(area(c) for c in design_classes)
    result.update(
        {
            "cells": sum(count(c) for c in design_classes),
            "flops": count("sequential_cell"),
            "buffers": count("timing_repair_buffer") + count("clock_buffer"),
            "cell_area_um2": round(design_area, 1),
            "core_area_um2": round(core, 1),
            "utilization_pct": round(100 * design_area / core, 1) if core else None,
            "overhead_area_um2": round(
                sum(area(c) for c in OVERHEAD if c != "fill_cell"), 1
            ),
            "antenna_diodes": count("antenna_cell"),
            "route_drc_errors": m.get("route__drc_errors"),
            "magic_drc_errors": m.get("magic__drc_error__count"),
            "lvs_errors": m.get("design__lvs_error__count"),
            "antenna_violating_nets": m.get("antenna__violating__nets"),
            "setup_ws_ns": m.get("timing__setup__ws"),
            "hold_ws_ns": m.get("timing__hold__ws"),
            "max_slew_violations": m.get("design__max_slew_violation__count"),
            "wirelength_um": m.get("route__wirelength"),
        }
    )
    for key in ("setup_ws_ns", "hold_ws_ns"):
        if isinstance(result[key], (int, float)):
            result[key] = round(result[key], 2)
    result["clean"] = bool(
        result["finished"]
        and not result["error"]
        and result["route_drc_errors"] == 0
        and result["magic_drc_errors"] == 0
        and result["lvs_errors"] == 0
    )
    json.dump(result, sys.stdout)
    sys.stdout.write("\n")


if __name__ == "__main__":
    main()
