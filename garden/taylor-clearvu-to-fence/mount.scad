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

//
// FASTENERS
// TODO: measure actual bolts!
//
// Parameterized values for outside and inside holes and height.
// Free / standard fit for M5 bolts is 5.5 mm.
// For nut & bolt, I rounded dimensions up to next largest integer millimeter.
// See https://littlemachineshop.com/images/Gallery/PDF/TapDrillSizes.pdf
mm_bolt_length = 40;
mm_bolt_diam = 5.5;
mm_bolt_socket_diam = 8;
mm_bolt_socket_depth = 4;
mm_bolt_total_length = mm_bolt_length + mm_bolt_socket_depth;
mm_nut_thickness = 5;
mm_nut_diam = 9;
mm_washer_thickness = 1;
mm_washer_diam = 10;

// Calculated reference centerlines from external dimensions
loc_x_width_centerline = mm_mount_width / 2;
loc_y_depth_centerline = mm_mount_depth / 2;
loc_z_thickness_centerline = mm_mount_height / 2;

//
// CALCULATED LOCATIONS
//
// The separation plane must be close to the center of the fence hole (e.g. a true
// diameter and not just a chord).  If it did not, then either the cap or the holder
// would not fit around it.
//

xyz_fence_hole = [
    loc_x_width_centerline,
    mm_mount_depth - mm_fence_side_wall_thickness - diam_fence_post/2,
    -epsilon];
xyz_gauge_hole = [
    loc_x_width_centerline,
    0 + mm_fence_side_wall_thickness + diam_gauge_bottomCap/2,
    -epsilon];
xyz_separation_plane = [
    0,
    mm_mount_depth - mm_fence_side_wall_thickness - diam_fence_post/2,
    -epsilon/10];
xyz_bolt_hole_one = [
    mm_fence_side_wall_thickness / 2,
    mm_mount_depth, 
    loc_z_thickness_centerline];
xyz_bolt_hole_two = [
    mm_mount_width - mm_fence_side_wall_thickness / 2,
    mm_mount_depth, 
    loc_z_thickness_centerline];
xyz_nut_hole_one = [
    mm_fence_side_wall_thickness / 2,
    mm_mount_depth - mm_bolt_total_length + mm_nut_thickness, 
    loc_z_thickness_centerline - epsilon];
xyz_nut_hole_two = [
    mm_mount_width - mm_fence_side_wall_thickness / 2,
    mm_mount_depth - mm_bolt_total_length + mm_nut_thickness, 
    loc_z_thickness_centerline - epsilon];
    





difference()
{
    cube([mm_mount_width, mm_mount_depth, mm_mount_height], center=false);
    translate(xyz_fence_hole) {
        cylinder(h = mm_mount_height+2*epsilon, d=diam_fence_post);
    }
    translate(xyz_gauge_hole) {
        cylinder(h = mm_mount_height+2*epsilon, d=diam_gauge_bottomCap);
    }
    #translate(xyz_nut_hole_one) {
        cube([mm_nut_diam, mm_nut_thickness, mm_mount_height + 2*epsilon], center=true);
    }
    %translate(xyz_nut_hole_two) {
        cube([mm_nut_diam, mm_nut_thickness, mm_mount_height + 2*epsilon], center=true);
    }
    #translate(xyz_separation_plane) {
        cube([300, epsilon, 100], center=true);
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

