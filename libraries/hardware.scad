module screw(h, d)
{
    color("silver") difference()
    {
        cylinder(d = d + 0.2, h = d / 2);
        rotate([0, 0, 45]) translate([-d, -0.05, d / 4]) cube(size = [d * 2, 0.1, d / 4 + 0.001]);
    }
    color("silver") translate([0, 0, -h]) cylinder(d = d, h = h);  
}

module washer(d)
{
    color("silver") translate([0, 0, -0.05]) difference()
    {
        cylinder(d = d + 0.4, h = 0.05);
        translate([0, 0, -0.1]) cylinder(d = d + 0.001, h = 0.3);
    }
}

module nut(h, d, solid_holes = 0)
{
    if(solid_holes) {
        translate([0, 0, -h - 5]) cylinder(d = d, h = 10 + h);
    }
    else {
        color("gold") translate([0, 0, -h]) difference()
        {
            cylinder(d = d * 2, h = h, $fn = 8);
            translate([0, 0, -0.1]) cylinder(d = d + 0.001, h = h + 0.2);
        }
    }
}

module foot(solid_holes = 0)
{
    if(solid_holes) {
        cylinder(d = 0.6, h = 2);
    }
    else {
        n = min(60 / ($fn / 4), 45);
        a = [[0.15, 0], [0.75, 0], [0.65, -0.5]];
        b = [for (a = [30: n: 90]) [0.4 + 0.25 * cos(-a), -0.5 + 0.30 * sin(-a)]]; //[[0.4 + 0.25 * cos(-22), -0.5 + 0.30 * sin(-22)], [0.4 + 0.25 * cos(-45), -0.5 + 0.30 * sin(-45)], [0.4 + 0.25 * cos(-67), -0.5 + 0.30 * sin(-67)]];
        c = [[0.4, -0.8], [0.3, -0.8], [0.3, -0.2], [0.15, -0.2]];
        color("black") rotate_extrude() polygon(points = concat(a, b, c));
    }
}

module bracketL(size = [1, 1, 1], d = 0.4, solid_holes = 0)
{
    if(solid_holes) {
        translate([size[0] / 2, -size[1] + (size[1] - 0.1) * 0.4, -2]) cylinder(d = d, h = 2.5);
        translate([size[0] / 2, 2, size[2] * 0.6]) rotate([90, 0, 0]) cylinder(d = d, h = 2.5);
    }
    else {
        color("silver") translate([0, -size[1], 0]) difference()
        {
             cube([size[0], size[1] - 0.1, 0.1]);
             translate([size[0] / 2, (size[1] - 0.1) * 0.4, -0.1]) cylinder(h = 0.3, d = d);
        }
        color("silver") translate([0, -0.1, 0]) difference()
        {
            cube([size[0], 0.1, size[2]]);
            translate([size[0] / 2, 0.2, size[2] * 0.6]) rotate([90, 0, 0]) cylinder(h = 0.3, d = d);
        }
    }
}

module rcube(size = [1, 1, 1], radius = 0.1)
{
    if(radius == 0)
    {
        cube(size);
    }
    else
    {
        translate([radius / 2, radius / 2, 0]) minkowski()
        {
            cylinder(d = radius, h = size[2] / 2);
            cube([size[0] - radius, size[1] - radius, size[2] / 2]);
        }
    }
}

module tube(size = [1, 1, 1], radius = 0.5, solid_holes = 0)
{
    if(solid_holes) {
        translate([size[0] / 2, size[1] / 2, -2]) cylinder(d = radius, h = size[2] + 4);
    }
    else {
        color("silver") difference()
        {
            rcube(size, radius);
            translate([size[0] / 2, size[1] / 2, -0.1]) cylinder(d = radius, h = size[2] + 0.2);
        }
    }
}

module test()
{
    $fn = 20;
    translate([0, 0, 0])
    {
        screw(1, 0.2);
        translate([0, 0, -0.2]) washer(0.2);
        translate([0, 0, -0.5]) nut(0.2, 0.2);
    }
    translate([5, 0, 0]) foot();
    translate([10, 0, 0]) bracketL();
    translate([15, 0, 0]) tube();
}

test();




