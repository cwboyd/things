//
// Parametric design for a pulley with holes compatible with Actobotics 0.770"
// servo horns, with a center hole to permit subsequent attachment of horn to servo
// by feeding through a screw for the shaft.
//
// This pulley lacks a side channel, unless the v2 version.
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

// innerDiam has to be at least 0.265, to pass the spline-horn screw head through
outerDiam = 3.00 * mmPerInch;
innerDiam = 0.300 * mmPerInch;
height = 0.2005 * mmPerInch;  // max thickness of spool

// Bolt hole constants. guideHole must pass #6 bolt.
// See https://littlemachineshop.com/reference/tapdrill.php
// Accomodates Actobatics servo horns with 0.770" spacing, #6 bolts
guideHoleDiam = 0.1495 * mmPerInch;
guideHoleDistFromCenter = 0.5 * 0.770 * mmPerInch;


module guideHole(holeDiam, distanceFromCenter)
{
    translate([distanceFromCenter, 0, 0]) {
        cylinder(h = 3*height, d = holeDiam, center = true);
    }
}

module guideHole3Radial(holeDiam, distanceFromCenter)
{
     guideHole(guideHoleDiam, guideHoleDistFromCenter);
     guideHole(guideHoleDiam, 2*guideHoleDistFromCenter);
     guideHole(guideHoleDiam, 3*guideHoleDistFromCenter);
}

difference()
{
    cylinder(h = height, d = outerDiam, center = false);

    union() {
        cylinder(h = 3*height, d = innerDiam, center = true);
         
         guideHole3Radial(guideHoleDiam, guideHoleDistFromCenter);
         rotate(90) guideHole3Radial(guideHoleDiam, guideHoleDistFromCenter);
         rotate(180) guideHole3Radial(guideHoleDiam, guideHoleDistFromCenter);
         rotate(270) guideHole3Radial(guideHoleDiam, guideHoleDistFromCenter);
  }
}

