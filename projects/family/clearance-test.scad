// ============================================================
// CLEARANCE TEST — print this before any print-in-place design
// ============================================================
// Five copies of the exact hinge joint used in flexi-snake.scad,
// with gaps from 0.20 to 0.40 mm. Print flat, no supports (~30 min).
//
// After printing, wiggle each one:
//   - FUSED SOLID  -> gap too small for our printer
//   - moves freely -> works!
// Your magic number = the SMALLEST gap that moves freely.
// Write it in the build log and use it as `clearance` in every
// print-in-place design (flexi-snake.scad and your own).
//
// Tip: re-run this test whenever you change nozzle size, layer
// height, or filament brand — the magic number can shift.
// ============================================================

clearances = [0.20, 0.25, 0.30, 0.35, 0.40];  // one coupon each

// ---- joint geometry (identical to flexi-snake.scad) ----
h        = 8;      // part thickness
r_pin    = 2.2;    // the pin
wall     = 1.8;    // ring wall thickness
cap_h    = 1.2;    // pin caps that stop lift-off
v_clr    = 0.30;   // vertical gap above/below ring
neck_w   = 2.4;    // arm connecting pin to its handle
opening  = 110;    // ring opening angle (degrees)
overlap  = 1.2;    // how deep the ring bites into its handle

handle_l = 13;     // grab-tab length
handle_w = 10;     // grab-tab width
spacing  = 26;     // distance between coupons

$fn = 64;

module coupon(c) {
    r_in  = r_pin + c;
    r_out = r_in + wall;
    r_cap = r_in + wall * 0.5;
    a     = 180 - opening/2;

    // ---- pin side: handle + neck + pin + trap caps ----
    translate([-(handle_l + 4.4), -handle_w/2, 0])
        cube([handle_l, handle_w, h]);
    translate([-5.4, -neck_w/2, 0])
        cube([5.4, neck_w, h]);               // neck (welds into handle)
    cylinder(h = h, r = r_pin);               // pin
    cylinder(h = cap_h, r = r_cap);           // bottom cap
    translate([0, 0, h - cap_h])
        cylinder(h = cap_h, r = r_cap);       // top cap

    // ---- ring side: C-ring + handle with cap pockets + label ----
    translate([0, 0, cap_h + v_clr])
        linear_extrude(h - 2 * (cap_h + v_clr))
            difference() {
                circle(r = r_out);
                circle(r = r_in);
                polygon([                     // opening wedge, facing the pin's neck
                    [0, 0],
                    [3 * r_out * cos(a),  3 * r_out * sin(a)],
                    [-4 * r_out, 0],
                    [3 * r_out * cos(-a), 3 * r_out * sin(-a)]
                ]);
            }
    difference() {
        translate([r_out - overlap, -handle_w/2, 0])
            cube([handle_l, handle_w, h]);
        // pockets so the pin caps can spin free inside the handle
        translate([0, 0, -0.01])
            cylinder(h = cap_h + v_clr + 0.01, r = r_cap + c);
        translate([0, 0, h - cap_h - v_clr])
            cylinder(h = cap_h + v_clr + 0.02, r = r_cap + c);
    }
    // the gap size, embossed on the ring-side handle
    translate([r_out - overlap + handle_l/2 + 1, 0, h])
        linear_extrude(0.6)
            text(str(c), size = 4.5, font = "Liberation Sans:style=Bold",
                 halign = "center", valign = "center");
}

for (i = [0 : len(clearances) - 1])
    translate([0, i * spacing, 0])
        coupon(clearances[i]);
