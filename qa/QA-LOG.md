# Family Q&A Log

A running knowledge base of questions we asked and what we learned.
Newest entries at the top. Claude: append entries in this format.

---

<!-- Template:

## YYYY-MM-DD — Who asked — Short title

**Q:** The question, in one or two lines.

**A:** The useful part of the answer — the fix, the setting, the technique.

**Tags:** `troubleshooting` `tinkercad` `tpu` `multi-color` (etc.)

---
-->

## 2026-08-08 — Dad — Two-color cup: black body on right nozzle, red outer layer on left

**Q:** The cup should be pure black (right nozzle) with a red outer layer
(left nozzle) — how do I configure that?

**A:** (1) Prepare tab: Filament 1 = black, Filament 2 = red. (2) Select the
cup, press **N** for Color Painting, pick red, and Fill/Smart-Fill the whole
outside surface — painted surfaces get red walls, everything else stays
black. (3) On Slice, set **Filament Grouping = Custom** and assign black →
right nozzle, red → left nozzle. (4) Map AMS slots in the send dialog and
keep the prime tower on. Dual nozzles mean near-zero purge waste, but expect
a nozzle swap every layer (~30–50% longer print). Reminder: FDM prints
aren't food-safe — display/pencil cup only.

**Tags:** `multi-color` `dual-nozzle` `bambu-studio` `color-painting`

---
