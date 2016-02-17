
//
// y-axis-shim.scad
//
// Parametric shim to fix bearing sink for Y-axis into part #1116
//

//outsideWidthInches = 0.866;
outsideWidthInches = 0.746; // made narrower to avoid interference with screw.
outwideLengthInches = 2.250;
slotWidthInches = 0.400;
slotLengthInches = 1.935;
tieWidthInches = 0.075;
tieLengthInches = 0.125;
tieSpacingWidthInches = 0.670;
tieSpacingLengthInches = 0.571;
tieDistaceToSlotInches = 0.097;
thicknessInches = 0.100;

tieDistanceFromEdgeInches = 0.191;
tieDistanceFrom1to2Inches = 0.571;
tieDistanceFrom2to3Inches = 0.363;
tieDistanceFrom3to4Inches = tieDistanceFrom1to2Inches;

tieHole1_XInches = -(tieDistanceFrom2to3Inches/2) - tieDistanceFrom1to2Inches;
tieHole2_XInches = -(tieDistanceFrom2to3Inches/2);
tieHole3_XInches =  (tieDistanceFrom2to3Inches/2);
tieHole4_XInches = (tieDistanceFrom2to3Inches/2) + tieDistanceFrom1to2Inches;
tieHoleYInches   = (slotWidthInches/2) + tieDistaceToSlotInches;


// SCAD and STL works in mm however.
mmPerInch = 25.4;

outsideWidth        = mmPerInch * outsideWidthInches;
outwideLength       = mmPerInch * outwideLengthInches;
slotWidth           = mmPerInch * slotWidthInches;
slotLength          = mmPerInch * slotLengthInches;
tieWidth            = mmPerInch * tieWidthInches;
tieLength           = mmPerInch * tieLengthInches;
tieSpacingWidth     = mmPerInch * tieSpacingWidthInches;
tieSpacingLength    = mmPerInch * tieSpacingLengthInches;
tieDistaceToSlot    = mmPerInch * tieDistaceToSlotInches;
thickness           = mmPerInch * thicknessInches;
tieDistanceFromEdge = mmPerInch * tieDistanceFromEdgeInches;
tieDistanceFrom1to2 = mmPerInch * tieDistanceFrom1to2Inches;
tieDistanceFrom2to3 = mmPerInch * tieDistanceFrom2to3Inches;
tieDistanceFrom3to4 = mmPerInch * tieDistanceFrom3to4Inches;


tieHole1_X                = mmPerInch * tieHole1_XInches;
tieHole2_X                = mmPerInch * tieHole2_XInches;
tieHole3_X                = mmPerInch * tieHole3_XInches;
tieHole4_X                = mmPerInch * tieHole4_XInches;
tieHoleY                  = mmPerInch * tieHoleYInches;



difference() {

   // Outside bounds
   translate([0,0,thickness/2]) {
      cube([outwideLength, outsideWidth, thickness], center=true);
   }


   // Bearing slot.
   translate([0,0,thickness/2]) {
      cube([slotLength, slotWidth, thickness], center=true);
   }

   // Holes for tie strap.
   translate([tieHole1_X,tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole2_X,tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole3_X,tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole4_X,tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole1_X,-tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole2_X,-tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole3_X,-tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
   translate([tieHole4_X,-tieHoleY,thickness/2]) {
      cube([tieLength, tieWidth, thickness], center=true);
   }
}


   




