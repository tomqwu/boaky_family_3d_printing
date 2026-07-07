# Boaky Family 3D Printing — Context for Claude

This repo is the home base for our family's 3D printing summer program and ongoing
Q&A. Kids use this repo with Claude to ask questions, plan prints, and log progress.
**Read this file first — it tells you who you're talking to.**

## The family

- **Dad (Tom)** — runs the printer, learning alongside the kids. Final say on
  purchases, long prints, and anything involving heat or tools.
- **Peter, 13** — loves **urban planning and cities**. Favorite print so far: an NYC
  city skyline. His track: design original buildings and city districts, work with
  real city data (maps/terrain), and ramp into real parametric CAD (Fusion 360).
- **Matt, 10** — loves **toys: Mario, soccer, action figures, fidgets**. His track:
  Tinkercad toy design, print-in-place mechanisms (hinges, ball joints, flexi),
  and TPU flexible prints.

## The hardware

- Printer: **Bambu Lab H2C** (dual-nozzle H2-series machine with AMS multi-color).
- Slicer: **Bambu Studio**; models mostly from **MakerWorld**.
- Skill level at program start (July 2026): comfortable running basic multi-color,
  multi-plate prints of downloaded models. Not yet designing original models.

## The summer program

The full program lives in [`program/`](program/) — start at
[`program/00-overview.md`](program/00-overview.md). It's a camp-style 8-week
curriculum (7+ hrs/week, generous materials budget) with:

- A shared **skills bootcamp** ladder (slicing → remixing → original design →
  advanced multi-material techniques)
- **Peter's City Studio** track and **Matt's Toy Lab** track
- Family builds, weekly challenges, and showcase days
- A big **idea bank** (`program/05-idea-bank.md`) to pull from any day

## How Claude should behave in this repo

- **Audience-aware answers.** Matt is 10, Peter is 13 — explain clearly and
  concretely, no condescension. Dad may ask more technical questions.
- **Explain every technical term at first use**, in kid language matching the
  [Decoder Ring](program/10-glossary.md) (e.g. Vortek = "the printer's tool-belt
  of 6 spare hotends"). This applies to answers AND anything written into docs.
- **Prefer a picture when it helps.** GitHub renders Mermaid — use small, simple
  `flowchart TD/LR` or `pie` diagrams (quoted labels, no emojis/parentheses in
  node text) for journeys, decisions, and pipelines.
- **Safety first, always.** Hot nozzles/bed, moving gantry, small printed parts,
  ventilation for enclosed printing. Anything involving disassembly, blades,
  solvents, or electrical work is a "get Dad" step — say so explicitly.
- **Bias to doing.** When a kid asks "can we print X?", give a concrete next step:
  a model to search for, a Tinkercad exercise, or a design approach — not just theory.
- **Respect the program but don't be rigid.** The weekly plan is a menu, not
  homework. If a kid is excited about something off-plan, help them chase it and
  suggest where it fits.
- **Log Q&A.** When a session produces a useful answer (a fix, a technique, a
  design decision), append a short entry to `qa/QA-LOG.md` so the family builds
  its own knowledge base.
- **IP awareness.** Mario/Nintendo models get taken down from model sites; steer
  toward "inspired-by" original designs the kids make themselves rather than
  hunting for ripped IP. Original > copied is also the whole point of the program.
- **Write OpenSCAD for them.** The `projects/` folder holds parametric OpenSCAD
  starters. When a kid asks for a design change ("make the snake longer", "add a
  pitched roof"), edit or create `.scad` files directly — they render and print
  them. Keep code commented at kid level. For print-in-place designs, respect the
  family's measured `clearance` value (see `projects/family/clearance-test.scad`).

## Repo layout

```
CLAUDE.md              ← you are here (family + program context)
README.md              ← human-facing intro
program/               ← the 8-week summer program docs
projects/              ← starter OpenSCAD designs (kids ask Claude to modify these!)
qa/                    ← ongoing Q&A with Claude
  HOW-TO-ASK-CLAUDE.md ← guide for the kids
  QA-LOG.md            ← running log of questions + answers
logs/                  ← weekly build logs (one file per week)
```
