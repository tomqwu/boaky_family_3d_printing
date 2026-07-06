# H2C Mastery: Printer Skills Bootcamp & Techniques Ladder

Everything the family needs to go from "we can press print" to "we can make this printer do things almost no other printer can do."

Part of the [Boaky Family Summer 3D Printing Program](00-overview.md).

---

## 1. Meet your H2C

### What makes our printer special (the 60-second version)

Most multi-color printers have **one nozzle**. Every time they change color, they have to squeeze the old filament out of that nozzle before the new color prints clean — that squeezed-out plastic is "purge" (a.k.a. printer poop), and it wastes both filament and time.

Our **Bambu Lab H2C** cheats. Instead of purging, it **swaps the whole hotend**:

- On the right side of the build chamber there's a **garage of 6 hotends** (the **Vortek** system). Each garaged hotend keeps its own filament loaded, and each one has onboard memory that remembers which filament it last held.
- There's also **1 permanently mounted left nozzle**.
- 6 + 1 = **7 melt paths with almost no purging**. A color change means the toolhead grabs a different hotend instead of flushing plastic into a waste chute.
- Swapped hotends heat by **induction** (like an induction stove) and reach printing temperature in **about 8 seconds**.

How much does that actually matter? [Tom's Hardware tested it](https://www.tomshardware.com/3d-printing/bambu-lab-h2c-review) with a 5-color castle:

| | H2D (dual fixed nozzles + AMS purging) | Our H2C (Vortek) |
|---|---|---|
| Print time | ~23.5 hours | **11 h 13 m** |
| Waste | ~279 g of purge waste | **~43 g prime tower** |

That is roughly **2x faster** and about **58% less filament waste** than an AMS-purge workflow ([Makers101](https://makers101.com/bambu-lab-h2c-review-vortek-hotend-switching/), [Dreaming3D analysis](https://dreaming3d.net/blogs/news/the-bambu-lab-h2c-and-the-end-of-the-purge-tower)). Rule of thumb for our schedule: multi-color prints on our machine take much less extra time than online AMS estimates suggest. One honest caveat from Tom's: hotend swaps are still slower than a true toolchanger, and colors beyond 7 still purge — just far less than a single-nozzle machine.

Where the H2C sits in Bambu's H2 family: the H2S is the fast single-nozzle baseline, the H2D has 2 fixed nozzles, and the H2C is the **multi-color specialist** ([Fauxhammer three-way comparison](https://www.fauxhammer.com/reviews/bambu-h2s-vs-h2d-vs-h2c-review-why-spending-more-can-actually-get-you-less/)).

Read these two official pages early in Week 1 — they explain the machine we own:
- [Vortek workflow and function (Bambu Wiki)](https://wiki.bambulab.com/en/h2c/manual/Vortek-workflow-and-function)
- [H2C official product page](https://bambulab.com/en/h2c) and [tech specs](https://bambulab.com/en/h2c/specs)

### Spec table (the numbers that matter to us)

| Spec | Our H2C |
|---|---|
| Nozzles | 1 fixed left + Vortek right (6 garaged, induction-heated hotends) = 7 purge-free melt paths |
| Hotends in the box | 8 (4x 0.4 mm hardened, 1x 0.2 mm, 1x 0.6 mm for Vortek; 2x 0.4 mm for left) |
| Build volume | ~330 x 320 x 325 mm |
| Max nozzle temp | 350 C |
| Max bed temp | 120 C |
| Chamber | Actively heated to 65 C |
| Speed | Up to 1000 mm/s, 20,000 mm/s2 acceleration |
| Nozzle sizes | 0.2 / 0.4 / 0.6 / 0.8 mm |
| Filament units | AMS 2 Pro (4 slots, RFID recognition, dries filament to 65 C) |
| Max filaments in one print | Up to 24 (multiple AMS units; Bambu Studio projects allow up to 32 colors) |
| Materials | PLA, PETG, TPU, PVA/BVOH (soluble supports), ABS, ASA, PC, PA, plus CF/GF composites |

Sources: [Bambu US store](https://us.store.bambulab.com/products/h2c), [official specs](https://bambulab.com/en/h2c/specs), [AMS 2 Pro / AMS HT FAQ](https://wiki.bambulab.com/en/ams/manual/ams-2-pro-ams-ht-faq), [H2C Filament Printing Guide](https://wiki.bambulab.com/en/h2c/h2c-filament-printing-guide).

Safety notes that apply all summer: nozzles run up to 350 C and the bed to 120 C — hands out of the chamber while it moves. PLA and PETG are fine indoors; ABS/ASA need ventilation and Dad's sign-off. Dad approves anything unattended or overnight.

### Sensors and AI cameras (why we can trust long prints)

The H2C carries ~59 sensors and a computer-vision system ([GigaParts listing](https://www.gigaparts.com/bambu-lab-h2c-3d-printer.html), [Intelligent Detection wiki](https://wiki.bambulab.com/en/h2/manual/intelligent-detection)):

- **1080p chamber camera** — live view from anywhere via the [Bambu Handy app](https://bambulab.com/en-us/download/app), plus automatic timelapses.
- **1080p AI nozzle camera** (macro lens) — watches the plastic coming out of the nozzle to catch clogs and extrusion problems.
- **AI failure detection** — spaghetti failures, material buildup on the nozzle, filament deviations. It can pause the print and ping our phones.
- **Auto-calibration**: bed leveling, vibration compensation, fully automatic inductive nozzle-offset calibration (~25 micron accuracy), and per-print flow dynamics checks. Expect **~10 automated routines and 5–20 minutes between "press print" and first layer** — that's normal, not broken ([Makers101 H2C guide](https://makers101.com/bambu-lab-h2c/)).

What the printer does NOT auto-tune: per-filament **flow rate** and print temperature for third-party filaments. That's our job (Level 1, below).

### Print-time cheat sheet (for planning sessions)

Verified times for the kinds of prints this program uses, so we can slot them into Mon/Wed/Fri sessions vs overnights:

| Print | Time | Session slot |
|---|---|---|
| Benchy, 0.2 mm Standard | ~47–48 min | In-session, Day 1 |
| Benchy, speed profile ([MakerWorld profile](https://makerworld.com/en/models/40146-benchy-bambu-pla-basic)) | ~13–23 min | In-session comparison |
| Small multi-color keychain/fidget | ~30 min | In-session |
| Flexi/articulated animal, single color ([Floppy Dragon](https://makerworld.com/en/models/769341-floppy-dragon-flexi-articulated-monster-pip)) | ~4–5.5 h | Afternoon, between sessions |
| Same dragon, multi-color ([Articulated Dragon](https://makerworld.com/en/models/2250090-articulated-dragon)) | ~8 h | Overnight (Dad approves) |
| 4-color 17 cm figure ([Super Mario Multi-Color](https://makerworld.com/en/models/544831-super-mario-multi-color)) | ~10 h | Overnight / full day |
| HueForge painting | bookmark 1–2 h; wall art up to 6–12 h | Varies — thin prints are faster than they look |
| Big 5-color showpiece (Maker's Muse castle, Tom's Hardware test) | ~11 h | The ceiling for one overnight |

Planning rules: add 5–20 min of pre-print calibration to every job, keep daytime prints under ~5 h, and reserve 8–11 h multi-color prints for overnight or the Saturday big-build day.

---

## 2. Bambu Studio learning path (Weeks 1–4)

The concrete watch/read order. Everything else in the program builds on this.

### Week 1 — Bootcamp: slice, print, calibrate

| Order | Resource | Why |
|---|---|---|
| 1 | ["The ONLY Bambu Studio Tutorial You Need – Beginners Guide!" (YouTube, Aug 2025)](https://www.youtube.com/watch?v=Tc6xLuijLBg) | Watch together on Day 1. The freshest full walkthrough of setup, tools, and key features. |
| 2 | [Bambu Studio Quick Start Guide (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/studio-quick-start) | The canonical import → preset → slice → preview → send → bind-printer loop. Dad's Day 1 read. |
| 3 | [All3DP hands-on Bambu Studio tutorial (Apr 2025)](https://all3dp.com/2/bambu-studio-tutorial-beginner/) | Best written companion: orientation (Place on Face), auto/manual supports, and reading the Preview tab (time, filament, cost). |
| 4 | [H2C First Print Guide (official wiki)](https://wiki.bambulab.com/en/h2c/manual/first-print) | Our machine's setup checklist: induction hotends, plate alignment, transport screws. |
| 5 | [Flow Rate Calibration (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/calibration_flow_rate) | The one calibration the H2C does not automate per-filament. Day 2 hands-on: 9-block Pass 1, pick the smoothest top. |
| 6 | [First Layer Optimization Guide (H2C wiki)](https://wiki.bambulab.com/en/h2c/troubleshooting/first-layer-printing-optimization-guide) | Visual health check; also: never touch the plate with bare fingers. |

Backup/deeper Week 1 material: [official 15-episode "Get Started with Bambu Studio" video series](https://forum.bambulab.com/t/get-started-with-bambu-studio-video-series/93632) (playlist: [Bambu Studio Tutorials](https://www.youtube.com/playlist?list=PL8yhibMPQ_mQ8qeC6oF8CUEXJhWWp9cfC)) — drip one episode per session across Weeks 1–2; [Bambu Lab Academy](https://bambulab.com/en/support/academy); [StackSheriff first-print setup](https://stacksheriff.com/3d-printing/bambu-studio-tutorial/); alternative videos: [June 2025 beginner guide](https://www.youtube.com/watch?v=nkDGLR72Jbg), [Feb 2025 slicer basics](https://www.youtube.com/watch?v=f05hmVVJJ-E).

### Week 2 — Remix week: painting, per-object settings, split to parts

| Order | Resource | Why |
|---|---|---|
| 1 | [Color Painting Tool (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/color-painting-tool) | All six painting tools: Circle, Sphere, Triangle brush, Height Range, Fill, Gap Fill. |
| 2 | [Kevandram: Multicolor 3D Printing for Beginners (free course listing)](https://www.classcentral.com/course/youtube-multicolor-3d-printing-for-beginners-bambu-lab-p1s-blender-3d-free-project-file-465467) | Teaches Color Painting + Split to Parts + filament assignment — the exact bridge from plain slicing to multi-color remixing. |
| 3 | [Multi-Color Printing overview (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/multi-color-printing) | The big picture: add filaments → colorize → slice → print. |
| 4 | Friendly written walkthroughs: [MakerBuildIt painting guide](https://makerbuildit.com/blogs/3d-printing/mastering-multicolor-3d-printing-painting-in-bambu-studio), [Micro Center painting article](https://www.microcenter.com/site/mc-news/article/bambu-multicolor-printing.aspx), video: [How to Use Color Painting in Bambu Studio](https://www.youtube.com/watch?v=ZRj3iNGCClo) | Pick whichever format clicks for each kid. |

### Week 3 — Original design I: calibration literacy for our own models

| Order | Resource | Why |
|---|---|---|
| 1 | [Printer Calibration Guide (official wiki)](https://wiki.bambulab.com/en/general/printer-calibration) | What each calibration actually measures. |
| 2 | [StackSheriff Bambu Lab Calibration Guide](https://stacksheriff.com/3d-printing/bambu-lab-calibration-guide/) | Temperature towers and manual calibration menu — note: manual Calibration items may need Developer Mode enabled in Studio Preferences. |
| 3 | [Flow Dynamics Calibration (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/calibration_pa) | Know what the printer auto-runs before each print, and when to rerun it. |
| 4 | [StackSheriff Ultimate Guide: every feature, every setting](https://stacksheriff.com/3d-printing/bambu-studio-ultimate-guide/) | Reference for the settings our original designs will need (walls, infill, supports). |

### Week 4 — Multi-color mastery: the H2C-specific stuff

| Order | Resource | Why |
|---|---|---|
| 1 | [H2C Bambu Studio Operation Guide (official wiki)](https://wiki.bambulab.com/en/h2c/manual/bambu-studio-h2c-operation) | THE core H2C doc: automatic vs manual filament-to-hotend mapping, Standard vs Purge-Saving prime tower (fixed 15 mm3), Filament Track Switch. |
| 2 | [Filament Grouping Strategy for dual-nozzle printers (official wiki)](https://wiki.bambulab.com/en/software/bambu-studio/manual/dual-nozzles-slicing-filament-grouping) | Filament-Saving Mode — the single biggest waste-cutting skill on our machine. |
| 3 | [Bambu Studio 2.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-0-0) | Per-nozzle flush tables, 32-color projects, beam interlocking. |
| 4 | [Color Mixing / Full Spectrum Printing explainer (Smith3D)](https://www.smith3d.com/bambu-studios-new-color-mixing-feature/) | Studio blends 2–3 filaments into new colors — built for the H2 series. |
| 5 | [Bambu Studio 2.5.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-5-0) | Start AMS drying from Studio, support-interface ironing, TPU on the left extruder — sets up Week 5. |

---

## 3. Skills ladder

Five levels. Each level has specific skills, a named mini-project, and the program week where it lands. You can't skip levels — each one's certification (Section 4) unlocks the next.

### Level 1 — Slicer Pilot (Week 1)

**Skills**
- Import a raw STL/3MF, choose printer + filament presets, slice, read the Preview tab (time / filament / cost), send to printer.
- Explain what the H2C's automated pre-print routines do, and why "press print, wait 5–20 min" is normal.
- Run a manual Flow Rate Pass 1 (9 blocks) for a new filament and pick the winner.
- Layer-height tradeoffs: slice the same model at 0.28 draft / 0.20 standard / 0.12 fine and predict the time difference before slicing.

**Mini-project: "Three Benchys."** Download a plain [Original 3D Benchy](https://makerworld.com/en/models/1123776-original-3d-benchy) (not a pre-sliced profile), slice and print at standard (~47–48 min), then draft, and compare against the [~13-min speed-profile Benchy](https://makerworld.com/en/models/40146-benchy-bambu-pla-basic). Log estimated vs actual times.

**Tutorials:** Week 1 table above, especially the [Quick Start wiki](https://wiki.bambulab.com/en/software/bambu-studio/studio-quick-start) and [Flow Rate Calibration](https://wiki.bambulab.com/en/software/bambu-studio/calibration_flow_rate).

### Level 2 — Color Painter (Week 2)

**Skills**
- All six painting tools; Fill with edge detection for cartoon-style models; **Height Range** for stripes and floor-by-floor building colors ([Color Painting Tool wiki](https://wiki.bambulab.com/en/software/bambu-studio/color-painting-tool), [Height Range quirks thread](https://forum.bambulab.com/t/color-painting-tool-height-range/143221)).
- Per-object and per-part settings on a multi-object plate (different infill per object, supports on one object only).
- Paint-on **fuzzy skin** (Studio 2.2+): brush texture onto only part of a model ([Fuzzy Skin wiki](https://wiki.bambulab.com/en/software/bambu-studio/parameter/fuzzy-skin), [2.2.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-2-0), [video](https://www.youtube.com/watch?v=WqXcPIcTl10)).

**Mini-projects:**
- Matt: fill-paint a downloaded figure or a ~30-min multi-color keychain ([Simple Keychain Generator](https://makerworld.com/en/models/1134982-simple-keychain-generator-sample)).
- Peter: **"Repaint the City"** — Height Range gives a downloaded skyline glass-blue upper floors and stone-gray bases; Fill paints landmark buildings.
- Both: print the [Fuzzy Skin Sampler](https://makerworld.com/en/models/19582-bambu-studio-fuzzy-skin-sampler) and run a blind "which noise type feels best?" touch test.

### Level 3 — Purge Scientist (Week 4)

**Skills**
- Filament-to-hotend mapping: read the auto-grouping, then manually remap and watch predicted waste change ([H2C Operation Guide](https://wiki.bambulab.com/en/h2c/manual/bambu-studio-h2c-operation)).
- Slice-button grouping modes incl. **Filament-Saving Mode** ([Filament Grouping Strategy wiki](https://wiki.bambulab.com/en/software/bambu-studio/manual/dual-nozzles-slicing-filament-grouping)).
- Prime tower Standard vs **Purge-Saving Mode**; per-nozzle flush-volume tables ([2.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-0-0)).
- HueForge filament painting: TD values, color-swap layers, 0.08 mm layers over a 0.16 mm base ([Tom's Hardware HueForge how-to](https://www.tomshardware.com/how-to/hugeforge-paint-with-3d-printer), [Bambu HueForge guide](https://wiki.bambulab.com/en/filament-acc/filament/hueforge-printing-guide), [Kevandram video](https://www.youtube.com/watch?v=J3JE0DefxX4), [HuePick beginner guide](https://huepick.app/articles/hueforge-basics/hueforge-printing-for-beginners)).
- CMYK lithophanes: C/M/Y/W PLA recipe ([CMYK Lithophane Guide](https://wiki.bambulab.com/en/knowledge-sharing/CMYK-color-lithophane-printing-instructions), STL generator: [LithophaneMaker](https://lithophanemaker.com/Color%20Lithophane.html), walkthrough: [All3DP tutorial](https://all3dp.com/2/colorful-bambu-lab-lithophane-tutorial/)).

**Mini-projects:**
- Both: **"Purge-Waste Science Fair"** — re-slice a familiar 4–6 color model three ways (all colors forced to one nozzle / default grouping / Filament-Saving Mode), record predicted waste + time for each, print the winner, weigh the actual purge on the kitchen scale, chart the grams saved.
- Matt: print a downloaded [Super Mario HueForge](https://makerworld.com/en/models/530058-super-mario-hueforge-filament-painting) as profiled, then feed HueForge his own soccer-crest image.
- Peter: skyline-photo HueForge; family: a color lithophane night light in the [LED-backlit frame](https://makerworld.com/en/models/1036463-lithophane-frame-for-bambu-led-cmyk-b-w).

### Level 4 — Materials Engineer (Week 5)

**Skills**
- TPU handling: dry first (AMS HT 75 C for 18 h recommended), no 0.2 mm nozzles, glue the plate ([TPU prep guide](https://wiki.bambulab.com/en/h2/h2d-tpu-printing-guide)).
- Rigid + flexible in one print: TPU in the right hotend, **Beam Interlocking** to mechanically stitch TPU to PLA ([soft + hard multi-material guide](https://wiki.bambulab.com/en/h2/manual/soft-and-hard-filament-multi-material-printing-guide), [Beam Interlocking wiki](https://wiki.bambulab.com/en/software/bambu-studio/beam-interlocking)).
- The PLA/PETG trick: they don't bond, so each is a free support **interface** for the other ([forum troubleshooting](https://forum.bambulab.com/t/petg-doesnt-adhere-to-petg-causes-blobs/135907)); material-combo limits: [H2D/H2C multi-material guide](https://wiki.bambulab.com/en/filament-acc/filament/h2d-filament-config-limit).
- AMS 2 Pro drying schedules, RFID profiles, starting drying from Studio ([AMS 2 Pro drying guide](https://wiki.bambulab.com/en/ams-2-pro/manual/drying-function), [2.5.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-5-0)).

**Mini-projects:**
- Matt: PLA car or skateboard with TPU tires in one job, plus the [Multi-Material Fidget Cloth](https://makerworld.com/en/models/2378367-multi-material-fidget-cloth) or [Fidget Cubes](https://makerworld.com/en/models/2378728-multi-material-fidget-cubes).
- Peter: city block with a TPU "rubber" road surface or bendy pedestrian bridge.
- Science bit: print the [Beam Interlocking Benchmark](https://makerworld.com/en/models/1305491-beam-interlocking-benchmark-for-bambu-lab-h2d) with interlocking on vs off and try to pull each apart.

### Level 5 — Advanced Multi-Material Master (Weeks 6–8)

**Skills**
- **Pause-at-height embedding**: Preview → drag layer slider → right-click → Add Pause; pick the layer that closes over the cavity; check magnet polarity and keep strong magnets away from the steel nozzle ([FettesPS pause guide](https://www.fettesps.com/how-to-add-a-pause-when-printing-in-bambu-studio/), [McGybeer tutorial](https://www.mcgybeer.xyz/tutorials/print-pause)).
- **Dissolvable support interfaces**: PVA interface-only over PLA bulk supports (pair PVA with PLA, not PETG), warm-water dissolve ([PVA Printing Guide](https://wiki.bambulab.com/en/filament-acc/filament/pva-printing-guide), [Mecha's PVA guide for the H2D](https://forum.bambulab.com/t/guide-mechas-comprehensive-guide-to-pva-supports-for-the-h2d/183781)); BVOH as the faster-dissolving option ([BCN3D BVOH vs PVA](https://support.bcn3d.com/knowledge/bvoh-vs-pva)); breakaway alternative: [Support Filament Usage Guide](https://wiki.bambulab.com/en/filament/support).
- Support-interface ironing + interface temperature parameter ([2.5.0 release note](https://wiki.bambulab.com/en/software/bambu-studio/release/release-note-2-5-0)).
- Nozzle-size strategy: 0.2 mm for minifigures, 0.6/0.8 mm for big city tiles; multi-plate multi-day project management with Handy-app monitoring.

**Mini-projects:**
- Week 6, Matt: magnetic fidget with self-inserted 6x2 mm magnets — start from the [Magnetic Fidget Toy (ASMR)](https://makerworld.com/en/models/1055327-magnetic-fidget-toy-asmr) (pause already in the profile), then the [FlipDeck Duo fingerboard](https://makerworld.com/en/models/1218418-flipdeck-duo-magnetic-skateboard-fidget).
- Week 6, Peter: "time capsule" skyscraper — pause and seal a 2026 coin + note inside the core.
- Week 6, Matt: **"Impossible Overhang Trophy"** — print a wild-overhang soccer trophy twice, normal supports vs PVA interface, dissolve, compare surfaces. (Peter variant: glassy-smooth bridge underside.)
- Weeks 7–8 capstone element: the **"only our printer can do this" showcase piece** — PLA + TPU, 5+ colors, painted, fuzzy-skin accents, an embedded magnet, dissolvable interfaces under overhangs, sliced in Filament-Saving Mode. Every prior level contributes one element.

---

## 4. Certifications

Family "licenses." Dad is the examiner; passing means demonstrating every item unassisted while talking through what you're doing. Earned licenses get listed in the weekly [build log](07-build-log-template.md).

### Plate License (target: everyone, end of Week 1)
The license Matt wants most: holders may **start pre-approved prints solo**.
- [ ] Remove and reseat the build plate against the heatbed stoppers without touching the print surface with bare fingers
- [ ] Remove a finished print and clear the plate completely
- [ ] Start a Dad-pre-approved print from the printer screen or Handy app, and state the expected finish time
- [ ] Explain the hot-parts rule (nozzle to 350 C, bed to 120 C) and keep hands out of the chamber while the gantry moves
- [ ] Know the stop rule: if the AI camera flags a failure or something looks wrong, pause the print and get Dad — never grab at a running print
- [ ] Know what is NOT covered: no overnight/unattended starts, no new untested models, without Dad's sign-off

### Slicer License (target: everyone, end of Week 1)
- [ ] Import a raw STL, pick correct printer/filament presets, slice, and read out the Preview tab's time, filament grams, and cost
- [ ] Re-slice the same model at 0.28 / 0.20 / 0.12 mm and correctly predict which is fastest before slicing
- [ ] Set per-object settings on a multi-object plate (two different infills; supports on only one object)
- [ ] Run a Flow Rate Pass 1 for a filament and justify the block you picked
- [ ] Estimate-vs-actual: your last three prints logged, each estimate within a sensible margin

### AMS License (target: everyone, Week 4–5)
- [ ] Load and unload a spool in the AMS 2 Pro without kinking filament; explain what RFID auto-recognition sets up
- [ ] Check and report humidity/desiccant state; start a filament-drying run (from the unit or from Bambu Studio)
- [ ] Explain the filament-to-hotend grouping on a sliced multi-color print, and manually remap one filament
- [ ] Show, with slicer screenshots, how Filament-Saving Mode changed predicted waste on a real model
- [ ] Explain why TPU needs drying and special handling before it goes anywhere near the printer

### Painter License (target: both boys, end of Week 2, upgraded Week 4)
- [ ] Recolor a single-color downloaded model using Fill with edge detection
- [ ] Use Height Range to create clean color bands at chosen heights
- [ ] Fix a paint spill using Gap Fill or the Triangle brush
- [ ] Paint fuzzy skin onto only one region of a model
- [ ] Week 4 upgrade: slice your painted model with a purge-saving grouping and report grams saved vs default

### Multi-Material License (target: both boys, Weeks 5–6)
Required before running any solo TPU, PVA, or pause-at-height print.
- [ ] Set up a rigid + flexible print correctly: TPU assigned to the right hotend, Beam Interlocking enabled, plate glued
- [ ] Add a pause at the correct layer (the one that closes over the cavity), insert a magnet with polarity checked, and resume cleanly
- [ ] Configure PVA as interface-only over PLA bulk supports, and explain why PVA pairs with PLA but not PETG
- [ ] Explain the PLA/PETG no-bond trick and when to use it instead of soluble supports
- [ ] Know the "get Dad" cases: nozzle swaps, clogs, any repair with tools, and every overnight or unattended start

### Designer License (target: both boys, Weeks 3–6; required to publish in Week 8)
- [ ] Design an original model (Tinkercad or better) and print it successfully with no rescue edits from Dad
- [ ] Create one "picture to object" piece from your own image (HueForge painting or CMYK lithophane)
- [ ] Use one advanced mechanism deliberately: pause-at-height embed, TPU+PLA beam interlock, or a dissolvable/breakaway support interface — and explain why the print needed it
- [ ] Export a clean 3MF project (named plates, correct filaments) that someone else could print without asking you questions
- [ ] IP check: explain why we publish "inspired-by" original designs instead of copying Nintendo characters
- [ ] Present the piece at Sunday show-and-tell: what failed, what you changed, what you'd do next

License order: Plate and Slicer first (Week 1), Painter second, AMS before any solo multi-material print, Designer before Week 8 publishing to MakerWorld from Dad's account.
