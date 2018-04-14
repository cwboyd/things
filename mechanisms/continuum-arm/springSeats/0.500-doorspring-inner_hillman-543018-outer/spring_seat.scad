/*************************************************************************** 
Spring seat to maintain spring alignment and even pressure when compressed.
Author: Mike Thompson (thingyverse: mike_linus)
Date Last Modified: 16/03/2013
Description: change the variable values to print an inside or outside seat of the required dimensions.  The inside seat is more compact for tighter spaces.  The outside version hides the base of the spring for but looks chunkier.
****************************************************************************/

// From: https://www.thingiverse.com/thing:62357

// Bolt Hole Free Fit diameters from:
// https://littlemachineshop.com/reference/tapdrill.php

/*globals*/
mmPerInch = 25.4;
resolution=50;
bolt_hole_radius= 0.5 * (0.5312) * mmPerInch;

// for Lowes Hillman 543018 23/32 x 3 1/2 x 0.041"
// should also work with Century Spring C-756, which has same dimensions.

//seat_radius=(0.625) * mmPerInch; // (inside)
//seat_radius=0.5 * (23/32) * mmPerInch; // (outside) 
seat_radius=0.5 * (0.7656) * mmPerInch; // (outside) 
support_height=(3/8) * mmPerInch;

//"inside" or "outside"
//seat_type="inside";
seat_type="outside";
thickness=(1/8)*mmPerInch;

$fn=resolution;

module base(){
	cylinder(r=seat_radius,h=thickness);
	cylinder(r=seat_radius-thickness-0.25,h=support_height);
}

if (seat_type=="inside"){
	difference(){
		base();
		cylinder(r=bolt_hole_radius,h=support_height);
	}
}
else {
	difference(){
		cylinder(r=seat_radius+thickness,h=support_height);
		translate([0,0,thickness])cylinder(r=seat_radius,h=support_height);
		cylinder(r=bolt_hole_radius,h=support_height);
	}
}
