$fn = 50;

projection() difference()
{
    union()
    {
        cube([20, 13, 3]);
        translate([3, -2, 0]) cube([3, 2, 3]);
        translate([14, -2, 0]) cube([3, 2, 3]);
    }
    translate([5, 5, -1]) cylinder(d = 6, h = 5);
    translate([5, 11, -1]) cylinder(d = 3, h = 5);
    translate([15, 11, -1]) cylinder(d = 3, h = 5);
}