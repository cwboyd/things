//
// Parametric design for a pulley with holes compatible with Actobotics 0.770"
// servo horns, with a center hole to permit subsequent attachment of horn to servo
// by feeding through a screw for the shaft.
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

//
// Parameters for the profile of the pulley.  We revolve the profile around the Z-axis to produce the pulley.
//
// The pulley is size off of the pulley track diameter (e.g. pulleyInsideDiam), because this is what matters
// for translating rotation to linear distance.  The side walls are there just to keep to string from falling
// off the pulley and the overhang angle in there to permit this part to be FDM printable.  Additionally, 
// because we don't want the outside edge to be sharp, a lipThickness is added in ... because if the string 
// falls outside of the track and then engages, you don't want fraying.
//

pulleyInsideDiam = 3.0 * mmPerInch;
thick = 0.375 * mmPerInch;             // overall thickness
lipThickness = 0.040 * mmPerInch;      // outer edge flat portion - so we don't have a sharp edge
slotWidth = 0.090 * mmPerInch;
slotOverhangAngle = 45.0;              // degrees, overhangs should be less than or equal to 45 degrees

// Thickness of the overhang is half diff in thick and slotWidth
alpha = ( (thick - slotWidth) / 2 )  - lipThickness;

module pulleyProfile()
{
   polygon(points = [ 
      [0, slotWidth/2],                                                               // start of slot cut out
      [0, thick/2],                                                                   // top center
      [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), thick/2],                 // top outside edge
      [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), thick/2 - lipThickness],  // top inside edge
      [pulleyInsideDiam/2, slotWidth/2],                                              // top of inside slot
      [pulleyInsideDiam/2, -slotWidth/2],                                             // bottom of inside slot
      [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), -thick/2 + lipThickness], // bottom inside edge
      [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), -thick/2],                // bottom outside edge
      [0, -thick/2],                                                                  // bottom center
      [0, -slotWidth/2],                                                              // end of slot cut out
   ]);
}

rotate_extrude($fn = 100) {
   pulleyProfile();
}

