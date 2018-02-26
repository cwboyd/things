// PRUSA Mendel  
// Belt clamp
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
//
// modified by neurofun - https://www.thingiverse.com/thing:21731
// GT2 belt profile logic from https://www.thingiverse.com/thing:620755
//
// Works with https://www.thingiverse.com/thing:133065 for GT2, original
// was for MXL only ... and I had issues cracking this piece.
//
// Printed long end up (e.g. along Z axis)
//

include <configuration.scad>
include <MCAD/polyholes.scad>

module teeth(width, pitch, radius, inner_radius)
{
    circle(r = radius, $fn = 32);
    
    for (x = [-1, 1])
    {
        translate([x * (radius + inner_radius), 0])
        intersection()
        {
            translate([x * -inner_radius, -inner_radius])
            square([inner_radius * 2, inner_radius * 2], center = true);
            
            difference()
            {
                circle(r = inner_radius + 1, $fn = 32);

                translate([0, 0])
                circle(r = inner_radius, $fn = 32);
            }
        }
    }
}



module belt(width, length, pitch, height, teeth_height, radius)
{
    teeth_count = ceil(length / pitch) - 1;
    
    rotate([90, 0, 0])
    translate([length * -0.5, height * -0.5, 0])
    linear_extrude(height = width, center = true, convexity = 10)
    {
        // Rectangular base
        square([length, height - teeth_height]);
        
        // Teeths
        translate([0, height - radius])
        for (i = [0:teeth_count])
        {
            translate([pitch * 0.5 + i * pitch, 0])
            teeth(
                width = width, 
                pitch = pitch, 
                radius = radius, 
                inner_radius = radius * 0.4,
                teeth_height = teeth_height);
        }
    }
}

module inverse_belt(width, length, pitch, height, teeth_height, radius)
{
    difference()
    {
        translate([length * -0.5, width * -0.5, height * -0.5])
        cube([length, width, height]);
        
        rotate([180, 0, 0])
        translate([0, 0, height * -0.5])
        belt(
            width = width + 1, 
            length = length, 
            pitch = pitch, 
            height = height, 
            teeth_height = teeth_height,
            radius = radius);
    }   
}

module gt2_belt(width, length)
{
    belt(
        width = width, 
        length = length, 
        pitch = 2, 
        height = 1.52, 
        teeth_height = 0.76,
        radius = 0.555);
}

module inverse_gt2_belt(width, length)
{
    inverse_belt(
        width = width, 
        length = length, 
        pitch = 2, 
        height = 1.52, 
        teeth_height = 0.76,
        radius = 0.555);
}

module beltclamp(){

m3_diameter = 3.3;

total_length = 19.5;
clamp_height = 6;
clamp_width = 11.23;
clamp_length = 0.5 * 25.4;		// distance between the center of the 2 holes
belt_pitch = 2;
belt_width = 7;
tooth_width = 1.3;
tooth_heigth = 0.75;
offset = belt_pitch/4;
// uncomment next line for a symetric clamp
//offset = 0;

	difference(){
		// basic shape
        translate(v = [0,0,clamp_height/2]) cube([total_length,clamp_width,clamp_height], center=true);
		
		// screw holes - h, d
		translate(v = [-clamp_length/2, 0, -1]) polyhole(clamp_height+2, m3_diameter);
		translate(v = [clamp_length/2, 0, -1]) polyhole(clamp_height+2, m3_diameter);
		translate(v = [-clamp_length/2, 0, -1]) polyhole(clamp_height+2, m3_diameter);
		translate(v = [-clamp_length/2, 0, -1]) cylinder($fn=6, h=3.5, d=8);
		translate(v = [clamp_length/2, 0, -1]) cylinder($fn=6, h=3.5, d=8);
        
		// belt grip
//		translate(v = [0,offset,clamp_height-0.001]) rotate([180,0,90]) gt2_belt(7, 20);
		translate(v = [0,offset,clamp_height-0.5]) rotate([180,0,90]) inverse_gt2_belt(7, 20);
        translate(v = [0,0,clamp_height + 0.5 + 0.001]) cube([belt_width, clamp_width, 1], true);

	}
}



        
beltclamp();
 //      translate(v = [0,belt_width/2,clamp_height-1]) cube([belt_width, clamp_width, 1.1], center=true);

//		translate(v = [0,offset,10 + clamp_height-tooth_heigth])
//        translate(v=[0, 0, 1.52]) gt2_belt(7, 20);


