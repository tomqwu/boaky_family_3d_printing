// ============================================================
// REMIX PEDESTAL — put ANY downloaded model on your own base
// ============================================================
// This is what REMIXING is: you download a model from
// MakerWorld, then ADD YOUR OWN PART to it — and now it's a
// new thing that's yours. Here the part you add is a museum
// display pedestal with your own title on the front.
//
// HOW TO REMIX (3 steps):
//   1. Download any model as an .stl file and save it in this
//      folder (File > Export as STL from Bambu Studio works).
//   2. Change `stl_file` below to its filename, and flip
//      `show_model = true`.
//   3. Render! Scale/nudge the model with model_scale until it
//      sits nicely on the platform, then print the whole thing.
//
// Print: flat on the plate, no supports (the pedestal only ever
// gets SMALLER going up — printers love that). ~1-2 hrs in PLA.
// Color-paint the raised title letters in Bambu Studio!
// ============================================================

// ------------ CHANGE THESE ------------
stl_file    = "downloaded-model.stl"; // your downloaded model (same folder)
show_model  = false;   // true = show your model on top (step 2 above!)
model_scale = 1.0;     // shrink (0.5) or grow (2) the model to fit
style       = "round"; // "round" or "square" pedestal
top_w       = 55;      // size of the top platform (mm) — measure your model!
ped_h       = 22;      // total pedestal height (mm)
title       = "MY FIRST REMIX";  // goes on the front plaque
text_size   = 5;       // make smaller if your title is long
// ---------------------------------------

base_w   = top_w + 16;   // the bottom slab is a bit wider
base_h   = 4;            // bottom slab height
cap_h    = 3;            // top platform height
body_w   = top_w + 8;    // the sloped middle starts this wide
body_h   = ped_h - base_h - cap_h;

$fn = 96;

// ============ one pedestal layer, round OR square ============
// w1 = size at the bottom, w2 = size at the top, h = height.
// Same module draws both styles — that's the parametric trick.
module tier(w1, w2, h) {
    if (style == "round")
        cylinder(h = h, d1 = w1, d2 = w2);
    else
        linear_extrude(h, scale = w2 / w1)   // a cube that tapers
            square(w1, center = true);
}

// ============ the pedestal: base + sloped body + platform ============
tier(base_w, base_w, base_h);                       // bottom slab
translate([0, 0, base_h])
    tier(body_w, top_w, body_h);                    // sloped middle
translate([0, 0, base_h + body_h])
    tier(top_w + 4, top_w + 4, cap_h);              // top platform

// ============ the title plaque on the front ============
plaque_w = base_w * 0.8;
translate([-plaque_w/2, -(base_w/2 + 2.5), 0])      // buried into the base
    cube([plaque_w, 6, 10]);                        // so it's welded on
translate([0, -(base_w/2 + 2.5), 5])                // raised letters, 0.6 mm
    rotate([90, 0, 0])                              // stand text upright
        linear_extrude(0.6)
            text(title, size = text_size,
                 font = "Liberation Sans:style=Bold",
                 halign = "center", valign = "center");

// ============ THE REMIX PART: your downloaded model ============
// import() drops a ready-made STL straight into this design.
// It stays OFF (show_model = false) until you've saved a real
// file — otherwise OpenSCAD complains it can't find the STL.
// The model lands centered on the platform IF the STL was
// centered when exported; use translate() here to nudge it.
if (show_model)
    translate([0, 0, ped_h])                        // on the platform
        scale([model_scale, model_scale, model_scale])
            import(stl_file, convexity = 10);

// IDEAS TO TRY (or ask Claude):
//  - a rotating pedestal: split it and reuse the flexi-snake
//    pin + ring joint so the top platform spins
//  - Peter: a pedestal shaped like a zoning-setback skyscraper
//  - Matt: a trophy version — taller, gold PLA, "CHAMPION 2026"
//  - a whole museum shelf: for-loop of pedestals, different heights
