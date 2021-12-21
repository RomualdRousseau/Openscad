use <hardware.scad>;

$fn = 50;
prop_size = 30;
prop_pitch = 40;
arm_len = floor((prop_size + 3) * 2.54 / 2 + 40);
quad_size = arm_len / sqrt(2);
echo();

module propeller()
{
    color("Purple", 0.5) cylinder(d = prop_size * 2.54, h = prop_pitch * 2.54 * 0.05);
}

module motor(solid_holes = 0)
{
    if (solid_holes == 0)
    {
        color("DarkSlateGray") cylinder(d = 14, h = 12);
    }
    else
    {
        translate([0, 0, -6]) cylinder(d = 4, h = 10);
        translate([4.5, 0, -6]) cylinder(d = 2.2, h = 10);
        translate([-4.5, 0, -6]) cylinder(d = 2.2, h = 10);
        translate([0, 4.5, -6]) cylinder(d = 2.2, h = 10);
        translate([0, -4.5, -6]) cylinder(d = 2.2, h = 10);
    }
}

module camera()
{
    color("DarkSlateGray")
    {
        translate([-8, 0, 0]) cube([16, 10, 16]);
        translate([0, 0, 6.5]) rotate([90, 0, 0]) cylinder(d=8, h = 5);
        translate([0, -5, 6.5]) rotate([90, 0, 0]) cylinder(d=10, h = 3);
        translate([3, 10, 0]) cube([5, 2, 1]);
        translate([-6, 9, 14]) cylinder(d = 1, h = 55);
        translate([-6, 9, 52]) cylinder(d = 2, h = 17);
        translate([-6, 9, 40]) cylinder(d = 3, h = 12);
    }
}

module flight_control(solid_holes = 0)
{
    translate([10, 10, 3])
        nut(d = 2.2, h = 3, solid_holes = solid_holes);
    translate([10, -10, 3])
        nut(d = 2.2, h = 3, solid_holes = solid_holes);
    translate([-10, -10, 3])
        nut(d = 2.2, h = 3, solid_holes = solid_holes);
    translate([-10, 10, 3])
        nut(d = 2.2, h = 3, solid_holes = solid_holes);
}

module motor_support()
{
    cylinder(d=15, h = 3);
}

module motors(solid_holes = 0)
{
    translate([quad_size, quad_size, 0]) motor(solid_holes = solid_holes);
    translate([-quad_size, quad_size, 0]) motor(solid_holes = solid_holes);
    translate([-quad_size, -quad_size, 0]) motor(solid_holes = solid_holes);
    translate([quad_size, -quad_size, 0]) motor(solid_holes = solid_holes);
}

module propellers()
{
    translate([quad_size, quad_size, 12]) propeller();
    translate([-quad_size, quad_size, 12]) propeller();
    translate([-quad_size, -quad_size, 12]) propeller();
    translate([quad_size, -quad_size, 12]) propeller();
}

