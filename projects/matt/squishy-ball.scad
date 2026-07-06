// ============================================================
// SQUISHY BALL — airless-style TPU bouncy ball
// ============================================================
// Like the famous "airless soccer ball": a hollow sphere with a
// pattern of holes punched through the shell. The holes let the
// wall flex, so the whole ball squishes and bounces back — no
// air needed, nothing to pump up.
//
// MATERIAL: TPU 95A (the flexible stuff). IMPORTANT: TPU does
// NOT go through the AMS on our H2C — it's too stretchy and
// jams. Get Dad to load it on the rear/external spool holder.
// Print SLOW (the TPU preset, ~20-30 mm/s) with no supports —
// the holes break the dome into short bridges TPU can handle.
// Expect a little fuzz inside; that's normal. Use a brim (the
// ball only touches the plate on a small flat spot). ~2-3 hrs.
//
// It prints in PLA too and looks cool — but PLA is stiff, so it
// won't squish or bounce. For the real thing, it has to be TPU.
// ============================================================

// ------------ CHANGE THESE ------------
ball_d       = 55;    // ball diameter in mm (55 ≈ juggling ball size)
shell        = 2.0;   // wall thickness — keep it 1.6 or more!
hole_d       = 10;    // hole diameter (bigger = squishier + weaker)
holes_around = 10;    // holes in the middle row (rows above/below
                      // get fewer automatically, like a real ball)
flat_spot    = 1.2;   // tiny flat shaved off the bottom so it
                      // stands on the plate instead of rolling
// ---------------------------------------
// Careful: if hole_d gets too big the holes merge and the ball
// falls apart into loose pieces. Ask Claude to check your numbers!

R = ball_d / 2;

$fn = 96;   // smooth sphere (holes use their own, lower $fn)

// ============ one hole, aimed out from the ball's center ============
// lat = latitude like on a globe: 0 = equator, 90 = north pole.
// lon = longitude: spins the hole around the ball.
module one_hole(lat, lon) {
    rotate([0, 0, lon])
        rotate([0, 90 - lat, 0])            // tilt from pole to latitude
            cylinder(h = R + 5, r = hole_d / 2, $fn = 48);
}

// ============ the ball ============
// Hollow sphere = big sphere minus slightly smaller sphere.
// Then punch rows of holes at latitudes -60, -30, 0, 30, 60,
// plus one at the north pole. Rows are staggered (shifted half
// a step) so the pattern looks woven, like a real soccer ball.
translate([0, 0, R - flat_spot])            // rest flat spot on the plate
    difference() {
        sphere(r = R);                      // outside
        sphere(r = R - shell);              // hollow inside
        one_hole(90, 0);                    // north pole hole
        for (row = [0 : 4]) {
            lat = -60 + row * 30;           // -60, -30, 0, 30, 60
            n   = max(3, round(holes_around * cos(lat)));  // fewer holes
                                            // where the ball gets narrower
            off = (row % 2 == 0) ? 0 : 180 / n;   // stagger odd rows
            for (k = [0 : n - 1])
                one_hole(lat, off + k * 360 / n);
        }
        // shave the bottom flat (no south-pole hole — the flat
        // spot is your grip spot, and it helps the print stick)
        translate([0, 0, -R])
            cube([ball_d + 4, ball_d + 4, 2 * flat_spot], center = true);
    }

// IDEAS TO TRY (or ask Claude):
//  - ball_d = 20 for a mini ball — perfect for penalty-shootout.scad!
//  - hexagon holes instead of round ($fn = 6 on the hole cylinder)
//  - a two-color ball: print two, cut the pattern differently,
//    or color-paint panels in Bambu Studio
//  - shell = 1.6 and hole_d = 12 for maximum squish (test-drop it —
//    too floppy and it won't bounce back)
