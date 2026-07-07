# The Decoder Ring 🔍 — printer words, explained like a human

Every hobby has secret words. Here's what ours actually mean, no engineering
degree required. Part of the [program](00-overview.md).

## The printer's body parts

- **Nozzle** — the hot metal tip that melts plastic and draws with it, like a
  hot-glue gun with perfect aim. Ours gets to 350°C — three and a half times
  boiling water. That's why we don't touch it.
- **Hotend** — the nozzle plus its heater, as one swappable unit. Think
  "pen cartridge" for the printer.
- **Vortek** — our printer's signature trick: a tool-belt of **6 spare hotends**
  parked inside the machine. Instead of cleaning out one nozzle to change
  colors, it just grabs a different hotend — like a painter with 7 brushes,
  one per color, instead of rinsing one brush over and over. Swaps heat up in
  ~8 seconds.
- **Induction heating** — how those hotends warm up so fast: magnetic fields
  heat the metal directly, same magic as an induction stove.
- **Bed / plate** — the flat surface prints stick to while printing. It heats
  up to 120°C so plastic grips it, then lets go when it cools. Wait for the cool-down.
- **AMS** — the box that holds 4 spools of filament and feeds the printer
  whichever one it asks for. Basically a vending machine for plastic.
- **RFID** — the tiny tag in Bambu spools that tells the AMS what filament and
  color it is, like a name tag the printer can read.
- **Extruder** — the motorized wheels that push filament into the hotend, like
  the rollers that feed paper into a printer.
- **Gantry** — the moving frame that carries the nozzle around. It moves FAST.
  Hands out while it's alive.

## The plastics

- **Filament** — the plastic "ink," sold as a long noodle wound on a spool.
- **PLA** — the everyday plastic. Easy, safe, slightly brittle. 90% of what we print.
- **PETG** — the tough one. A bit stretchy-strong, good for hooks and parts
  that get abused. Water bottles are made of its cousin.
- **TPU** — the rubbery one. Bendy, bouncy, squishy. Special rule on our
  printer: it feeds from the back spool, not the AMS (it's too floppy for the
  vending machine).
- **ABS / ASA** — the smelly tough ones. They release fumes, so they're
  Dad-only-with-ventilation. We mostly don't need them.
- **PVA** — support plastic that **dissolves in water**. Print impossible
  overhangs, then melt the scaffolding away in a bucket. Witchcraft.
- **Wet filament** — filament that has soaked up moisture from the air like a
  sponge. Makes prints crackle, string, and look fuzzy. Fix: dry it (our AMS
  can heat-dry spools).

## Slicing words (the software side)

- **Slicer** — the app (Bambu Studio) that chops a 3D model into thousands of
  flat layers and writes the printer's instructions. Like turning a loaf of
  bread back into a recipe.
- **Layer height** — how thick each printed layer is. Thin = smooth + slow,
  thick = ridged + fast. 0.2mm is normal.
- **Infill** — the hidden lattice inside a print. Prints aren't solid — they're
  mostly a honeycomb skeleton wearing a plastic skin. More infill = heavier + stronger.
- **Supports** — temporary scaffolding the slicer adds under floating parts,
  which you snap off after. Ugly but necessary sometimes.
- **Overhang** — any part of a print that leans out over air. Up to ~45° prints
  fine; steeper needs supports. Plastic can't be printed on nothing.
- **Bridging** — printing a straight line across open air between two anchors,
  like a tightrope. Short bridges work; long ones sag.
- **Brim / raft** — extra flat plastic around a print's base so it grips the
  plate better. A brim is a sun-hat rim; a raft is a whole boat.
- **Seam** — the faint vertical line where each layer starts and stops. On gifts,
  we hide it on the back.
- **Purge / flush** — wasted plastic squeezed out when switching colors, so the
  old color doesn't smear into the new one. Our Vortek printer barely needs it —
  that's the whole point of the 7 hotends.
- **Prime tower** — a sacrificial block printed beside your model where the
  printer wipes in the new color. Purge's ugly cousin.
- **Fuzzy skin** — a slicer setting that makes surfaces intentionally rough and
  grippy, like spray-on texture. Free coolness, zero design work.
- **Pause at height** — telling the printer "stop at layer X," so you can drop
  in magnets or a coin, then it seals them inside forever. (Get Dad.)

## Design words

- **CAD** — Computer-Aided Design: any app for building 3D shapes. Tinkercad
  and OpenSCAD are CAD.
- **STL / 3MF** — the file formats models come in. STL = just the shape;
  3MF = the shape plus colors and settings. Both open in Bambu Studio.
