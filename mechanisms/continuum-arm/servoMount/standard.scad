

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

baseHoleDiam = 0.1250 * mmPerInch;
boltHeadSeatDiam = 0.500 * mmPerInch;

difference() {
   translate([-40, -10, -15]) {
      cube([100, 25, 30], center = false);

      // back side draft angle + rounded upper corner
      hull() {
         translate([10, 25, 0]) cylinder(h = 30, d = 20, center = false);
         translate([85, 25, 0]) cube([15, 20, 30], center = false);
      }
      // back size foot
      hull() {
         translate([85, 45, 0]) cylinder(h = 30, d = 10, center = false);
         translate([85, 45, 0]) cube([15, 20, 30], center = false);
      }
      // servo side foot
      hull() {
         translate([85, -20, 0]) cube([15, 20, 30], center = false);
         translate([85, 0, 0]) cylinder(h = 30, d = 10, center = false);
      }
   }
   servoBounds();

   // holes in the base
   translate([55, -20, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = baseHoleDiam, center = true);
   translate([55, 45, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = baseHoleDiam, center = true);

   // seats on the top face to permit flat contact
   translate([35, -20, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = boltHeadSeatDiam, center = true);
   translate([35, 45, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = boltHeadSeatDiam, center = true);
   
   // reinforcement plate bolt holes (one side must be open, to permit motor insertion)

}

   translate([-30, 0, 0]) rotate([90, 0, 0]) cylinder(h = 300, d = baseHoleDiam, center = true);
   translate([30, 0, 0]) rotate([90, 0, 0]) cylinder(h = 300, d = baseHoleDiam, center = true);

 
//}

