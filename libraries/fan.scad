module fan(solid_holes = 0)
{
    color("DarkSlateGray") difference()
    {
        cube([9.2, 9.2, 2.5]);
        translate([4.6, 4.6, -0.1]) cylinder(d = 9, h = 2.7);
        translate([0.5, 0.5, -0.1]) cylinder(d = 0.5, h = 2.7);
        translate([8.7, 0.5, -0.1]) cylinder(d = 0.5, h = 2.7);
        translate([8.7, 8.7, -0.1]) cylinder(d = 0.5, h = 2.7);
        translate([0.5, 8.7, -0.1]) cylinder(d = 0.5, h = 2.7);
    }
    
    if(solid_holes) {
        translate([4.6, 4.6, 1]) cylinder(d = 9, h = 3.7);
        translate([0.5, 0.5, 1]) cylinder(d = 0.5, h = 3.7);
        translate([8.7, 0.5, 1]) cylinder(d = 0.5, h = 3.7);
        translate([8.7, 8.7, 1]) cylinder(d = 0.5, h = 3.7);
        translate([0.5, 8.7, 1]) cylinder(d = 0.5, h = 3.7);
    }
}

module test()
{
    $fn = 20;
    fan();
}

test();