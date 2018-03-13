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
// Free fit for 5/8 (inner axle hole) is 0.6562
// Measured hole diameter is 2.060, allowing 0.015 for clearance.
// See https://littlemachineshop.com/reference/tapdrill.php
outerDiam = 2.045 * mmPerInch;
innerDiam = 0.6562 * mmPerInch;
height = 2.000 * mmPerInch;  // max thickness of spool

// Bolt hole constants.
// Free fit for 1/4 and 5/16 is 0.2660 and 0.3320, respectively.
// See https://littlemachineshop.com/reference/tapdrill.php
boltHoleDiamSmaller = 0.2660 * mmPerInch;
boltHoleDiamLarger = 0.3320 * mmPerInch;
boltHoleDistFromCenter = (outerDiam + innerDiam) / 4.0;

// Hex head constants
// 2 Measurements - typical dist across the corners and max head thickness.
// See http://www.reglover.com/desktop/reg/resources_dimension_bolt_hex.php
boltHexHeadCornersDistSmaller = 0.505 * mmPerInch; // 7/16 head
boltHexHeadHeightSmaller = 0.188 * mmPerInch;
boltHexHeadCornersDistLarger = 0.577 * mmPerInch; // 1/2 head
boltHexHeadHeightLarger = 0.235 * mmPerInch;


module rimHoleOpposingPairs(holeDiam, hexHeadCornersDist, hexHeadHeight = 0, headDown = 0)
{
   union()
   {
      if (hexHeadHeight > 0)
      {
         if (headDown == 0)
         {
            translate([boltHoleDistFromCenter, 0, height - hexHeadHeight]) {
               cylinder(h = 2* hexHeadHeight, d = hexHeadCornersDist, center = false, $fn = 6);
            }
            translate([-boltHoleDistFromCenter, 0, height - hexHeadHeight]) {
               cylinder(h = 2* hexHeadHeight, d = hexHeadCornersDist, center = false, $fn = 6);
            }
         }
         else
         {
            translate([boltHoleDistFromCenter, 0, -hexHeadHeight]) {
               cylinder(h = 2* hexHeadHeight, d = hexHeadCornersDist, center = false, $fn = 6);
            }
            translate([-boltHoleDistFromCenter, 0, -hexHeadHeight]) {
               cylinder(h = 2* hexHeadHeight, d = hexHeadCornersDist, center = false, $fn = 6);
            }
         }
      }
      translate([boltHoleDistFromCenter, 0, 0]) {
         cylinder(h = 3*height, d = holeDiam, center = true);
      }
      translate([-boltHoleDistFromCenter, 0, 0]) {
         cylinder(h = 3*height, d = holeDiam, center = true);
      }
   }
}

difference()
{
    cylinder(h = height, d = outerDiam, center = false);
    union() {
        cylinder(h = 3*height, d = innerDiam, center = true);
        rimHoleOpposingPairs(boltHoleDiamSmaller, boltHexHeadCornersDistSmaller, boltHexHeadHeightSmaller);
        rotate(45)  rimHoleOpposingPairs(boltHoleDiamLarger, boltHexHeadCornersDistLarger, 0);
        rotate(90)  rimHoleOpposingPairs(boltHoleDiamSmaller, boltHexHeadCornersDistSmaller, boltHexHeadHeightSmaller);
        rotate(135) rimHoleOpposingPairs(boltHoleDiamLarger, boltHexHeadCornersDistLarger, 0);
    }
}

