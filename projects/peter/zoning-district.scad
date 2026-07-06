// ============================================================
// ZONING DISTRICT — a multi-color city zoning map
// ============================================================
// A real planning department draws maps exactly like this: the
// city gets split into ZONES, and each zone has rules about what
// you can build there. The classic five:
//   R = Residential (houses, apartments)
//   C = Commercial  (shops, offices)
//   I = Industrial  (factories, warehouses)
//   P = Park        (green space)
//   W = Water       (rivers, harbor)
//
// THE MULTI-COLOR TRICK: every zone type is a slab raised to a
// DIFFERENT height, in 0.6 mm steps. In Bambu Studio open the
// Color Painting tool, pick "Height range", and each 0.6 mm band
// selects one whole zone type at once — the entire map gets
// colored in seconds, no careful painting needed. That's exactly
// why the heights are stepped instead of all equal.
//
// The streets are the recessed gaps BETWEEN the slabs — leave
// them the base color (asphalt gray looks great).
//
// Print: flat on the plate, no supports, ~1-1.5 hrs.
// ============================================================

// ------------ CHANGE THESE ------------
map_w    = 100;   // map width  (mm)
map_d    = 80;    // map depth  (mm)
base_h   = 2;     // base plate thickness (this is "street level")
street_w = 4;     // street width between zones
step_h   = 0.6;   // ONE color step — keep this at 0.6 so the
                  // height-range painting bands line up nicely

// YOUR ZONING MAP: each line is one zone rectangle:
//   [ x, y, width, depth, "code" ]
// x/y is the rectangle's bottom-left corner on the map.
// Rectangles should tile the map edge-to-edge — the street gaps
// are added automatically. Redraw your own city here!
zones = [
    [  0,  0, 40, 30, "R" ],   // homes near the waterfront park
    [ 40,  0, 35, 30, "C" ],   // downtown shops
    [ 75,  0, 25, 30, "P" ],   // corner park
    [  0, 30, 30, 28, "R" ],
    [ 30, 30, 45, 28, "I" ],   // factory district in the middle
    [ 75, 30, 25, 28, "W" ],   // river running up the east side
    [  0, 58, 55, 22, "P" ],   // big park across the north
    [ 55, 58, 45, 22, "R" ],
];
// ---------------------------------------

// ---- zone code → how many 0.6 mm steps tall ----
// Water lowest, industry tallest. Change the order if you like,
// just keep every zone type on a DIFFERENT step.
function zone_steps(code) =
    code == "W" ? 1 :
    code == "P" ? 2 :
    code == "R" ? 3 :
    code == "C" ? 4 :
    code == "I" ? 5 :
    1;   // unknown code? treat it like water so nothing vanishes

function zone_h(code) = zone_steps(code) * step_h;

$fn = 48;

// ---- legend bar settings (the key along the front edge) ----
legend      = ["W", "P", "R", "C", "I"];  // shortest to tallest
legend_d    = 14;    // extra plate depth for the legend strip
lg_w        = 13;    // width of one legend step
lg_gap      = 4;     // gap between legend steps

// ---- base plate (map + legend strip, one solid slab) ----
translate([0, -legend_d, 0])
    cube([map_w, map_d + legend_d, base_h]);

// ---- the zones ----
// Each rectangle shrinks in by half a street on every side, so
// two neighboring zones automatically leave a full street
// between them. The street IS the gap — nothing to model!
for (z = zones)
    translate([z[0] + street_w/2, z[1] + street_w/2, base_h])
        cube([z[2] - street_w, z[3] - street_w, zone_h(z[4])]);

// ---- the legend: one step of each height, with its letter ----
// This is the map key. Paint each step the same color as its
// zone type and anyone can read your map.
for (i = [0 : len(legend) - 1]) {
    code = legend[i];
    lx   = 4 + i * (lg_w + lg_gap);
    // the step
    translate([lx, -legend_d + 2, base_h])
        cube([lg_w, legend_d - 4, zone_h(code)]);
    // the letter, embossed 0.6 mm on top of the step
    translate([lx + lg_w/2, -legend_d/2, base_h + zone_h(code)])
        linear_extrude(step_h)
            text(code, size = 5, halign = "center", valign = "center");
}

// IDEAS TO TRY (or ask Claude):
//  - redraw the zones as YOUR neighborhood — walk it on Google
//    Maps and decide what's really R, C, I, P, or W
//  - add a "M" mixed-use zone (shops below, homes above) — give
//    it step 6 and add it to the legend
//  - emboss the letter codes onto the big zones too, not just
//    the legend
//  - make it a tile system: keep map_w the same and design a
//    second map that continues your streets across the edge
