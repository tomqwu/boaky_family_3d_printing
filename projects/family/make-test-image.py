#!/usr/bin/env python3
# ============================================================
# MAKE TEST IMAGE — creates test-photo.png for the lithophane
# ============================================================
# Run me once:   python3 make-test-image.py
# I write a small 120x90 grayscale PNG (a glowing gradient with
# a dark moon, a bright window and a stripe) so that
# photo-lithophane.scad renders out of the box — no photo needed.
#
# Fun fact: this script builds the PNG file BYTE BY BYTE using
# only Python's standard library. A PNG is just a signature plus
# "chunks" (header, compressed pixels, end marker), each with a
# checksum. No image library required!
# ============================================================

import math
import os
import struct
import zlib

W, H = 120, 90          # small on purpose — lithophanes like ~200px or less

# ---- step 1: invent the picture, one gray pixel at a time ----
# 0 = black (will print THICK), 255 = white (will print THIN)
cx, cy = W / 2, H / 2
max_d = math.hypot(cx, cy)

rows = []
for y in range(H):
    row = bytearray([0])                    # each PNG row starts with a
    for x in range(W):                      # "filter byte" (0 = plain)
        # a soft radial glow: bright in the middle, dark at the edges
        d = math.hypot(x - cx, y - cy) / max_d
        v = 235 - 175 * d
        # a dark "moon" circle, upper left
        if math.hypot(x - 34, y - 28) < 12:
            v = 12
        # a bright "window" square, lower right
        if 76 <= x < 100 and 54 <= y < 74:
            v = 254
        # one dark diagonal stripe, for checking fine detail
        if abs(x - y - 30) < 2:
            v = min(v, 60)
        # full range matters: a lithophane wants true darks AND
        # true brights (that's why step 2 says "auto contrast")
        row.append(max(4, min(254, int(v))))
    rows.append(bytes(row))
raw = b"".join(rows)

# ---- step 2: wrap the pixels in real PNG chunks ----
def chunk(tag, data):
    # every chunk = length + tag + data + CRC checksum of (tag + data)
    return (struct.pack(">I", len(data)) + tag + data
            + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))

png = b"\x89PNG\r\n\x1a\n"                                  # magic signature
png += chunk(b"IHDR", struct.pack(">IIBBBBB", W, H, 8, 0, 0, 0, 0))
#                       width, height, 8-bit, grayscale ------^
png += chunk(b"IDAT", zlib.compress(raw, 9))                # the pixels
png += chunk(b"IEND", b"")                                  # the end

out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "test-photo.png")
with open(out, "wb") as f:
    f.write(png)
print("wrote", out, f"({W}x{H} grayscale, {len(png)} bytes)")