- **Parametric** — a design controlled by numbers you can change. Edit
  `floors = 10` to `floors = 40` and the whole building rebuilds itself.
  The design is a *recipe*, not a sculpture.
- **Procedural / generative** — the computer generates the design from rules +
  randomness. Our skyline-generator invents a whole city from one number.
- **Seed** — the starting number for "random." Same seed = the exact same
  "random" city every time. Share the seed, share the city.
- **Clearance / tolerance** — the tiny air gap between parts that must move
  against each other. Too small: parts fuse into one lump. Too big: sloppy
  rattle. Ours is ~0.3mm — we measured it with the clearance test.
- **Print-in-place** — a design that comes off the printer already assembled
  and moving — hinges, joints and all. No screws, no glue. The clearance gap
  is what makes it possible.
- **Snap-fit** — parts that click together and hold, like LEGO. The "click" is
  plastic flexing past a bump.
- **Ball joint** — a ball trapped in a cup that can swivel every direction.
  It's how action figures pose and how your shoulder works.
- **Ballast** — hidden weight low in an object so it doesn't tip over. Why
  Subbuteo figures have metal washers in their bases.
- **Scale (1:1000)** — how shrunk a model is. At 1:1000, one meter of real
  building becomes one millimeter of print. A 300m skyscraper = 30cm model.

## Fancy technique words

- **Lithophane** — a photo turned into thickness: thin spots glow bright,
  thick spots stay dark. Looks like nothing until you put light behind it —
  then it's a picture. Old porcelain trick, new printer.
- **HueForge** — painting with filament layers: a few colors stacked super
  thin blend into a full picture, like looking through stacked stained glass.
- **CMYK** — Cyan, Magenta, Yellow + white ("K" usually means black in
  printing). Four filaments that mix into almost any color, exactly like an
  inkjet printer's cartridges.
- **Kinetic** — a print that moves as its whole point: spinners, morphing
  balls, fidgets.

## Map words (Peter's department)

- **OSM / OpenStreetMap** — the free world map anyone can edit, like Wikipedia
  for maps. Our scripts pull real buildings, streets, and land from it.
- **Bounding box (bbox)** — four numbers that fence off a rectangle of the
  Earth: south, west, north, east. "Print everything inside this fence."
- **API** — a way for a program to ask a website for data directly, no
  clicking. Our scripts use APIs to ask "what buildings are here?"
- **Vertical exaggeration** — stretching a terrain model's height so hills
  actually look like hills. Real mapmakers do it too — the Earth is flatter
  than you think.
- **Zoning** — a city's rulebook for what can be built where: homes here,
  shops there, factories way over there. The reason NYC towers have those
  wedding-cake steps (the 1916 rules!).

## Trouble words

- **First layer** — layer #1, squished onto the plate. If it goes down clean,
  the print almost always survives. Most failures die here.
- **Stringing** — thin cobwebs between parts of a print, from plastic oozing
  during moves. Usually means wet filament or too-hot nozzle.
- **Spaghetti** — what a detached print turns into: the nozzle keeps squirting
  plastic into open air and makes a noodle pile. Our printer's camera watches
  for it (that's what "AI detection" is looking at).
- **Layer shift** — the print suddenly steps sideways mid-way, like a wedding
  cake someone bumped. Usually something knocked or blocked the gantry.
- **Warping** — corners curling up off the plate as plastic cools and shrinks.
- **Elephant's foot** — the first layers bulging out wider than the rest, like
  the print is standing in soft mud. A slightly-too-close first layer.
- **HMS code** — the printer's error codes (like "HMS 0300-..."). Copy the code
  into the Bambu wiki or ask Claude — every code has a meaning and a fix.
- **VOC / ventilation** — fumes some plastics give off when hot. PLA and PETG
  are basically fine; ABS/ASA need real airflow and Dad.

## Community words

- **MakerWorld / Printables** — the big free model-sharing sites (MakerWorld is
  Bambu's; Printables is Prusa's). Download, print, and someday upload.
- **Boost / points / Prusameters** — the sites' reward systems: people who like
  your model send points; enough points = gift cards or free filament.
- **CC-BY (license)** — "use and remix this freely, just credit the creator."
  The best license to learn from.
- **IP (intellectual property)** — ownership of characters and designs. Mario
  belongs to Nintendo — that's why Mario models vanish from model sites, and
  why designing your own original character is the pro move.
- **Remix** — taking someone's model (where the license allows) and making it
  your own. Downloading is level 1; remixing is level 2; designing is level 3.
