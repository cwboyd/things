

mmPerInch = 25.4;
pulleyInsideDiam = 3.0 * mmPerInch;
thick = 0.375 * mmPerInch;   // overall thickness
lipThickness = 0.040 * mmPerInch; // outer edge flat portion - so we don't have a sharp edge
slotWidth = 0.090 * mmPerInch;
slotOverhangAngle = 45.0;   // degrees, overhangs should be less than or equal to 45 degrees

// Thickness of the overhang is half diff in thick and slotWidth
alpha = (thick - lipThickness - slotWidth) / 2;

module pulleyProfile()
{
    polygon(points = [ 
        [0, slotWidth/2],                                                 // start of slot cut out
        [0, thick/2],                                                     // top center
        [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), thick/2],   // top outside edge
        [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), thick/2 - lipThickness],   // top inside edge
        [pulleyInsideDiam/2, slotWidth/2],                                // top of inside slot
        [pulleyInsideDiam/2, -slotWidth/2],                               // bottom of inside slot
        [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), -thick/2 + lipThickness],  // bottom inside edge
        [pulleyInsideDiam/2 + alpha * tan(slotOverhangAngle), -thick/2],  // bottom outside edge
        [0, -thick/2],                                                    // bottom center
        [0, -slotWidth/2],                                                // end of slot cut out
    ]);
}

rotate_extrude($fn = 100) {
    pulleyProfile();
}

