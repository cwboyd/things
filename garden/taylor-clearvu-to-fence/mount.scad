//
// Mounts a Taylor CLEARVU(tm) Jumbo Rain Gauge to a standard, 2 3/8"
// O.D. fence post.
//
// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
// International License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to
// Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
//

// Tun up precision = slower render time.
$fn = 100;

// Values specified in inches ...
mmPerInch = 25.4;
epsilon = 1;

// diam_gauge_largest_allowed is the largest diam of the gauges cross
// section, with a bit more space so it doesn't rub against the post.
diam_cup = 94;
diam_gauge = 45;
diam_gauge_bottomCap = 48;
diam_gauge_largest_allowed = 100;
diam_fence_post = 2.375 * mmPerInch;
diam_largest_hole = max(diam_gauge_largest_allowed, diam_fence_post);
mm_fence_side_wall_thickness = 10;


// outer dimensions
// mm_mount_width = 2 * mm_fence_side_wall_thickness + diam_largest_hole;
mm_mount_width = 2 * mm_fence_side_wall_thickness + diam_fence_post;
mm_mount_depth = 3 * mm_fence_side_wall_thickness + diam_fence_post + diam_gauge_largest_allowed;
mm_mount_height = 10;
// echo("diam_fence_post=", diam_fence_post);
// echo("mm_mount_width=", mm_mount_width);
// echo("mm_mount_depth=", mm_mount_depth);


// calculated locations
loc_x_width_centerline = mm_mount_width / 2;
loc_y_depth_centerline = mm_mount_depth / 2;
xyz_fence_hole = [
    loc_x_width_centerline,
    mm_mount_depth - mm_fence_side_wall_thickness - diam_fence_post/2,
    -epsilon];
xyz_gauge_hole = [
    loc_x_width_centerline,
    0 + mm_fence_side_wall_thickness + diam_gauge_bottomCap/2,
    -epsilon];


// Parameterized values for outside and inside holes and height.
// Free fit for 1/4 and 5/16 is 0.2660 and 0.3320, respectively.
// Free fit for 5/8 (inner axle hole) is 0.6562
// Measured hole diameter is 2.060, allowing 0.015 for clearance.
// See https://littlemachineshop.com/reference/tapdrill.php
outerDiam = 2.00 * mmPerInch;
innerDiam = 0.2660 * mmPerInch;
height = 0.5 * mmPerInch;  // max thickness of spool

// Bolt hole constants.
// Free fit for 1/4 and 5/16 is 0.2660 and 0.3320, respectively.
// See https://littlemachineshop.com/reference/tapdrill.php
boltHoleDiamSmaller = 0.2660 * mmPerInch;
boltHoleDiamLarger = 0.3320 * mmPerInch;
//why?
//boltHoleDistFromCenter = (outerDiam + innerDiam) / 4.0;
boltHoleDistFromCenter = 0.75 * mmPerInch;

// Hex head constants - 1/4 bolt for center.
// 2 Measurements - typical dist across the corners and max head thickness.
// See http://www.reglover.com/desktop/reg/resources_dimension_bolt_hex.php
boltHexHeadCornersDistSmaller = 0.505 * mmPerInch; // 7/16 head
boltHexHeadHeightSmaller = 0.188 * mmPerInch;


difference()
{
    cube([mm_mount_width, mm_mount_depth, mm_mount_height], center=false);
    translate(xyz_fence_hole) {
        cylinder(h = mm_mount_height+2*epsilon, d=diam_fence_post);
    }
    translate(xyz_gauge_hole) {
        cylinder(h = mm_mount_height+2*epsilon, d=diam_gauge_bottomCap);
    }
}


// module guideHole(holeDiam)
// {
//     translate([boltHoleDistFromCenter, 0, 0]) {
//         cylinder(h = 3*height, d = 0.125 * mmPerInch, center = true);
//     }
// }

// difference()
// {
//     cylinder(h = height, d = outerDiam, center = false);

//     union() {
//         cylinder(h = 3*height, d = innerDiam, center = true);
//          translate([0, 0, height - boltHexHeadHeightSmaller]) {
//             cylinder(h = 2* boltHexHeadHeightSmaller, d = boltHexHeadCornersDistSmaller, center = false, $fn = 6);
//          }
//          guideHole(0.125 * mmPerInch);
//          rotate(90) guideHole(0.125 * mmPerInch);
//          rotate(180) guideHole(0.125 * mmPerInch);
//          rotate(270) guideHole(0.125 * mmPerInch);
//     }
// }

