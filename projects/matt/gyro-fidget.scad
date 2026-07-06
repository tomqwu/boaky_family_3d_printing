// ============================================================
// GYRO FIDGET — print-in-place gimbal spinner
// ============================================================
// Three parts, printed already assembled: an OUTER RING, an
// INNER RING, and a CENTER DISC. Each part hangs on TWO pins
// on opposite sides — and each pair of pins is turned 90° from
// the next, so the disc tips one way while the inner ring tips
// the other. That criss-cross is a GIMBAL: it's how ship
// compasses and camera stabilizers stay level. Spin all three
// at once and it never gets old.
//
// The pins are the same trick as flexi-snake.scad: a pin with
// fat TRAP CAPS on the end, spinning inside a pocket hidden in
// the next ring's wall. `clearance` is the magic number — print
// family/clearance-test.scad first and put your winner here.
//
// Print: flat on the plate, NO supports (the hidden pins make
// their own tiny bridges — that's fine). If a pivot feels stuck
// off the plate, twist it firmly once to crack it loose — normal!
// PLA is perfect. ~50-70 min.
// ============================================================

// ------------ CHANGE THESE ------------
clearance = 0.35;  // gap AROUND each pin (mm)  <-- from clearance-test!
v_clr     = 0.30;  // extra gap at the flat ENDS of the trap caps
h         = 10;    // fidget thickness (height off the plate)
r_disc    = 10;    // center disc radius
gap       = 0.8;   // open moat you can see between the parts
// ---------------------------------------

// ---- joint dimensions (worked out to stay trapped) ----
r_pin   = 2.2;     // the pin
wall    = 1.8;     // ring wall the pin spins inside
cap_len = 1.2;     // trap cap length (stops pull-out)
shell   = 1.6;     // solid wall left OUTSIDE the hidden pocket

r_cap  = r_pin + clearance + wall * 0.5;     // trap cap radius
ring_t = wall + cap_len + 2*v_clr + shell;   // how thick each ring must be
r1_in  = r_disc + gap;                       // inner ring, inside edge
r1_out = r1_in + ring_t;                     // inner ring, outside edge
r2_in  = r1_out + gap;                       // outer ring, inside edge
r2_out = r2_in + ring_t;                     // outer ring, outside edge

$fn = 72;

// ============ one pivot pin (lies flat, points outward in +X) ============
// Ri = outer radius of the part the pin grows from. The shaft
// reaches across the moat and through the next ring's wall; the
// trap cap on the end spins inside a hidden pocket so the parts
// can turn but never come apart.
module pivot_pin(Ri) {
    translate([0, 0, h/2]) rotate([0, 90, 0]) {
        // shaft: starts 2 mm INSIDE its own part (a strong weld)
        translate([0, 0, Ri - 2])
            cylinder(h = 2 + gap + wall + v_clr + cap_len, r = r_pin);
        // trap cap on the far end
        translate([0, 0, Ri + gap + wall + v_clr])
            cylinder(h = cap_len, r = r_cap);
    }
}

// ============ the matching seat (a CUTTER, points inward from +X) ============
// Ro = inner radius of the part being drilled. A snug hole
// through the wall for the shaft, then a wider hidden pocket
// where the trap cap spins.
module pin_seat(Ro) {
    translate([0, 0, h/2]) rotate([0, 90, 0]) {
        // shaft hole — starts 0.5 mm early because the ring's inner
        // wall is CURVED and bulges toward the shaft at its sides
        translate([0, 0, Ro - 0.5])
            cylinder(h = wall + 0.6, r = r_pin + clearance);
        translate([0, 0, Ro + wall])                   // cap pocket
            cylinder(h = cap_len + 2*v_clr, r = r_cap + clearance);
    }
}

// ============ part 1: center disc (pins point EAST-WEST) ============
module center_disc() {
    difference() {
        union() {
            cylinder(h = h, r = r_disc);
            for (a = [0, 180]) rotate([0, 0, a]) pivot_pin(r_disc);
        }
        // a thumb dimple on top, for spinning
        translate([0, 0, h + 5.4]) sphere(r = 7, $fn = 64);
    }
}

// ============ part 2: inner ring (pins point NORTH-SOUTH — the 90° twist!) ============
module inner_ring() {
    difference() {
        union() {
            difference() {
                cylinder(h = h, r = r1_out);
                translate([0, 0, -0.1]) cylinder(h = h + 0.2, r = r1_in);
            }
            for (a = [90, 270]) rotate([0, 0, a]) pivot_pin(r1_out);
        }
        // seats for the DISC's pins (east-west)
        for (a = [0, 180]) rotate([0, 0, a]) pin_seat(r1_in);
    }
}

// ============ part 3: outer ring (just seats, plus a grippy edge) ============
module outer_ring() {
    difference() {
        difference() {
            cylinder(h = h, r = r2_out);
            translate([0, 0, -0.1]) cylinder(h = h + 0.2, r = r2_in);
        }
        // seats for the INNER RING's pins (north-south)
        for (a = [90, 270]) rotate([0, 0, a]) pin_seat(r2_in);
        // finger scallops around the rim (offset 15° so they
        // never dig into the hidden cap pockets)
        for (a = [15 : 30 : 345]) rotate([0, 0, a])
            translate([r2_out, 0, -0.1])
                cylinder(h = h + 0.2, r = 1.1, $fn = 32);
    }
}

// ============ assemble the gyro ============
render_gyro = true;   // (debug hook: set false to use the part modules alone)
if (render_gyro) {
    center_disc();
    inner_ring();
    outer_ring();
}

// IDEAS TO TRY (or ask Claude):
//  - a FOURTH ring! add r3_in/r3_out and one more pin pair
//    (turned 90° again) for a mega-gimbal
//  - r_disc = 14 and h = 12 for a chunky desk version
//  - put your initial on the disc instead of the dimple
//  - color trick: pause-swap filament halfway up so the rings
//    are two-tone when they spin
