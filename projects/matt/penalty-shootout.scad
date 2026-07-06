// ============================================================
// PENALTY SHOOTOUT — desktop soccer game (capstone STARTER)
// ============================================================
// A flick-and-save penalty game in 5 printed parts:
//   1. PITCH BASE  — with a dovetail-ish rail across the goal mouth
//   2. GOAL FRAME  — posts + crossbar, holes all along the frame
//                    so you can weave rubber bands (or string) into
//                    a real net. Tabs plug into the base.
//   3. KEEPER      — a flat goalie figure, arms out for the save
//   4. KEEPER SLED — slides left-right in the rail; the keeper
//                    snaps into its slot
//   5. FLICK RAMP  — a wedge with a ball channel: put a ball at the
//                    bottom, flick it up the ramp to chip the keeper!
//
// THIS IS A STARTING POINT, ON PURPOSE. Your capstone job is to
// make it YOURS: redesign the keeper, resize the goal, add a
// scoreboard, a crowd, a second rail... rip out anything you want.
//
// Print: all 5 parts lie flat on one plate, NO supports, PLA is
// fine. ~3-4 hrs total. Assemble: push the goal tabs into the base
// slots, slide the sled in from either end of the rail, press the
// keeper's foot tab into the sled slot. One finger slides the
// keeper; the other hand shoots.
//
// BALL: a pom-pom, a foil ball — or print squishy-ball.scad at
// ball_d = 20 in TPU. Best ball ever.
// ============================================================

// ------------ CHANGE THESE ------------
goal_w   = 120;   // goal width, outside edge to outside edge
goal_h   = 90;    // goal height
frame_w  = 8;     // how chunky the goal frame is
keeper_span = 44; // keeper fingertip-to-fingertip reach

slider_clearance = 0.4;  // gap around the sliding sled, in mm.
                         // Sliders like a bit MORE room than hinges —
                         // start at 0.4. If yours is scratchy, go up;
                         // if it rattles, go down. (Print
                         // family/clearance-test.scad to find how
                         // your printer feels about small gaps.)
fit_clearance    = 0.2;  // snug press-fit gap (goal tabs, keeper tab)
// ---------------------------------------

// ---- sizes that just work together (change with care) ----
frame_t     = 5;     // goal frame thickness
net_hole_d  = 3.5;   // net-weaving holes
tab_w       = 18;    // goal plug-in tabs
tab_h       = 2.8;   // just shy of base thickness, so the tabs sit
                     // flush underneath and the base doesn't wobble

base_l      = 150;   // pitch base
base_w      = 60;
base_t      = 3;
rail_y      = 18;    // rail centerline, this far from the front edge
goal_y      = 50;    // goal stands this far from the front edge

groove_w    = 10;    // rail groove: wide at the bottom...
groove_open = 8;     // ...narrower at the top = sled can't pop out
groove_deep = 3;
block_w     = 20;    // the raised strip the groove is cut into

sled_len    = 26;
paddle_t    = 3.5;   // keeper figure thickness
foot_len    = 20;    // keeper's foot tab (fits the sled slot)
foot_deep   = 2.2;

ramp_w      = 34;    // flick ramp
ramp_len    = 55;
ramp_h      = 16;

$fn = 48;

sled_h = groove_deep - slider_clearance;   // sled rides under the lip

// ============ 1) PITCH BASE with the keeper rail ============
// The groove is a trapezoid: wider at the bottom than the top.
// That's the "dovetail" trick — the sled slides along freely but
// can't lift out. It only goes in from the open ends.
module base_plate() {
    difference() {
        union() {
            translate([-base_l/2, 0, 0])
                cube([base_l, base_w, base_t]);
            // raised strip that holds the groove
            translate([-base_l/2, rail_y - block_w/2, base_t])
                cube([base_l, block_w, groove_deep + 0.4]);
        }
        // the groove, cut end to end
        translate([-base_l/2 - 1, rail_y, base_t + 0.4])
            rotate([90, 0, 90])
                linear_extrude(base_l + 2)
                    polygon([
                        [-groove_w/2, 0], [groove_w/2, 0],        // floor
                        [groove_open/2, groove_deep],             // sloped
                        [groove_open/2, groove_deep + 2],         //  walls
                        [-groove_open/2, groove_deep + 2],
                        [-groove_open/2, groove_deep]
                    ]);
        // slots for the goal's tabs
        for (s = [-1, 1])
            translate([s*40 - (tab_w + 2*fit_clearance)/2,
                       goal_y - (frame_t + 2*fit_clearance)/2, -0.1])
                cube([tab_w + 2*fit_clearance,
                      frame_t + 2*fit_clearance, base_t + 0.2]);
    }
}

