module battery()
{
    color("blue") cube([7, 3.7, 1.9]);
}

module receiver()
{
    color("DarkSlateGray") cube([4.7, 2.6, 1.5]);
    color("black") translate([4.7, 0.15, 0.40]) cube([0.8, 2.3, 0.7]);
}

module esc()
{
    color("DarkSlateGray")
    {
        cube([3.4, 3.4, 0.5]);
        translate([0.5, 0, 0.5]) cube([2.9, 3.4, 1.0]);
    }
    color("silver") translate([0.6, 0, 1.5]) 
    {
        cube([1.2, 3.4, 0.8]);
        translate([0, 1.7, 0.8]) cube([1.2, 1.7, 0.2]);
    }
}

module esc_switch()
{
    color("DarkSlateGray") cube([2.9, 1.1, 1.5]);
    color("black") translate([1.3, 0.35, 1.5]) cube([0.6, 0.4, 0.4]);
}

module servo(horn = "simple", axis = "simple", angle = 0, solid_holes) 
{
    if (solid_holes) {
        translate([-0.6, -0.6, 0]) servo_base(angle = angle, solid_holes = 1);
        translate([0, 0, 2.5]) cylinder(d = 0.7, h = 0.7);
        if(axis == "double")
        {
            translate([0, 0, -1]) cylinder(d = 0.8, h = 1);
        }
    }
    else {
        translate([-0.6, -0.6, 0]) servo_base(horn, angle);
        if(axis == "double")
        {
            translate([0, 0, 0.4]) bearing();
        }
    }
}

module servo_base(horn = "simple", angle = 0, solid_holes)
{
    if(solid_holes) {
        translate([-0.025, -0.025, -0.025])
        {
            // body
            cube([2.35, 1.25, 2.25]);
            translate([-0.2, 0.625, 0]) cylinder(d = 0.2, h = 2.25);
            translate([2.55, 0.625, 0]) cylinder(d = 0.2, h = 2.25);
            translate([0.6, 0.6, 2.2]) cylinder(d = 1.2, h = 0.4);
            translate([0.6, 0.6, 2.6]) cylinder(d = 0.5, h = 1);
        }
    }
    else {
        // body
        color("blue")
        {
            cube([2.3, 1.2, 1.55]);
            difference()
            {
                translate([-0.45, 0, 1.55]) cube([3.2, 1.2, 0.25]);
                translate([-0.225, 0.6, 1.45]) cylinder(d = 0.2, h = 0.45);
                translate([2.525, 0.6, 1.45]) cylinder(d = 0.2, h = 0.45);
            }
            translate([0, 0, 1.8]) cube([2.3, 1.2, 0.4]);
            translate([0.6, 0.6, 2.2]) cylinder(d = 1.2, h = 0.4);
        }
        // axis
        color("white") translate([0.6, 0.6, 2.6]) cylinder(d = 0.5, h = 0.3);
    }
    // horn
    if(horn != "none")
    {
        servo_horn(angle = angle, solid_holes = solid_holes);
    }
}

