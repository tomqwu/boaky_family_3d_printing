# Sample Projects — Design With Code 💻→🖨️

Starter **OpenSCAD** projects you can open, tweak, and print. OpenSCAD is CAD where
you *write code* and a 3D model appears — which means these files live happily in
git, and **you can ask Claude to change them for you** right in this repo.

Part of the [Boaky Family Summer 3D Printing Program](../program/00-overview.md).

## Setup (once, with Dad)

1. Download OpenSCAD (free): https://openscad.org/downloads.html
2. Open any `.scad` file from this folder.
3. `F5` = quick preview. `F6` = full render. Then **File → Export → STL**.
4. Open the STL in Bambu Studio, color-paint it if you want, slice, print.

## The projects

| File | For | What it teaches |
|---|---|---|
| [`family/clearance-test.scad`](family/clearance-test.scad) | Everyone, week 1–2 | **Print this first.** Five hinge joints with different gaps — find the smallest clearance our H2C can print that still moves. That number unlocks every print-in-place design. |
| [`matt/name-keychain.scad`](matt/name-keychain.scad) | Matt | Your first code-CAD: change one line, get your name in 3D. Variables, text, holes. |
| [`matt/spinning-top.scad`](matt/spinning-top.scad) | Matt | Design for physics: low + wide spins better than tall + narrow. Iterate and race them. |
| [`matt/flexi-snake.scad`](matt/flexi-snake.scad) | Matt | A real print-in-place articulated flexi — the same joint trick as the flexi dragons you love, in ~100 lines you can read. |
| [`peter/parametric-building.scad`](peter/parametric-building.scad) | Peter | One file = infinite buildings. Floors, windows, roof style — all parameters. This is what "parametric design" means. |
| [`peter/city-tile.scad`](peter/city-tile.scad) | Peter | A modular street tile with building pads — design a district as a *system*, print tiles forever. |
| [`peter/osm-to-scad.py`](peter/osm-to-scad.py) | Peter + Dad | Pull **real building footprints** from OpenStreetMap and turn any city block on Earth into a printable model. |

## How to ask Claude for changes

This is the superpower. Open a Claude session in this repo and say things like:

- *"I'm Matt — make the flexi snake 12 segments and give it a bigger head."*
- *"I'm Peter — add a setback roof style to parametric-building.scad, like a 1920s NYC tower."*
- *"Make me a keychain like name-keychain.scad but shaped like a shield."*
- *"The clearance test showed 0.3 mm works — set every project's default to that."*

Claude edits the code, you press `F6`, and if it looks right, print it.
New designs go in your own folder — commit them so we keep the whole summer's work.

## Rules of thumb for code-CAD

- **Change one number at a time**, re-preview, see what moved. That's how you learn.
- Flat side down: everything here is designed to print without supports.
- Print-in-place joints fuse if the first layer squishes — use the clearance-test
  result, and if a joint sticks, ask Claude to bump `clearance` by 0.05.
- Keep first prints small (15–20 min). Iterate cheap, print the big one last.
