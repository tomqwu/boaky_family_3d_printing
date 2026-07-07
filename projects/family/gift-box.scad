// ============================================================
// GIFT BOX — because a printed gift deserves a printed box
// ============================================================
// A box with a SLIDING LID and a name on top. Size it to your
// gift, put their name on the lid, done — the box is half the
// present. (Gift playbook: program/09-gifts-and-occasions.md)
//
// The lid slides on rails cut into the box walls. The fit comes
// from `slide_gap` — start with your clearance-test winner;
// a touch bigger slides silkier.
//
// Print: both parts flat as placed, no supports. ~1-2 hrs
// depending on size. Silk PLA makes it look store-bought.
// ============================================================

// ------------ CHANGE THESE ------------
inner_w   = 50;      // inside width  (measure your gift + 2mm!)
inner_d   = 70;      // inside depth
inner_h   = 25;      // inside height
name      = "MATT";  // who's it for? ("" for a plain lid)
slide_gap = 0.30;    // lid clearance — from family/clearance-test.scad
// ---------------------------------------

wall   = 2.0;    // box wall thickness
floor_t = 1.6;   // box floor
lid_t  = 2.0;    // lid plate thickness
rail   = 1.4;    // how far the lid tongue reaches into the walls
rim    = 2.0;    // solid rim above the lid groove

$fn = 48;

outer_w = inner_w + 2*wall;
outer_d = inner_d + 2*wall;
groove_z = floor_t + inner_h;              // lid slides at this height
outer_h  = groove_z + lid_t + slide_gap + rim;

// ================= the box =================
difference() {
    cube([outer_w, outer_d, outer_h]);

    // the inside of the box — cut all the way to the sky, so the
    // top is OPEN over the gift; only the rail lip stays above the
    // groove (that lip is what holds the lid down)
    translate([wall, wall, floor_t])
        cube([inner_w, inner_d, outer_h]);

    // lid groove: widen the opening into the left/right/back walls
    translate([wall - rail, wall - rail, groove_z])
        cube([inner_w + 2*rail, inner_d + 2*rail, lid_t + slide_gap]);

    // front slot: remove the front wall above the groove so the
    // lid can slide in from the front
    translate([wall - rail, -0.1, groove_z])
        cube([inner_w + 2*rail, wall + 0.2, lid_t + slide_gap + rim + 0.1]);
}

// ================= the lid (printed beside the box) =================
lid_w = inner_w + 2*rail - slide_gap;
lid_l = inner_d + rail + wall - 0.4;   // front edge sits flush-ish
translate([outer_w + 10, 0, 0]) {
    cube([lid_w, lid_l, lid_t]);
    // finger grip bar on the front edge
    translate([lid_w/2 - 8, 1.5, lid_t])
        cube([16, 3, 1.6]);
    // the name, raised on top
    if (name != "")
        translate([lid_w/2, lid_l/2 + 4, lid_t])
            linear_extrude(0.8)
                text(name, size = min(9, (lid_w - 8) / max(1, len(name)) / 0.7),
                     font = "Liberation Sans:style=Bold",
                     halign = "center", valign = "center");
}

// IDEAS TO TRY (or ask Claude):
//  - a heart-shaped or hexagonal box for Valentine's
//  - emboss the date under the name (birthday keepsake)
//  - a divider grid inside for tiny parts (calibrate to the gift)
//  - print box and lid in contrasting colors, name in a third
