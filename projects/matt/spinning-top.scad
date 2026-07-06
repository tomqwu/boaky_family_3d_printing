// ============================================================
// SPINNING TOP — design for physics
// ============================================================
// The rule: weight LOW and WIDE spins long. Tall and skinny
// wobbles and dies. Change the numbers, print two, race them.
//
// Print: in Bambu Studio hit "Auto Orient" and turn on
// tree supports (the tip needs a little help). ~25 min.
// ============================================================

// ------------ CHANGE THESE ------------
disc_diameter = 45;   // wider = more stable (to a point...)
disc_height   = 6;    // thicker disc = more spinning mass
tip_height    = 8;    // the cone it spins on
stem_height   = 22;   // the part you grab and twist
stem_diameter = 8;
grip_bumps    = 6;    // ridges on the stem so fingers grip
// ---------------------------------------

$fn = 96;

// ---- tip: the point it spins on (bottom, z = 0) ----
cylinder(h = tip_height, r1 = 0.8, r2 = disc_diameter/6);

// ---- disc: the flywheel, where the mass lives ----
// Tapers outward as it rises: keeps the mass LOW.
translate([0, 0, tip_height])
    cylinder(h = disc_height,
             r1 = disc_diameter/6 + 2,
             r2 = disc_diameter/2);

// ---- stem: what you twist ----
translate([0, 0, tip_height + disc_height]) {
    cylinder(h = stem_height, r = stem_diameter/2);
    // grip ridges
    for (i = [0 : grip_bumps - 1])
        rotate([0, 0, i * 360 / grip_bumps])
            translate([stem_diameter/2, 0, stem_height * 0.4])
                cylinder(h = stem_height * 0.6, r = 1.2, $fn = 24);
}

// EXPERIMENTS (log results in your build log!):
//  1. disc_diameter 35 vs 55 — which spins longer?
//  2. disc_height 4 vs 10?
//  3. flip the disc taper (swap r1 and r2) so the mass sits
//     HIGH instead of low — feel the wobble, learn the why
//  4. ask Claude: "add a hole pattern in the disc so it whistles"
