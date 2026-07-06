// ============================================================
// NAME KEYCHAIN — your first code-CAD project
// ============================================================
// Change the line below, press F5, and watch. That's coding CAD.
//
// Print: flat side down, no supports, ~15 min.
// Multi-color: in Bambu Studio, color-paint the letters a
// different color than the base (they stick up, easy to select).
// ============================================================

// ------------ CHANGE THESE ------------
name        = "MATT";   // <-- your name here
font_size   = 12;       // letter height in mm
base_height = 3;        // thickness of the base plate
text_height = 2;        // how far letters stick up
ring_hole   = 5;        // keyring hole diameter in mm
// ---------------------------------------

font    = "Liberation Sans:style=Bold";
padding = 4;            // base border around the letters

// A rough width estimate so the base auto-fits the name.
// (Letters average ~0.7x their size in width for this font.
//  If your letters poke past the edge, raise 0.70 a little.)
text_w = len(name) * font_size * 0.70;

// ---- the base plate: a rounded bar + a ring for the keyring ----
module base() {
    hull() {
        translate([padding, 0, 0])
            cylinder(h = base_height, r = font_size/2 + padding, $fn = 48);
        translate([text_w - padding, 0, 0])
            cylinder(h = base_height, r = font_size/2 + padding, $fn = 48);
    }
    // keyring loop on the left
    translate([-font_size/2 - padding, 0, 0])
        cylinder(h = base_height, r = ring_hole/2 + 3, $fn = 48);
}

difference() {
    union() {
        base();
        // ---- the name, raised on top ----
        translate([0, 0, base_height])
            linear_extrude(text_height)
                text(name, size = font_size, font = font,
                     halign = "left", valign = "center");
    }
    // ---- the keyring hole ----
    translate([-font_size/2 - padding, 0, -1])
        cylinder(h = base_height + text_height + 2, r = ring_hole/2, $fn = 48);
}

// IDEAS TO TRY (or ask Claude):
//  - a heart or soccer ball instead of the ring circle
//  - two-line text (hint: a second text() moved with translate)
//  - emboss INTO the base instead of raising up (hint: difference)
