//
// Creates a spacer for fitting a 2" spool on a 5/8" axle,
// e.g. a standard 10# MIG wire roll.  For making a re-spooler.
// This version uses standard bolt holes (2 sizes at 90 deg cross, shifted
// by 45 deg) to permit attaching a handle.
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


module guideHole(holeDiam)
{
    translate([boltHoleDistFromCenter, 0, 0]) {
        cylinder(h = 3*height, d = 0.125 * mmPerInch, center = true);
    }
}

difference()
{
    cylinder(h = height, d = outerDiam, center = false);

    union() {
        cylinder(h = 3*height, d = innerDiam, center = true);
         translate([0, 0, height - boltHexHeadHeightSmaller]) {
            cylinder(h = 2* boltHexHeadHeightSmaller, d = boltHexHeadCornersDistSmaller, center = false, $fn = 6);
         }
         guideHole(0.125 * mmPerInch);
         rotate(45) guideHole(0.125 * mmPerInch);
         rotate(90) guideHole(0.125 * mmPerInch);
         rotate(135) guideHole(0.125 * mmPerInch);
         rotate(180) guideHole(0.125 * mmPerInch);
         rotate(225) guideHole(0.125 * mmPerInch);
         rotate(270) guideHole(0.125 * mmPerInch);
         rotate(315) guideHole(0.125 * mmPerInch);
    }
}

