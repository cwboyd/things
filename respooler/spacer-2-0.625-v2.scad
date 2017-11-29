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

// Values specified in inches ...
mmPerInch = 25.4;

// Parameterized values
outerDiam = 2 * mmPerInch;
innerDiam = (5.0 / 8.0) * mmPerInch;
height = 2 * mmPerInch;  // max thickness of spool

// Bolt hole constants.
boltHoleDiamSmaller = 0.25 * mmPerInch;
boltHoleDiamLarger = (5.0 / 16.0) * mmPerInch;
boltHoleDistFromCenter = (outerDiam + innerDiam) / 4.0;


module rimHoleOpposingPairs(holeDiam) 
{
    union() {
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
        rimHoleOpposingPairs(boltHoleDiamSmaller);
        rotate(45)  rimHoleOpposingPairs(boltHoleDiamLarger);
        rotate(90)  rimHoleOpposingPairs(boltHoleDiamSmaller);
        rotate(135) rimHoleOpposingPairs(boltHoleDiamLarger);
    }
}