module servo_horn(horn = "simple", angle = 0, solid_holes)
{
    if(solid_holes) {
        translate([-0.025, -0.025, -0.025])
        {
            translate([0.6, 0.6, 2.7]) rotate([0, 0, angle])
            {
                if(horn == "simple")
                {
                    translate([0.025, 0.675, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, 1.075, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, 1.475, 0]) cylinder(d = 0.2, h = 1);
                }
                if(horn == "double")
                {
                    translate([0.025, 0.675, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, 1.075, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, 1.475, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, -0.625, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, -1.025, 0]) cylinder(d = 0.2, h = 1);
                    translate([0.025, -1.425, 0]) cylinder(d = 0.2, h = 1);
                }
            }
        }
    }
    else {
        color("white") translate([0.6, 0.6, 2.7]) rotate([0, 0, angle])
        {
            difference()
            {
                cylinder(d = 0.7, h = 0.35);
                translate([0, 0, -0.1]) cylinder(d = 0.5, h = 0.35);
            }
            if(horn == "simple")
            {
                translate([0, 0, 0.35]) difference()
                {
                    hull()
                    {
                        cylinder(d = 0.7, h = 0.15);
                        translate([0, 1.5, 0]) cylinder(d = 0.4, h = 0.15);
                    }
                    translate([0, 0.65, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, 1.05, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, 1.45, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                }
            }
            if(horn == "double")
            {
                translate([0, 0, 0.35]) difference()
                {
                    hull()
                    {
                        cylinder(d = 0.7, h = 0.15);
                        translate([0, 1.5, 0]) cylinder(d = 0.4, h = 0.15);
                        translate([0, -1.5, 0]) cylinder(d = 0.4, h = 0.15);
                    }
                    translate([0, 0.65, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, 1.05, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, 1.45, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, -0.65, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, -1.05, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                    translate([0, -1.45, 0-0.1]) cylinder(d = 0.2, h = 0.35);
                }
            }
        }
    }
}

module wheel()
{
    color("black") difference()
    {
        cylinder(d = 6.2, h = 2.6);
        translate([0, 0, -0.1]) cylinder(d = 5.3, h = 2.8);
    }
    color("blue")
    {
        difference()
        {
            union()
            {
                difference()
                {
                    cylinder(d = 5.3, h = 2.6);
                    translate([0, 0, -0.1]) cylinder(d = 4.5, h = 2.8);
                }
                translate([0, 0, 1.6]) cylinder(d = 4.5, h = 0.2);
                translate([0, 0, 1.0]) cylinder(d = 1.6, h = 0.8);
            }
            translate([0, 0, 0.9]) cylinder(d = 0.4, h = 1.7);
            translate([0, 0, 0.9]) cylinder(d = 1.3, h = 0.5, $fn = 6);
        }
    }
}

module motor()
{
    color("silver") 
    {
        cylinder(d = 3.5, h = 5);
        translate([0, 0, -0.2]) cylinder(d = 0.3, h = 6.7);
    }
}

module gear_small()
{
    color("orange") difference()
    {
        union()
        {
            cylinder(d = 1.2, h = 0.5);
            translate([0, 0, -0.4]) cylinder(d = 0.7, h = 0.4);
        }
        translate([0, 0, -0.5]) cylinder(d = 0.3, h = 1.1);
    }
}

module gear_big()
{
    color("DarkSlateGray") difference()
    {
        union()
        {
            cylinder(d = 4.6, h = 0.45);
            translate([0, 0, 0.45]) cylinder(d = 1, h = 1.05);
        }
        translate([0, 0, -0.1]) cylinder(d = 0.4, h = 1.7);
    }
}

module suspension()
{
    color("blue") rotate([0, 90, 0]) cylinder(d = 1, h = 6.9);
}

module steering_knuckle()
{
    scale([0.1, 0.1, 0.1])
    {
        // steering arm
        color("black") difference()
        {
            union()
            {
                hull()
                {
                    cylinder(d=11, h = 6);
                    translate([5.5, 5.5, 3]) rotate([90, 0, 0]) cylinder(d = 6, h = 11);
                }
                hull()
                {
                    translate([-13.5, 1.5, -3]) rotate([90, 0, 0]) cylinder(d = 6, h = 3);
                    translate([-9.5, 1.5, -3]) rotate([90, 0, 0]) cylinder(d = 6, h = 3);
                    translate([-5, -1.5, -3]) cube([1, 3, 9]);
                }
                translate([0, 0, 6]) cylinder(d=11, h = 3);
                translate([0, 0, -3]) cylinder(d = 11, h = 3);
            }
            translate([0, 0, -1]) cylinder(d = 4, h = 11);
            translate([0, 0, -4]) cylinder(d = 8, h = 4);
            translate([5.5, 6.5, 3]) rotate([90, 0, 0]) cylinder(d = 3, h = 13);
            translate([-13.5, 2.5, -3]) rotate([90, 0, 0]) cylinder(d = 3, h = 5);
            translate([-9.5, 2.5, -3]) rotate([90, 0, 0]) cylinder(d = 3, h = 5);
        }
        
        // stub axle
        color("black")
        {
            cylinder(d = 4, h = 25);
            translate([0, 0, -2]) cylinder(d = 7, h = 1);
        }
        translate([0, 0, -1]) cylinder(d = 8, h = 1);
        
        // wheel nut
        color("blue") translate([0, 0, 10]) difference()
        {
            cylinder(d = 13, h = 6, $fn = 6);
            translate([0, 0, -1]) cylinder(d = 4, h = 8);
        }
        color("silver")
        {
            translate([0, 0, 20]) cylinder(d = 9, h = 1);
            translate([0, 0, 21]) cylinder(d = 7, h = 3, $fn = 6);
        }
    }   
}

module steeing_link_hub(d = 0.9, l = 1.5, h = 0.4)
{
    color("Black") difference()
    {
        union()
        {
            cylinder(d = d, h = h);
            translate([0, d / 2 - 0.5, h / 2]) rotate([-90, 0, 0]) cylinder(d = h, h = l);
        }
        translate([0, 0, -0.1]) cylinder(d = 0.3, h = h + 0.2);
    }
}
   
module steering_link(l = 10, a = 90)
{
    rotate([0, 0, -a])
    {
        steeing_link_hub();
        translate([0, l, 0]) rotate([0, 0, 180]) steeing_link_hub();
        color("silver") translate([0, 1, 0.2]) rotate([-90, 0, 0]) cylinder(d = 0.3, h = l - 2);
    }
}

module bearing()
{
    color("silver") difference()
    {
        union()
        {
            translate([0, 0, -0.5]) cylinder(d = 1, h = 0.1);
            translate([0, 0, -0.8]) cylinder(d = 0.8, h = 0.3);
        }
        translate([0, 0, -0.9]) cylinder(d = 0.4, h = 0.6);
    }
}

module wheel_nut()
{
    color("gold") difference()
    {
        union()
        {
            translate([0, 0, 0.8]) cylinder(d = 1.3, h = 0.6, $fn = 6);
            translate([0, 0, -0.4]) cylinder(d = 1.1, h = 1.2);
        }
        translate([0, 0, -0.5]) cylinder(d = 0.4, h = 2);
    }
}

module steering_shaft(l = 15)
{
    color("silver") rotate([-90, 0, 0]) cylinder(d = 0.4, h = l);
}

module examples($fn = 40)
{
    servo();
    translate([6, 0, 0]) receiver(); 
    translate([12, 0, 0]) esc();
    translate([24, 0, 0]) wheel();
    translate([30, 0, 0]) gear_small();

    translate([0, 6, 0]) battery();
    translate([12, 6, 0]) esc_switch(); 
    translate([18, 6, 0]) motor();
    translate([24, 6, 0]) gear_big();
    translate([30, 6, 0]) steering_knuckle();
    
    translate([0, 12, 0]) steering_link();
    translate([12, 12, 0]) bearing();
    translate([18, 12, 0]) wheel_nut();
    translate([24, 12, 0]) steering_shaft();
    translate([30, 12, 0]) suspension();
}

examples();
