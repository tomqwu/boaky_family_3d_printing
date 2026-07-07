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

Full week-by-week mapping: [**LEARNING-PATH.md**](LEARNING-PATH.md).

| File | For | What it teaches |
|---|---|---|
| [`family/clearance-test.scad`](family/clearance-test.scad) | Everyone, week 1 | **Print this first.** Five hinge joints with different gaps — find the smallest clearance our H2C can print that still moves. That number unlocks every print-in-place design. |
| [`family/remix-pedestal.scad`](family/remix-pedestal.scad) | Everyone, week 2 | The remix move: `import()` any downloaded STL onto your own parametric base with your own title. |
| [`family/photo-lithophane.scad`](family/photo-lithophane.scad) | Everyone, week 4 | A photo becomes thickness: grayscale PNG → backlit panel. Comes with `make-test-image.py` so it works out of the box. |
| [`family/magnet-coaster.scad`](family/magnet-coaster.scad) | Everyone, week 6 | Pause-at-height embedding: sealed magnet pockets, with the pause height computed for you. Magnets = get Dad. |
| [`family/gift-box.scad`](family/gift-box.scad) | Everyone, any week | A sliding-lid gift box with their name on top — pairs with the [gift playbook](../program/09-gifts-and-occasions.md). |
| [`matt/name-keychain.scad`](matt/name-keychain.scad) | Matt, week 1 | Your first code-CAD: change one line, get your name in 3D. Variables, text, holes. |
| [`matt/spinning-top.scad`](matt/spinning-top.scad) | Matt, week 3 | Design for physics: low + wide spins better than tall + narrow. Iterate and race them. |
| [`matt/flexi-snake.scad`](matt/flexi-snake.scad) | Matt, week 3+ | A real print-in-place articulated flexi — the same joint trick as the flexi dragons you love, in ~130 lines you can read. |
| [`matt/squishy-ball.scad`](matt/squishy-ball.scad) | Matt, week 5 | TPU week: an airless-style squishy ball. Flexible filament rules included. |
| [`matt/gyro-fidget.scad`](matt/gyro-fidget.scad) | Matt, week 6 | A print-in-place gimbal: nested rings on pivot pins, two rotation axes. |
| [`matt/ball-joint-figure.scad`](matt/ball-joint-figure.scad) | Matt, week 6 | The action-figure joint: snap-together ball-and-socket arm kit — the gateway to designing your own figures. |
| [`matt/penalty-shootout.scad`](matt/penalty-shootout.scad) | Matt, weeks 7–8 | Capstone starter: goal + sliding keeper + flick ramp. Print it, play it, then redesign every part. |
| [`peter/parametric-building.scad`](peter/parametric-building.scad) | Peter, week 3 | One file = infinite buildings. Floors, windows, roof style — all parameters. This is what "parametric design" means. |
| [`peter/city-tile.scad`](peter/city-tile.scad) | Peter, week 7 | A modular street tile with building pads — design a district as a *system*, print tiles forever. |
| [`peter/zoning-district.scad`](peter/zoning-district.scad) | Peter, week 4 | A zoning map where every zone is a different height — Bambu Studio's height-range painting colors it in seconds. |
| [`peter/skyline-generator.scad`](peter/skyline-generator.scad) | Peter, week 8 | Procedural design: a seed-controlled random skyline. Change the seed, get a new city. |
| [`peter/osm-to-scad.py`](peter/osm-to-scad.py) | Peter + Dad, week 6 | Pull **real building footprints** from OpenStreetMap and turn any city block on Earth into a printable model. |
| [`peter/terrain-to-scad.py`](peter/terrain-to-scad.py) | Peter + Dad, week 6 | Real elevation data → printable mountains, valleys, coastlines (with vertical exaggeration, like real map makers). |
| [`peter/streets-to-scad.py`](peter/streets-to-scad.py) | Peter + Dad, week 6 | Your neighborhood's street network as a printable map tile — big roads print wider. |
| [`peter/MAP-TO-MODEL.md`](peter/MAP-TO-MODEL.md) | Peter, week 6 | **The map→print pipeline guide**: which script for buildings vs terrain vs streets, and how to combine layers. |

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
