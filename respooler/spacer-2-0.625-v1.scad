//
// Creates a spacer for fitting a 2" spool on a 5/8" axle,
// e.g. a standard 10# MIG wire roll.  For making a re-spooler.
//
// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 
// International License. To view a copy of this license, visit 
// http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to 
// Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
//

// Values specified in inches ...
mmPerInch = 25.4;

// Parameterized values

// Desired outerDiam = 2.000, actual = 1.920, delta = 0.080
// Desired innerDiam = 0.625, actual = 0.560, delta = 0.060

outerDiam = 2 * mmPerInch;
innerDiam = (5.0 / 8.0) * mmPerInch;
height = 2 * mmPerInch;  // max thickness of spool
epsilon = 0.001 * mmPerInch;
spokeThickness = 0.20 * mmPerInch;
innerWallThickness = 0.200 * mmPerInch;
outerWallThickness = 0.200 * mmPerInch;

module spoke()
{
    translate([0, 0, height/2]) 
    {
        union() {
            cube([outerDiam, spokeThickness, height + epsilon], center = true);
            rotate(60) {
                cube([outerDiam, spokeThickness, height + epsilon], center = true);
            }
            rotate(120) {
                cube([outerDiam, spokeThickness, height + epsilon], center = true);
            }
        }
    }
}

module outerCyl()
{
    difference() {
        cylinder(h = height, d = outerDiam, center = false);
        
        // remove inside to make a 'shell', centered + extra height to avoid rounding artifacts
        cylinder(h = 3*height, d = outerDiam - 2*outerWallThickness, center = true);
    }
}


difference()
{
    union() {
        outerCyl();
        cylinder(h = height + epsilon, d = innerDiam + 2*innerWallThickness, center = false);
        spoke();
    }
    
    // remove hole for axle, centered + extra height to avoid rounding artifacts
    cylinder(h = 3*height, d = innerDiam, center = true);
}
