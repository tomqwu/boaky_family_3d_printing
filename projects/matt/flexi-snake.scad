// ============================================================
// FLEXI SNAKE — print-in-place articulated toy
// ============================================================
// The same trick as the flexi dragons: every joint is a PIN
// trapped inside a C-RING, printed already assembled. Nothing
// to glue — it wiggles right off the plate.
//
// THE ONE NUMBER THAT MATTERS: `clearance`. Print
// family/clearance-test.scad first and put your winner here.
// Too small = joints fuse solid. Too big = floppy and rattly.
//
// Print: flat on the plate, NO supports, no brim needed.
// PLA is fine; TPU makes it extra squishy. ~45-60 min.
// ============================================================

// ------------ CHANGE THESE ------------
n_segments = 8;      // how long is your snake?
clearance  = 0.35;   // joint gap in mm  <-- from clearance-test!
h          = 8;      // snake thickness (height off the plate)
r_body     = 6;      // half-width of a body segment
body_len   = 13;     // length of each body segment
// ---------------------------------------

// ---- joint dimensions (worked out to stay trapped) ----
r_pin    = 2.2;                    // the pin
wall     = 1.8;                    // ring wall thickness
cap_h    = 1.2;                    // pin caps that stop lift-off
v_clr    = 0.30;                   // vertical gap above/below ring
neck_w   = 2.4;                    // arm connecting pin to its body
neck_len = 2.0;                    // pin sticks out this far
opening  = 110;                    // ring opening angle (degrees)
overlap  = 1.2;                    // how deep the ring bites into its body

r_in   = r_pin + clearance;        // ring inner radius
r_out  = r_in + wall;              // ring outer radius
r_cap  = r_in + wall * 0.5;        // cap radius (traps the ring)
pin_x  = body_len + neck_len + r_pin;          // pin center, from segment origin
pitch  = pin_x + r_out - overlap;              // segment spacing

$fn = 64;

// ============ one body blob (a rounded teardrop) ============
module body(len, r_back, r_front) {
    hull() {
        translate([r_back, 0, 0])        cylinder(h = h, r = r_back);
        translate([len - r_front, 0, 0]) cylinder(h = h, r = r_front);
    }
}

// ============ the pin side of a joint (belongs to the BACK segment) ============
// Pin center sits at the origin; the neck reaches back in -X into its body.
module joint_pin() {
    cylinder(h = h, r = r_pin);                        // the pin
    translate([-(r_pin + neck_len + 1), -neck_w/2, 0]) // the neck
        cube([r_pin + neck_len + 1, neck_w, h]);
    cylinder(h = cap_h, r = r_cap);                    // bottom cap
    translate([0, 0, h - cap_h])
        cylinder(h = cap_h, r = r_cap);                // top cap
}

// ============ the ring side of a joint (belongs to the FRONT segment) ============
// A C-ring around the origin, opening facing -X so the neck can swing.
module joint_ring() {
    ring_z0 = cap_h + v_clr;
    ring_h  = h - 2 * (cap_h + v_clr);
    a       = 180 - opening/2;     // wedge edge angles: a and -a
    translate([0, 0, ring_z0])
        linear_extrude(ring_h)
            difference() {
                circle(r = r_out);
                circle(r = r_in);
                // the opening wedge, a fan facing backward (-X)
                polygon([
                    [0, 0],
                    [3 * r_out * cos(a),  3 * r_out * sin(a)],
                    [-4 * r_out, 0],
                    [3 * r_out * cos(-a), 3 * r_out * sin(-a)]
                ]);
            }
}

// ============ pockets so the pin caps can spin inside the body ============
// The ring bites into its body for strength, which puts the previous
// segment's pin caps *inside* the body outline — these pockets give
// the caps room so the joint stays free instead of fusing.
module cap_pockets() {
    r = r_cap + clearance;
    translate([0, 0, -0.01])
        cylinder(h = cap_h + v_clr + 0.01, r = r);
    translate([0, 0, h - cap_h - v_clr])
        cylinder(h = cap_h + v_clr + 0.02, r = r);
}

// ============ one full segment: body + pin forward + ring backward ============
module segment(i) {
    translate([i * pitch, 0, 0]) {
        // body (head is segment 0: a round head with eyes — kept clear
        // of the first ring's swing arc, so don't make it much fatter!)
        if (i == 0) {
            difference() {
                translate([6.5, 0, 0]) cylinder(h = h, r = r_body + 1);
                for (s = [-1, 1])   // eyes
                    translate([9, s * 3.5, h - 1.2])
                        cylinder(h = 2, r = 1.4, $fn = 24);
            }
        } else {
            // taper toward the tail
            taper = 1 - 0.55 * (i / (n_segments - 1));
            difference() {
                body(body_len, r_body * taper + 1.5, r_body * taper);
                translate([pin_x - pitch, 0, 0]) cap_pockets();
            }
        }
        // pin reaching forward (every segment except the last)
        if (i < n_segments - 1)
            translate([pin_x, 0, 0]) joint_pin();
        // ring wrapped around the previous segment's pin (every segment except the head)
        if (i > 0)
            translate([pin_x - pitch, 0, 0]) joint_ring();
    }
}

// ============ assemble the snake ============
render_snake = true;   // (debug hook: set false to use segment() alone)
if (render_snake)
    for (i = [0 : n_segments - 1])
        segment(i);

// IDEAS TO TRY (or ask Claude):
//  - n_segments = 15 for a monster (check it fits the plate!)
//  - a rattle tail: bigger last segment with a loose bead inside
//  - color-paint alternating segments in Bambu Studio
//  - swap the head: dragon? worm? eel with fins?
