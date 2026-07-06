// ============================================================
// BALL-JOINT FIGURE — snap-together action-figure arm kit
// ============================================================
// This is the joint REAL action figures use: a ball that snaps
// into a cup and then holds whatever pose you bend it to.
// The kit prints as 4 separate flat parts, then you snap them
// together (satisfying POP!):
//
//   shoulder plate -> upper arm -> forearm -> claw hand
//
// The secret is `snap_fit`: the cup's mouth is slightly SMALLER
// than the ball. The ball forces its way past the lip, then the
// lip traps it — tight enough to hold a pose, loose enough to move.
//
// TUNING with your clearance-test result: if your winning
// clearance was 0.40 (printer squeezes gaps shut), your cup
// mouths come out tight — drop snap_fit to 0.10. If it was 0.20
// (printer leaves roomy gaps), raise snap_fit to 0.20 for a
// firmer grip. Joints too loose after printing? Raise snap_fit.
// Can't snap it in at all? Lower it (and push HARD — it pops).
//
// Print: all parts flat as laid out, NO supports. The balls
// print on little posts and the cups are open bowls — both are
// easy shapes. PLA. ~1 hr for the whole kit.
// ============================================================

// ------------ CHANGE THESE ------------
ball_d   = 8;      // ball diameter (all joints match)
snap_fit = 0.15;   // how much the cup mouth squeezes the ball (mm)
cup_play = 0.10;   // wiggle room inside the cup so poses move smoothly
arm_len  = 40;     // upper arm length (ball center to cup center)
fore_len = 34;     // forearm length
bar_w    = 10;     // limb bar width
bar_h    = 5;      // limb bar thickness
neck     = 3;      // bare post between bar top and ball
// ---------------------------------------

// ---- worked-out joint sizes ----
r_ball  = ball_d / 2;
r_cup   = r_ball + cup_play;              // the hollow the ball lives in
r_mouth = r_ball - snap_fit;              // the mouth the ball snaps past
cwall   = 2.4;                            // cup wall thickness
r_boss  = r_cup + cwall;                  // outside of the cup tower
lip_z   = sqrt(r_cup*r_cup - r_mouth*r_mouth);  // lip height above cup center
cup_c   = r_cup + 0.8;                    // cup center height (0.8 mm floor)
boss_h  = cup_c + lip_z + 0.8;            // cup tower height
stem_r  = 2.5;                            // ball post radius

$fn = 64;

// ============ a cup (socket), opening straight UP ============
module cup_boss() {
    difference() {
        cylinder(h = boss_h, r = r_boss);
        translate([0, 0, cup_c]) sphere(r = r_cup);         // the hollow
        translate([0, 0, cup_c])                            // the mouth
            cylinder(h = boss_h, r = r_mouth);
        translate([0, 0, boss_h - 0.6])                     // funnel edge to
            cylinder(h = 0.7, r1 = r_mouth, r2 = r_mouth + 1.4);  // guide the ball in
    }
}

// ============ a ball on a post, standing on the plate ============
module ball_post(stem_h) {
    cylinder(h = stem_h, r = stem_r);
    translate([0, 0, stem_h + r_ball - 1])   // ball sunk 1 mm into the
        sphere(r = r_ball);                  // post for a strong weld
}

// ============ a flat rounded bar, length measured center-to-center ============
module bar(len) {
    hull() {
        cylinder(h = bar_h, r = bar_w/2);
        translate([len, 0, 0]) cylinder(h = bar_h, r = bar_w/2);
    }
}

// ============ part 1: shoulder plate (tape it to a cardboard robot!) ============
module shoulder_plate() {
    difference() {
        hull()
            for (p = [[0, 0], [26, 0], [0, 18], [26, 18]])
                translate(p) cylinder(h = 3.2, r = 5);
        // rubber-band / string holes for strapping to a body
        for (p = [[-2, 9], [28, 9]])
            translate([p[0], p[1], -0.1]) cylinder(h = 3.4, r = 2);
    }
    translate([13, 9, 0]) cup_boss();
}

// ============ parts 2 + 3: a limb — ball on one end, cup on the other ============
module limb(len) {
    bar(len);
    ball_post(bar_h + neck);                 // ball at x = 0
    translate([len, 0, 0]) cup_boss();       // cup at x = len
}

// ============ part 4: claw hand — ball plus a pencil-gripping C ============
module claw() {
    ball_post(bar_h + neck);
    bar(10);                                 // short wrist
    translate([16, 0, 0])
        linear_extrude(bar_h + 3)
            difference() {
                circle(r = 8);
                circle(r = 5.5);
                // the opening wedge (points away from the ball)
                polygon([[0, 0], [20, 15], [20, -15]]);
            }
}

// ============ lay out the kit — parts spread apart, NOT touching ============
render_kit = true;   // (debug hook: set false to use the part modules alone)
if (render_kit) {
    shoulder_plate();
    translate([0, 38, 0]) limb(arm_len);
    translate([0, 62, 0]) limb(fore_len);
    translate([0, 85, 0]) claw();
}

// IDEAS TO TRY (or ask Claude):
//  - a whole figure: two arms, two legs, a body plate with FOUR cups
//  - a soccer kicker: longer forearm + a flat foot instead of the claw
//  - swap the claw for a hand, a hook, or a tiny goal net
//  - TPU balls in PLA cups = grippy joints that never wear loose
