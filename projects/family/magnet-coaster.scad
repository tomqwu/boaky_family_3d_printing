// ============================================================
// MAGNET COASTER — hidden magnets, sealed INSIDE the print
// ============================================================
// A coaster (or fridge badge) with round magnets buried inside
// it. Nobody can see them, nothing rattles: you PAUSE the print
// partway, drop the magnets into their pockets, and the printer
// seals them in when it resumes. The pockets have solid plastic
// 0.8 mm below AND above the magnets.
//
// >>> GET DAD — this is a two-person print: <<<
//   - The printer is HOT and mid-print when you open it. Dad
//     places the magnets, kids direct.
//   - POLARITY CHECK before resuming: stack all the magnets on
//     one spare magnet on the table first, then place them
//     without flipping — same pole up in every pocket, or your
//     coaster will push away from the fridge instead of sticking.
//   - Small strong magnets are DANGEROUS if swallowed — keep
//     them away from little kids and count them before/after.
//
// Watch the ECHO output when you render: it prints the exact
// height to type into Bambu Studio's "pause at height".
//
// Print: flat on the plate, no supports. The 0.8 mm roof over
// each magnet bridges just fine at this size. ~40 min in PLA.
// ============================================================

// ------------ CHANGE THESE ------------
magnet_d     = 6.2;    // pocket diameter: 6 mm magnet + 0.2 wiggle room
magnet_h     = 2.2;    // pocket depth: 2 mm magnet + 0.2 so the roof
                       //   never squishes down onto the magnet
n_magnets    = 4;      // how many magnets around the ring
coaster_d    = 90;     // coaster diameter (mm)
coaster_h    = 4.6;    // total thickness (mm)
layer_h      = 0.2;    // your layer height in Bambu Studio
emboss_style = "star"; // "star", "ball", or "none" — raised art to paint
// ---------------------------------------

cover  = 0.8;                        // solid plastic below AND above magnets
ring_r = coaster_d/2 - magnet_d/2 - 5;  // pocket circle, near the edge

// ---- safety checks: OpenSCAD refuses to render a bad design ----
assert(coaster_h >= cover + magnet_h + cover,
       "coaster_h too thin! Needs 0.8 + magnet_h + 0.8 minimum.");
assert(2 * ring_r * sin(180 / n_magnets) >= magnet_d + 2,
       "Too many magnets for this diameter - fewer magnets or bigger coaster.");

// ============ PAUSE-AT-HEIGHT NOTE (read the console!) ============
// The pockets run from z = 0.8 up to z = 0.8 + magnet_h. The
// printer must pause when the pockets are OPEN but about to be
// roofed over — exactly at the pocket-top height. If that isn't
// a whole number of layers, we round UP to the next layer (a
// hair of extra headroom never hurts; too little jams the nozzle).
pause_z_exact = cover + magnet_h;
pause_z       = ceil(pause_z_exact / layer_h) * layer_h;
echo(str(">>> BAMBU STUDIO: set 'pause at height' to Z = ", pause_z,
         " mm  (that is layer ", pause_z / layer_h,
         " at ", layer_h, " mm layers) <<<"));

$fn = 96;

// ============ the coaster body, minus the magnet pockets ============
difference() {
    cylinder(h = coaster_h, d = coaster_d);
    for (i = [0 : n_magnets - 1])
        rotate([0, 0, i * 360 / n_magnets])
            translate([ring_r, 0, cover])           // 0.8 mm floor below...
                cylinder(h = magnet_h, d = magnet_d, $fn = 48);
                // ...and the roof above is coaster_h - 0.8 - magnet_h,
                // which the assert up top guarantees is >= 0.8
}

// ============ raised art on top (0.6 mm — easy to paint) ============
module star(points, r_out, r_in) {  // a classic star outline
    polygon([ for (i = [0 : 2 * points - 1])
        let (r = (i % 2 == 0) ? r_out : r_in,
             a = 90 + i * 180 / points)
        [r * cos(a), r * sin(a)] ]);
}

translate([0, 0, coaster_h]) {
    if (emboss_style == "star")
        linear_extrude(0.6)
            star(5, coaster_d * 0.28, coaster_d * 0.11);
    if (emboss_style == "ball") {    // a simple soccer ball for Matt
        linear_extrude(0.6)
            difference() {           // the ball outline
                circle(d = coaster_d * 0.55);
                circle(d = coaster_d * 0.55 - 5);
            }
        linear_extrude(0.6)          // the middle pentagon patch
            rotate([0, 0, 90])
                circle(d = coaster_d * 0.2, $fn = 5);
    }
}

// IDEAS TO TRY (or ask Claude):
//  - a fridge NAME badge: swap the star for text(), one per family member
//  - Peter: a coaster set where each one is a different city's street grid
//  - Matt: Mario-INSPIRED (your own design!) power-up badge, ? block style
//  - magnetic chess/checkers pieces — tiny version with one magnet each
