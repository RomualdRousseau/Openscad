use <hardware.scad>

$fn = 20;

module upper_plate(hole = false)
{
    if (!hole) difference()
    {
        color("Red") union()
        {
            rcube([62, 62, 2], 5);
            translate([31, 31, 2]) cylinder(d = 48, h = 3);
            translate([58, 58, 2]) cylinder(d = 6, h = 2);
            translate([4, 4, 2]) cylinder(d = 6, h = 2);
            translate([58, 4, 2]) cylinder(d = 6, h = 2);
            translate([4, 58, 2]) cylinder(d = 6, h = 2);
        }
        
        // gimbal
        translate([12.75, 18.5, -1]) rcube([36.5, 25, 7], 3);
        
        // screws
        translate([58, 58, -1]) cylinder(d = 3, h = 6);
        translate([4, 4, -1]) cylinder(d = 3, h = 6);
        translate([58, 4, -1]) cylinder(d = 3, h = 6);
        translate([4, 58, -1]) cylinder(d = 3, h = 6);
    }

    if (hole)
    {
        translate([31, 31, 1.9]) cylinder(d = 48, h = 32.1);
        translate([58, 58, 1.9]) cylinder(d = 6, h = 3.2);
        translate([4, 4, 1.9]) cylinder(d = 6, h = 3.2);
        translate([58, 4, 1.9]) cylinder(d = 6, h = 3.2);
        translate([4, 58, 1.9]) cylinder(d = 6, h = 3.2);
        
        // screws
        translate([58, 58, -1]) cylinder(d = 3, h = 35);
        translate([4, 4, -1]) cylinder(d = 3, h = 35);
        translate([58, 4, -1]) cylinder(d = 3, h = 35);
        translate([4, 58, -1]) cylinder(d = 3, h = 35);
    }
}

module gimbal_y()
{
    color("DarkSlateGray") 
    {
        difference()
        {
            rotate([0, 90, 0]) cylinder(d = 32, h = 36);
            translate([2, 0, -2]) rotate([0, 90, 0]) cylinder(d = 28, h = 32);
            translate([-1, -16, 12.1]) cube([38, 32, 10]);
            translate([-1, -16, -19]) cube([38, 32, 19]);
            translate([7, -4.5, -1]) cube([22, 9, 14]);
        }
        
        difference()
        {
            rotate([0, 90, 0]) translate([0, 0, -10]) cylinder(d = 8, h = 54);
            translate([2, 0, -2]) rotate([0, 90, 0]) cylinder(d = 28, h = 32);
        }
        
        translate([8, 14, -10]) cube([20, 2, 10]);
        translate([8, -18, -10]) cube([20, 4, 10]);
    }
}

module gimbal_x()
{
    color("DarkSlateGray")
    {
        difference()
        {
            union()
            {
                rotate([90, 0, 0,]) cylinder(d = 22, h = 8.5);
                translate([-8.5/2, -8.5, 10]) cube([8.5, 8.5, 3]);
            }
            translate([-12, -10, -12]) cube([24, 11, 12]);
            
        }
        translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d = 6, h = 28);
    }
    color("Silver") translate([0, -4, 12]) cylinder(d = 5, h = 20);
}

module base(hole = false)
{
    if (!hole) color("DarkSlateGray")
    {
        difference() 
        {
            cube([58, 48, 4]);
            translate([2, 2, -1]) cube([54, 44, 6]);
        }
        
        translate([-2, 48/2 - 19/2, -14]) cube([4, 19, 14]);
        translate([56, 48/2 - 19/2, -10]) cube([2, 19, 10]);
    }
    
    if (hole)
    {
        translate([0, 0, -24]) cube([58, 48, 28]);
    }
}

module stick()
{
    color("Red") rotate_extrude(angle = 360, convexity = 2) polygon([[0, 0], [0, 22], [2, 22], [3, 23], [3.5, 22], [3, 21], [4, 19], [4, 5], [3, 0]]);
}

module joystick(gaz = false, with_screw = true, thickness = 0.3, angle_x = 0, angle_y = 0, solid_holes = false)
{
    translate([-3.1, -3.1,0])
    {
        scale([0.1, 0.1, 0.1])
        {
            upper_plate(hole = solid_holes);
            translate([1, 7, -4]) base(hole = solid_holes);
            if (!solid_holes)
            {
                translate([13, 31, -7]) rotate([angle_y, 0, 0]) gimbal_y();
                translate([31, 35.25, -7]) rotate([angle_y, 0, 0]) rotate([0, angle_x, 0]) 
                {
                    gimbal_x();
                    translate([0, -4, 15.5]) stick();
                }
            }
        }
        
        if(!solid_holes && with_screw) 
        {
            translate([0.4, 0.4, thickness + 0.2])
            {
                screw(thickness + 1, 0.3);
                washer(0.3);
                translate([0, 0, -0.75 - thickness]) nut(0.2, 0.3);
            }
            translate([5.8, 5.8, thickness + 0.2])
            {
                screw(thickness + 1, 0.3);
                washer(0.3);
                translate([0, 0, -0.75 - thickness]) nut(0.2, 0.3);
            }
            translate([5.8, 0.4, thickness + 0.2])
            {
                screw(thickness + 1, 0.3);
                washer(0.3);
                translate([0, 0, -0.75 - thickness]) nut(0.2, 0.3);
            }
            translate([0.4, 5.8, thickness + 0.2])
            {
                screw(thickness + 1, 0.3);
                washer(0.3);
                translate([0, 0, -0.75 - thickness]) nut(0.2, 0.3);
            }
        }
    }
}

module test()
{
    $fn = 40;
    joystick(angle_x = 30 * cos(360 * $t), angle_y = 30 * sin(360 * $t));
}

test();