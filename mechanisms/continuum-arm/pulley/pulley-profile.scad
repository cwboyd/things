

mmPerInch = 2.54;
diam = 3.0 * mmPerInch;
thick = 0.375 * mmPerInch;
slotDepth = 0.25 * mmPerInch;
slotWidth = 0.030 * mmPerInch;

polygon(points = 
    [ [0, thick/2],         // top center
    [diam/2, thick/2],      // top outside edge
    [diam/2 - slotDepth, slotWidth/2],   // top of inside slot
    [diam/2 - slotDepth, -slotWidth/2],  // bottom of inside slot
    [diam/2, -thick/2],     // bottom outside edge
    [0, -thick/2]           // bottom center
 ]);