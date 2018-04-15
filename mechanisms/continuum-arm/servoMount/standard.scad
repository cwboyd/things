

mmPerInch = 25.4;

// Thickness of the mount ... can be no more than around 20mm between hole bracket
// and wires, because of interference.
mountThicknessMM = 15.0;

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

// https://littlemachineshop.com/images/gallery/PDF/TapDrillSizes.pdf, M3 uses 3.3 for free fit.
// seat wide, because tools
baseHoleDiam = 3.3;
baseBoltHeadSeatDiam = 0.300 * mmPerInch;

difference() 
{
   translate([-40, -10, -mountThicknessMM/2]) {
      cube([100, 25, mountThicknessMM], center = false);

      // back side draft angle + rounded upper corner
      hull() {
         translate([10, 25, 0]) cylinder(h = mountThicknessMM, d = 20, center = false);
         translate([85, 25, 0]) cube([15, 20, mountThicknessMM], center = false);
      }
      // back size foot
      hull() {
         translate([85, 45, 0]) cylinder(h = mountThicknessMM, d = 10, center = false);
         translate([85, 45, 0]) cube([15, 20, mountThicknessMM], center = false);
      }
      // servo side foot
      hull() {
         translate([85, -20, 0]) cube([15, 20, mountThicknessMM], center = false);
         translate([85, 0, 0]) cylinder(h = mountThicknessMM, d = 10, center = false);
      }
   }
   servoBounds();

   // holes in the base
   translate([55, -20, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = baseHoleDiam, center = true);
   translate([55, 45, 0]) rotate([0, 90, 0]) cylinder(h = 30, d = baseHoleDiam, center = true);

   // seats on the top face to permit flat contact
   #translate([35, -20, 0]) rotate([0, 90, 0]) cylinder(h = 20, d = baseBoltHeadSeatDiam, center = true);
   #translate([35, 45, 0]) rotate([0, 90, 0]) cylinder(h = 20, d = baseBoltHeadSeatDiam, center = true);
   
   // reinforcement plate bolt holes (one side must be open, to permit motor insertion)
   translate([-30, 0, 0]) rotate([90, 0, 0]) cylinder(h = 80, d = baseHoleDiam, center = true);
   translate([30, 0, 0]) rotate([90, 0, 0]) cylinder(h = 80, d = baseHoleDiam, center = true);

   // And their sets on the back side, which is not flat
   translate([-30, 40, 0]) rotate([90, 0, 0]) cylinder(h = 40, d = baseBoltHeadSeatDiam, center = true);
   translate([30, 40, 0]) rotate([90, 0, 0]) cylinder(h = 40, d = baseBoltHeadSeatDiam, center = true);

}


