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
// Free fit for 3/8 is 0.3970
// Free fit for 5/8 (inner axle hole) is 0.6562
// Measured hole diameter is 2.060, allowing 0.015 for clearance.
// See https://littlemachineshop.com/reference/tapdrill.php
outerDiam = 2.00 * mmPerInch;
innerDiam = 0.3970 * mmPerInch;
height = 0.375 * mmPerInch;  // max thickness of spool

// Bolt hole constants.
guideHoleDiam = 0.125;
guideHoleDistFromCenter = 0.75 * mmPerInch;

// Hex head constants - the hex head is to jam the spring into, so it doesn't twist.
// For 1/2" spring.
// 2 Measurements - typical dist across the corners and max head thickness.
// See http://www.reglover.com/desktop/reg/resources_dimension_bolt_hex.php
boltHexHeadCornersDistSmaller = 0.5312 * mmPerInch; // 7/16 head
boltHexHeadHeightSmaller = 0.188 * mmPerInch;


module guideHole(holeDiam)
{
    translate([guideHoleDistFromCenter, 0, 0]) {
        cylinder(h = 3*height, d = guideHoleDiam * mmPerInch, center = true);
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
         rotate(30) guideHole(0.125 * mmPerInch);
         rotate(60) guideHole(0.125 * mmPerInch);
         rotate(90) guideHole(0.125 * mmPerInch);
         rotate(120) guideHole(0.125 * mmPerInch);
         rotate(150) guideHole(0.125 * mmPerInch);
         rotate(180) guideHole(0.125 * mmPerInch);
         rotate(210) guideHole(0.125 * mmPerInch);
         rotate(240) guideHole(0.125 * mmPerInch);
         rotate(270) guideHole(0.125 * mmPerInch);
         rotate(300) guideHole(0.125 * mmPerInch);
         rotate(330) guideHole(0.125 * mmPerInch);
    }
}

