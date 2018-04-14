

mmPerInch = 25.4;

// Tun up precision = slower render time.
$fn = 100;

module servoBounds()
{
    // From drawing at https://www.servocity.com/hs-311-servo
    lengthWiseDistBetweenHolesMM = 13.47 + 33.79;
    widthWiseDistBetweenHolesMM = 10.17;
    mountingHoleDiam = 0.125 * mmPerInch;
    
    cube([40, 20, 30], center = true);
    
    // Mounting screw holes
    translate([lengthWiseDistBetweenHolesMM/2, widthWiseDistBetweenHolesMM/2, 0]) {
        cylinder(h = 3*40, d = mountingHoleDiam, center = true);
    }
    translate([lengthWiseDistBetweenHolesMM/2, -widthWiseDistBetweenHolesMM/2, 0]) {
        cylinder(h = 3*40, d = mountingHoleDiam, center = true);
    }
    translate([-lengthWiseDistBetweenHolesMM/2, widthWiseDistBetweenHolesMM/2, 0]) {
        cylinder(h = 3*40, d = mountingHoleDiam, center = true);
    }
    translate([-lengthWiseDistBetweenHolesMM/2, -widthWiseDistBetweenHolesMM/2, 0]) {
        cylinder(h = 3*40, d = mountingHoleDiam, center = true);
    }
}

//minkowski() {
difference() {
    translate([-35, -10, -15]) {
        cube([100, 25, 30], center = false);
        hull() 
        {
            translate([10, 25, 0]) cylinder(h = 30, d = 20, center = false);
            translate([85, 25, 0]) cube([15, 20, 30], center = false);

        
        }
        hull() 
        {
            translate([85, 45, 0]) cylinder(h = 30, d = 10, center = false);
            translate([85, 45, 0]) cube([15, 20, 30], center = false);
        }
    }
    servoBounds();
}
hull()
{
            translate([50, -30, -15]) cube([15, 20, 30], center = false);
           translate([50, -5, -15]) cylinder(h = 30, d = 10, center = false);
}
 
//}

