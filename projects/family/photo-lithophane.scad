// ============================================================
// PHOTO LITHOPHANE — turn a photo into a backlit 3D print
// ============================================================
// A lithophane is a photo made of THICKNESS instead of ink:
// where the picture is dark, the plastic is thick (blocks
// light); where it's bright, the plastic is thin (glows).
// It looks like a ghostly blob... until you hold it up to a
// lamp or window. Then the photo appears. Magic since the 1800s!
//
// HOW TO MAKE YOURS (4 steps):
//   1. Pick a photo with good contrast (faces + pets work great).
//   2. Shrink it to about 200 pixels wide and save it as a
//      GRAYSCALE .png in this folder. (Any photo app can do
//      this — and use "auto contrast" so it has true blacks
//      AND true whites; washed-out gray photos come out flat.)
//   3. Set image_file + the pixel size below. Render (F6 —
//      it's slow, that's normal: one bump per pixel!).
//   4. No photo yet? Run `python3 make-test-image.py` once and
//      the default test-photo.png renders out of the box.
//
// Print — IMPORTANT, on the H2C print it standing VERTICAL:
// in Bambu Studio rotate it 90° so the picture faces sideways.
// Standing up, the fine nozzle X-Y movement draws the picture
// detail (~0.05 mm precise) instead of chunky 0.2 mm layer
// steps, and light shines through walls, not through top/bottom
// fill patterns. Use WHITE PLA, 100% infill (it's thin anyway),
// slow speed. A small brim helps it stand. ~1-2 hrs.
// ============================================================

// ------------ CHANGE THESE ------------
image_file  = "test-photo.png"; // your grayscale photo (same folder)
image_px_w  = 120;      // your photo's width in pixels
image_px_h  = 90;       // your photo's height in pixels
panel_w     = 80;       // how wide the picture area prints (mm)
min_th      = 0.8;      // thinnest spot (brightest) — glows most
max_th      = 3.0;      // thickest spot (darkest) — blocks light
frame_style = "classic"; // "classic" (stepped), "flat", or "none"
frame_w     = 6;        // frame border width (mm)
// ---------------------------------------

// mm per pixel (the picture keeps its shape — no squishing)
px      = panel_w / (image_px_w - 1);
panel_h = px * (image_px_h - 1);          // picture height comes out of that

// surface() reads brightness as height 0-100, so this squashes
// "100" down to exactly the thickness range you asked for
z_squash = (max_th - min_th) / 100;

frame_th  = max_th + 1;   // frame is a bit prouder than the darkest spot
lip       = 1.5;          // frame overlaps the picture edge by this much

$fn = 48;

// ============ the picture itself ============
// Layer 1: a solid sheet as thick as the BRIGHTEST spot ever gets.
translate([-panel_w/2, -panel_h/2, 0])
    cube([panel_w, panel_h, min_th]);

// Layer 2: the photo as a 3D bumpy landscape on top.
// invert = true flips brightness so DARK pixels become TALL
// bumps — exactly what a lithophane needs.
translate([0, 0, max_th])          // hang the bumps from the max height
    scale([px, px, z_squash])
        surface(file = image_file, invert = true, center = true);

// ============ the picture frame ============
// The frame's inner lip overlaps the picture edge, welding
// everything into one solid piece (and hiding the raw edge).
module frame_ring(grow, h) {       // one rectangular ring
    linear_extrude(h)
        difference() {
            square([panel_w + 2*grow, panel_h + 2*grow], center = true);
            square([panel_w - 2*lip,  panel_h - 2*lip],  center = true);
        }
}

if (frame_style == "flat")
    frame_ring(frame_w, frame_th);
if (frame_style == "classic") {    // two steps, like a real picture frame
    frame_ring(frame_w, frame_th);
    frame_ring(frame_w * 0.45, frame_th + 1.2);
}

// IDEAS TO TRY (or ask Claude):
//  - a hanging hole in the frame, or feet so it stands on a shelf
//  - a lithophane NIGHT LIGHT: curve it around a cheap LED puck
//  - Peter: a city skyline photo — buildings glow, sky stays dark
//  - a 4-photo "window pane" — for-loop of panels in one big frame
