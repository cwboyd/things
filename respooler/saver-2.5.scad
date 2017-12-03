//
// Backing plate and spacer for a damaged, donor spool ...
// Spacer for fitting a 2" spool on a 5/8" axle, e.g. a standard 10# 
// MIG wire roll.  Backer should alleviate material slipping off of
// spool.
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

// Parameterized values for outside and inside holes and hubHeight.
// Free fit for 5/8 (inner axle hole) is 0.6562
// Measured hole diameter is 2.060, allowing 0.015 for clearance.
// See https://littlemachineshop.com/reference/tapdrill.php
hubOuterDiam = 2.045 * mmPerInch;
hubInnerDiam = 0.6562 * mmPerInch;
hubHeight = 2.500 * mmPerInch;  // max thickness of spool

// Bolt hole constants.
// Free fit for 1/4 and 5/16 is 0.2660 and 0.3320, respectively.
// See https://littlemachineshop.com/reference/tapdrill.php
boltHoleDiamSmaller = 0.2660 * mmPerInch;
boltHoleDiamLarger = 0.3320 * mmPerInch;
boltHoleDistFromCenter = (hubOuterDiam + hubInnerDiam) / 4.0;

// Hex head constants
// 2 Measurements - typical dist across the corners and max head thickness.
// See http://www.reglover.com/desktop/reg/resources_dimension_bolt_hex.php
boltHexHeadCornersDistSmaller = 0.505 * mmPerInch; // 7/16 head
boltHexHeadHeightSmaller = 0.188 * mmPerInch;
boltHexHeadCornersDistLarger = 0.577 * mmPerInch; // 1/2 head
boltHexHeadHeightLarger = 0.235 * mmPerInch;

// Saver/backer portion ... bottom disk or hat to replace damanged spool
backerOuterDiam = 7.000 * mmPerInch;
backerThickness = 0.250 * mmPerInch;
backerSpokeThickness = 0.750 * mmPerInch;
innerWallThickness = 0.200 * mmPerInch;
outerWallThickness = 0.750 * mmPerInch;
epsilon = 0.001 * mmPerInch;

module backerSpoke()
{
   translate([0, 0, backerThickness/2]) 
   {
      union() {
         cube([backerOuterDiam, backerSpokeThickness, backerThickness + epsilon], center = true);
         rotate(60) {
            cube([backerOuterDiam, backerSpokeThickness, backerThickness + epsilon], center = true);
         }
         rotate(120) {
            cube([backerOuterDiam, backerSpokeThickness, backerThickness + epsilon], center = true);
         }
      }
   }
}

module backerOuterCyl()
{
   difference() {
      cylinder(h = backerThickness, d = backerOuterDiam, center = false);

      // remove inside to make a 'shell', centered + extra backerThickness to avoid rounding artifacts
      cylinder(h = 3*backerThickness, d = backerOuterDiam - 2*outerWallThickness, center = true);
   }
}

module rimHoleOpposingPairs(holeDiam, hexHeadCornersDist, hexHeadHeight = 0, headDown = 0)
{
   union()
   {
      if (hexHeadHeight > 0)
      {
         if (headDown == 0)
         {
            translate([boltHoleDistFromCenter, 0, hubHeight - hexHeadHeight]) {
               cylinder(h = 2* hexHeadHeight, d = hexHeadCornersDist, center = false, $fn = 6);
            }
            translate([-boltHoleDistFromCenter, 0, hubHeight - hexHeadHeight]) {
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
         cylinder(h = 3*hubHeight, d = holeDiam, center = true);
      }
      translate([-boltHoleDistFromCenter, 0, 0]) {
         cylinder(h = 3*hubHeight, d = holeDiam, center = true);
      }
   }
}

difference()
{
   union() {
      backerOuterCyl();
      backerSpoke();
      cylinder(h = hubHeight, d = hubOuterDiam, center = false);
   }
   union() {
      cylinder(h = 3*hubHeight, d = hubInnerDiam, center = true);
      rimHoleOpposingPairs(boltHoleDiamSmaller, boltHexHeadCornersDistSmaller, boltHexHeadHeightSmaller);
      rotate(45)  rimHoleOpposingPairs(boltHoleDiamLarger, boltHexHeadCornersDistLarger, 0);
      rotate(90)  rimHoleOpposingPairs(boltHoleDiamSmaller, boltHexHeadCornersDistSmaller, boltHexHeadHeightSmaller);
      rotate(135) rimHoleOpposingPairs(boltHoleDiamLarger, boltHexHeadCornersDistLarger, 0);
   }
}