// ============ 2) GOAL FRAME (drawn flat, stood up later) ============
module goal_2d() {
    difference() {
        translate([-goal_w/2, 0]) square([goal_w, goal_h]);
        // the goal mouth
        translate([-(goal_w/2 - frame_w), frame_w])
            square([goal_w - 2*frame_w, goal_h - 2*frame_w]);
        // net holes along the crossbar...
        for (x = [-45 : 9 : 45])
            translate([x, goal_h - frame_w/2]) circle(d = net_hole_d);
        // ...and down both posts. Weave rubber bands across = net!
        for (s = [-1, 1])
            for (y = [14 : 9 : goal_h - frame_w - 4])
                translate([s*(goal_w/2 - frame_w/2), y])
                    circle(d = net_hole_d);
    }
    // plug-in tabs (they push through the base slots)
    for (s = [-1, 1])
        translate([s*40 - tab_w/2, -tab_h]) square([tab_w, tab_h + 1]);
}

// ============ 3) KEEPER (a flat figure, arms up for the save) ============
module keeper_2d() {
    // foot tab — press-fits into the sled slot
    translate([-foot_len/2, -foot_deep]) square([foot_len, foot_deep + 1]);
    // legs
    hull() {
        translate([-10, 0]) square([20, 12]);
        translate([0, 20]) circle(8);
    }
    // body
    hull() {
        translate([0, 20]) circle(8);
        translate([0, 32]) circle(6.5);
    }
    // arms stretched up and out — classic keeper dive pose
    for (s = [-1, 1])
        hull() {
            translate([s*5, 28]) circle(4);
            translate([s*(keeper_span/2 - 4), 40]) circle(4);
        }
    // head
    translate([0, 42.5]) circle(7);
}

// ============ 4) KEEPER SLED (the sliding part) ============
// Same trapezoid as the groove, shrunk by slider_clearance all
// around, with a slot on top for the keeper's foot tab.
module sled() {
    slope  = (groove_w - groove_open) / 2 / groove_deep;
    hw_bot = groove_w/2 - slider_clearance;
    hw_top = groove_w/2 - sled_h*slope - slider_clearance;
    difference() {
        translate([-sled_len/2, 0, 0])
            rotate([90, 0, 90])
                linear_extrude(sled_len)
                    polygon([[-hw_bot, 0], [hw_bot, 0],
                             [hw_top, sled_h], [-hw_top, sled_h]]);
        // keeper slot (the sled's ends stay joined — still one piece)
        translate([0, 0, sled_h/2 + 0.05])
            cube([foot_len + 2*fit_clearance,
                  paddle_t + 2*fit_clearance, sled_h + 0.2], center = true);
    }
}

// ============ 5) FLICK RAMP ============
// A wedge with a round channel scooped down the slope. Ball goes
// at the low end, finger flicks it up the channel — the ramp aims
// your shot and adds loft to chip it over the keeper.
module ramp() {
    ang = atan(ramp_h / ramp_len);      // slope angle
    r   = 8;                            // channel scoop radius
    off = r - 3.5;                      // scoop sinks 3.5 into the face
    difference() {
        translate([-ramp_w/2, 0, 0])
            rotate([90, 0, 90])
                linear_extrude(ramp_w)
                    polygon([[0, 0], [ramp_len, 0], [ramp_len, ramp_h]]);
        // the channel: a long cylinder lying along the slope
        translate([0, ramp_len/2 - off*sin(ang), ramp_h/2 + off*cos(ang)])
            rotate([-(90 - ang), 0, 0])
                cylinder(h = ramp_len * 1.6, r = r, center = true);
    }
}

// ============ THE KIT — all 5 parts flat on one plate ============
show_kit     = true;    // the printable layout
check_slider = false;   // (debug hook: Claude uses this to prove the
                        //  sled + keeper never touch the rail walls)

if (show_kit) {
    base_plate();
    translate([0, 81, 0])    linear_extrude(frame_t)  goal_2d();
    translate([105, 8, 0])   linear_extrude(paddle_t) keeper_2d();
    translate([100, 70, 0])  sled();
    translate([-110, 0, 0])  ramp();
}

// ---- keeper + sled, assembled in the rail (for the debug check) ----
module keeper_assembled() {
    translate([0, rail_y, base_t + 0.4]) {   // groove floor, mid-rail
        sled();
        translate([0, paddle_t/2, sled_h])
            rotate([90, 0, 0])
                linear_extrude(paddle_t) keeper_2d();
    }
}

// If the slider fits, this intersection is EMPTY (no overlap between
// the moving part and the base). Render with:
//   openscad -D show_kit=false -D check_slider=true ...
if (check_slider)
    intersection() {
        base_plate();
        keeper_assembled();
    }

// IDEAS TO TRY (or ask Claude):
//  - redesign the keeper! Your face, a robot, a cat in gloves —
//    anything flat with the same foot tab works
//  - goal_w = 180 and TWO sleds for a two-keeper wall
//  - a score tracker: pegs + holes along the front edge of the base
//  - a TPU flick ramp — squishy launcher = trampoline shots
//  - real net: weave a rubber band zig-zag through the frame holes
