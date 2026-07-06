// ============================================================
// CITY TILE — design a district as a SYSTEM
// ============================================================
// One tile = one city block with streets on two sides. Print
// lots of them and they line up into a growing district — the
// same idea as GreebleCity and miniCITIES, but this one is YOURS.
//
// The system rule that makes tiles compatible:
//   * every tile is `tile` mm square
//   * roads always run along the +X and +Y edges, `road_w` wide
// Any tile that follows the rule connects to any other. That's
// how modular city kits work.
//
// Print: flat, no supports, ~30-45 min per tile.
// Multi-color: paint the road, sidewalk, and grass different
// colors in Bambu Studio — they're at different heights, so
// the height-range painting tool does it in seconds.
// ============================================================

// ------------ CHANGE THESE ------------
tile        = 60;    // tile edge length (keep the same for ALL tiles!)
road_w      = 11;    // road width along two edges (same for all tiles!)
sidewalk_w  = 3;     // sidewalk strip beside the road
base_h      = 2.5;   // tile thickness (road surface height)
sidewalk_h  = 0.8;   // sidewalks sit this much above the road
pads        = 2;     // building pads per row (pads x pads grid): 1, 2 or 3
pad_h       = 1.2;   // building pad height above the block
with_dashes = true;  // dashed center line on the roads
// ---------------------------------------

block = tile - road_w - sidewalk_w;   // the buildable part

$fn = 48;

// ---- base: the whole tile at road height ----
cube([tile, tile, base_h]);

// ---- the city block: everything that isn't road ----
// (sits at sidewalk height; roads stay recessed along +X/+Y edges)
translate([0, 0, base_h])
    cube([block + sidewalk_w, block + sidewalk_w, sidewalk_h]);

// ---- building pads: raised plinths you design buildings for ----
pad_gap  = 4;
pad_size = (block - pad_gap * (pads + 1)) / pads;
for (ix = [0 : pads - 1])
    for (iy = [0 : pads - 1])
        translate([pad_gap + ix * (pad_size + pad_gap),
                   pad_gap + iy * (pad_size + pad_gap),
                   base_h + sidewalk_h])
            cube([pad_size, pad_size, pad_h]);

// ---- dashed center lines on the roads (paintable lane marks) ----
if (with_dashes) {
    dash = 3;
    for (x = [2 : dash * 2 : tile - dash - 2])
        translate([x, tile - road_w/2 - 0.5, base_h])
            cube([dash, 1, 0.4]);
    for (y = [2 : dash * 2 : tile - road_w - dash - 2])
        translate([tile - road_w/2 - 0.5, y, base_h])
            cube([1, dash, 0.4]);
}

// IDEAS TO TRY (or ask Claude):
//  - a park tile: no pads, add trees (cylinder trunk + sphere top)
//  - a plaza tile with a fountain in the middle
//  - a transit tile: recess a train trench diagonally through it
//  - buildings that FIT the pads: design them in
//    parametric-building.scad with bldg_w = pad_size
//  - a corner tile / T-junction: move the roads to different edges
//    (keep the tile size the same so it still connects!)
