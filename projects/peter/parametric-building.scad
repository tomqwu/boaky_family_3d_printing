// ============================================================
// PARAMETRIC BUILDING — one file, infinite buildings
// ============================================================
// This is what "parametric" means: the building is described by
// RULES, not fixed shapes. Change floors = 6 to floors = 40 and
// you have a different tower. Real architecture firms work
// exactly like this.
//
// Scale reference: at 1:1000, 1 floor ≈ 3-4 mm. This model's
// default (~45 mm tall) is roughly a 12-story building at 1:1000.
//
// Print: flat on plate, no supports needed for flat/setback
// roofs. Color-paint the windows in Bambu Studio (they're
// recessed — easy to select). ~1-2 hrs depending on size.
// ============================================================

// ------------ CHANGE THESE ------------
floors      = 10;       // how tall is your building?
floor_h     = 4;        // height per floor (mm)
bldg_w      = 32;       // width (mm)
bldg_d      = 24;       // depth (mm)
roof_style  = "setback"; // "flat", "pitched", or "setback" (NYC 1920s!)
win_w       = 3.2;      // window width
win_h       = 2.4;      // window height
win_depth   = 1.0;      // how deep windows are recessed
door_w      = 6;        // ground-floor door
door_h      = 6;
// ---------------------------------------

margin = 3;  // solid wall at building corners

// how many windows fit per wall (the parametric magic:
// resize the building and the window count adapts)
cols_front = floor((bldg_w - 2*margin) / (win_w + 3));
cols_side  = floor((bldg_d - 2*margin) / (win_w + 3));

module window_grid(width, cols) {
    // windows on floors 2..top, centered across the wall
    pitch = (width - 2*margin) / cols;
    for (f = [1 : floors - 1])
        for (c = [0 : cols - 1])
            translate([margin + pitch * (c + 0.5) - win_w/2,
                       0,
                       f * floor_h + (floor_h - win_h)/2])
                cube([win_w, win_depth + 0.1, win_h]);
}

module shaft(w, d, fl) {
    difference() {
        cube([w, d, fl * floor_h]);
        // front + back windows
        translate([0, -0.05, 0])          window_grid(w, cols_front);
        translate([w, d + 0.05, 0]) rotate([0, 0, 180]) window_grid(w, cols_front);
        // side windows
        translate([-0.05, d, 0]) rotate([0, 0, -90])  window_grid(d, cols_side);
        translate([w + 0.05, 0, 0]) rotate([0, 0, 90]) window_grid(d, cols_side);
    }
}

// ---- sidewalk plinth ----
translate([-2, -2, 0])
    cube([bldg_w + 4, bldg_d + 4, 1]);

// ---- the tower ----
translate([0, 0, 1]) {
    difference() {
        shaft(bldg_w, bldg_d, floors);
        // front door
        translate([(bldg_w - door_w)/2, -0.05, 0])
            cube([door_w, win_depth + 0.1, door_h]);
    }

    // ---- roof ----
    if (roof_style == "flat") {
        // parapet: a thin wall around the roof edge
        translate([0, 0, floors * floor_h])
            difference() {
                cube([bldg_w, bldg_d, 1.5]);
                translate([1, 1, -0.1])
                    cube([bldg_w - 2, bldg_d - 2, 1.7]);
            }
    }
    if (roof_style == "pitched") {
        // a classic triangle roof (prism)
        translate([0, 0, floors * floor_h])
            rotate([90, 0, 90])
                linear_extrude(bldg_w)
                    polygon([[0, 0], [bldg_d, 0], [bldg_d/2, bldg_d * 0.4]]);
    }
    if (roof_style == "setback") {
        // 1920s zoning-law style: each tier steps back (ask Peter
        // WHY New York towers look like this — it's an urban
        // planning story: the 1916 Zoning Resolution!)
        t1 = floors * floor_h;
        translate([bldg_w * 0.15, bldg_d * 0.15, t1])
            shaft(bldg_w * 0.7, bldg_d * 0.7, max(2, floor(floors / 3)));
        t2 = t1 + max(2, floor(floors / 3)) * floor_h;
        translate([bldg_w * 0.3, bldg_d * 0.3, t2])
            shaft(bldg_w * 0.4, bldg_d * 0.4, max(1, floor(floors / 6)));
        // spire
        t3 = t2 + max(1, floor(floors / 6)) * floor_h;
        translate([bldg_w/2, bldg_d/2, t3])
            cylinder(h = 8, r1 = 1.5, r2 = 0.4, $fn = 24);
    }
}

// IDEAS TO TRY (or ask Claude):
//  - a corner tower: two shafts joined in an L
//  - random window lights: some windows lit (raised) some dark
//  - a whole street: for-loop of buildings with random floors
//    (hint: rands() gives random numbers)
//  - match a real building: count its floors on Google Street View