module toises(h = 20, solid_holes = 0)
{
    translate([20, 20, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-20, 20, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-20, -20, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([20, -20, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
}

module bottom_plate()
{
    color("Lime") difference()
    {
        union()
        {
            hull()
            {
                translate([quad_size, -quad_size, 0]) motor_support();
                translate([-quad_size, quad_size, 0]) motor_support();
            }
            hull()
            {
                translate([-quad_size, -quad_size, 0]) motor_support();
                translate([quad_size, quad_size, 0]) motor_support();
            }
            translate([-15, -20, 0]) cube([30, 40, 3]);
        }
        
        translate([0, 0, -1]) cylinder(d = 10, h = 5);
        translate([-5, -15, -1]) rcube([10, 5, 5], 2);
        translate([-5, 10, -1]) rcube([10, 5, 5], 2);
        
        toises(solid_holes = 1);
        
        motors(solid_holes = 1);
        
        flight_control(solid_holes = 1);
    }
}

module top_plate()
{
    color("Lime") difference()
    {
        union()
        {
            hull()
            {
                translate([20, -20, 0]) motor_support();
                translate([-20, 20, 0]) motor_support();
            }
            hull()
            {
                translate([-20, -20, 0]) motor_support();
                translate([20, 20, 0]) motor_support();
            }
            translate([-15, -20, 0]) cube([30, 40, 3]);
        }
        
        translate([0, 0, -1]) cylinder(d = 10, h = 5);
        translate([-5, -15, -1]) rcube([10, 5, 5], 2);
        translate([-5, 10, -1]) rcube([10, 5, 5], 2);
        
        toises(solid_holes = 1);
    }
}

module camera_mount_side(a = -30, l = 20, solid_holes = 0)
{
    b = -2 * l * sin(a);
    x = b * cos(a);
    y = -b * sin(a);
    
    if (solid_holes == 0)
    {
        rotate([90, 0, 90]) linear_extrude(3) polygon([[0, 0], [x, y], [0, 20]]);
        translate([0, -3, 5]) cube([3, 3, 10]);
        rotate([-a, 0, 0]) translate([0, y / 2, -3]) cube([3, 10, 3]);
    }
    else
    {
        translate([-0.1, -4, 5]) cube([3.2, 4, 10]);
        rotate([-a, 0, 0]) translate([-0.1, y / 2, -4]) cube([3.2, 10, 4]);
    }
}

module camera_mount_front1(a = -30)
{  
    difference()
    {
        cube([30, 3, 20]);
        translate([15, 3, 0]) hull()
        {
            translate([0, 1, 8.5]) rotate([90, 0, 0]) cylinder(d=8, h = 5);
            translate([0, 1, 20]) rotate([90, 0, 0]) cylinder(d=8, h = 5);
        }
        translate([5, 2.1, 10]) rotate([90, 0, 0]) nut(d = 2.2, h = 10, solid_holes = 1);
        translate([25, 2.1, 10]) rotate([90, 0, 0]) nut(d = 2.2, h = 10, solid_holes = 1);
    }
}

module camera_mount_front2(a = -30)
{  
    difference()
    {
        cube([30, 3, 20]);
        translate([18, -3+2, 1.6]) cube([5, 5, 2.2]);
        translate([27, 3.01,  0]) camera_mount_side(a = a, l = 20, solid_holes = 1);
        translate([0, 3.01, 0]) camera_mount_side(a = a, l = 20, solid_holes = 1);
        translate([5, -10, 10]) rotate([90, 0, 0]) nut(d = 2.2, h = 10, solid_holes = 1);
        translate([25, -10, 10]) rotate([90, 0, 0]) nut(d = 2.2, h = 10, solid_holes = 1);
    }
}

module camera_mount(a = -30, solid_holes = 0)
{  
    if (solid_holes == 0)
    {
        translate([-15, -15.1, 0]) camera_mount_front1(a);
        translate([-15, -3, 0])  camera_mount_front2(a);
        
        translate([10, -12, 10]) rotate([90, 0, 0]) nut(d = 2, h = 10);
        translate([-10, -12, 10]) rotate([90, 0, 0]) nut(d = 2, h = 10);
    }
    
    translate([12, 0,  0]) camera_mount_side(a = a, l = 20, solid_holes = solid_holes);
    translate([-15, 0, 0]) camera_mount_side(a = a, l = 20, solid_holes = solid_holes);
}

module main()
{
    translate([0, 0, -3]) bottom_plate();
    translate([0, 0, 20]) difference()
    {
        top_plate();
        translate([0, -10, 3]) rotate([-30, 0, 0]) camera_mount(-30, solid_holes = 1);
    }
    translate([0, -10, 23]) rotate([-30, 0, 0]) 
    {
        color("Yellow") camera_mount();
        translate([0, -12, 2]) camera(); 
    }
    flight_control();
    toises();
    motors();
    propellers();
}

module schema()
{
    projection()
    {
        bottom_plate();
        
        translate([80, 0, 0]) difference()
        {
            scale([1, 1, 0.66]) top_plate();
            translate([0, -10, 2]) rotate([-30, 0, 0]) camera_mount(-30, solid_holes = 1);
        }

        translate([-60, 100, 0])rotate([90, 0, 0]) camera_mount_front1(a = -30);
        translate([-20, 100, 0]) rotate([90, 0, 0]) camera_mount_front2(a = -30);
        translate([20, 85, 0]) rotate([0, 90, 0]) camera_mount_side(a = -30, l = 20);
        translate([50, 85, 0]) rotate([0, 90, 0]) camera_mount_side(a = -30, l = 20);
    }
}

if ($preview)
{
    main();
}
else {
    schema();
}

