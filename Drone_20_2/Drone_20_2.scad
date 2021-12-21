use <hardware.scad>;

$fn = 50;
prop_size = 20;
prop_pitch = 40;
arm_len = floor(prop_size * 2.54 / 2 + 3);

module propeller() {
    color("Purple", 0.5) cylinder(d = prop_size * 2.54, h = prop_pitch * 2.54 * 0.05);
}

module motor(solid_holes = 0) {
    if (solid_holes == 0) {
        color("DarkSlateGray") cylinder(d = 14, h = 12);
    } else {
        translate([0, 0, -9]) cylinder(d = 4, h = 10);
        translate([4.5, 0, -9]) cylinder(d = 2.2, h = 10);
        translate([-4.5, 0, -9]) cylinder(d = 2.2, h = 10);
        translate([0, 4.5, -9]) cylinder(d = 2.2, h = 10);
        translate([0, -4.5, -9]) cylinder(d = 2.2, h = 10);
    }
}

module nacelle(reinforcer = true)
{
    difference()
    {
        cylinder(d = 75, h = 3);
        translate([0, 0, -1]) cylinder(d = 56, h = 5);
    }
    if (reinforcer) rotate([0, 0, 45])
    {
        translate([-2.5, -28, 0]) cube([5, 56, 3]);
        translate([-28, -2.5, 0]) cube([56, 5, 3]);
    }
}

module motor_support()
{
    cylinder(d=15, h = 3);
}

module motors(solid_holes = 0)
{
    translate([45, 45, 0]) motor(solid_holes = solid_holes);
    translate([-45, 45, 0]) motor(solid_holes = solid_holes);
    translate([-45, -45, 0]) motor(solid_holes = solid_holes);
    translate([45, -45, 0]) motor(solid_holes = solid_holes);
}

module propellers()
{
    translate([45, 45, 12]) propeller();
    translate([-45, 45, 12]) propeller();
    translate([-45, -45, 12]) propeller();
    translate([45, -45, 12]) propeller();
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

module toises(h = 20, solid_holes = 0)
{
    translate([67.5, 67.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-67.5, 67.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-67.5, -67.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([67.5, -67.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    
    translate([67.5, 22.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-67.5, 22.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-67.5, -22.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([67.5, -22.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    
    translate([12.5, 42.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-12.5, 42.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([-12.5, -42.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
    translate([12.5, -42.5, h])
        nut(d = 3.2, h = h, solid_holes = solid_holes);
}

module bottom_plate()
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([45, -45, 0]) motor_support();
                translate([-45, 45, 0]) motor_support();
            }
            hull()
            {
                translate([-45, -45, 0]) motor_support();
                translate([45, 45, 0]) motor_support();
            }
            translate([-15, -45, 0]) cube([30, 90, 3]);
            translate([-45, -45, 0]) nacelle();
            translate([45, -45, 0]) nacelle();
            translate([-45, 45, 0]) nacelle();
            translate([45, 45, 0]) nacelle();
        }
        
        translate([0, 0, -1]) cylinder(d = 10, h = 5);
        translate([-5, -40, -1]) rcube([10, 5, 5], 2);
        // translate([-5, -30, -1]) rcube([10, 5, 5], 2);
        translate([-5, -20, -1]) rcube([10, 5, 5], 2);
        translate([-5, 35, -1]) rcube([10, 5, 5], 2);
        translate([-5, 25, -1]) rcube([10, 5, 5], 2);
        translate([-5, 15, -1]) rcube([10, 5, 5], 2);
        
        toises(solid_holes = 1);
        
        motors(solid_holes = 1);
        
        flight_control(solid_holes = 1);
    }
}

module top_plate()
{
    difference()
    {
        union()
        {
            translate([-15, -45, 0]) cube([30, 90, 3]);
            translate([-45, -45, 0]) nacelle(false);
            translate([45, -45, 0]) nacelle(false);
            translate([-45, 45, 0]) nacelle(false);
            translate([45, 45, 0]) nacelle(false);
        }
        
        translate([-10, -40, -1]) rcube([5, 35, 5], 2);
        translate([5, -40, -1]) rcube([5, 35, 5], 2);
        translate([-10, 5, -1]) rcube([5, 35, 5], 2);
        translate([5, 5, -1]) rcube([5, 35, 5], 2);
        
        toises(solid_holes = 1);
    }
}

module main()
{
    translate([0, 0, -3]) color("pink") bottom_plate();
    translate([0, 0, 20]) scale([1, 1, 0.66]) color("pink") top_plate();
    flight_control();
    toises();
    motors();
    propellers();
    
}

main();
