use <hardware.scad>

module micro_switch(length = 0.5)
{
    color("DarkSlateGray") translate([0, 0, 0.3]) cylinder(d1 = 0.3, d2 = 0.25, h = length);
    color("DarkSlateGray") translate([-0.30, -0.30, 0]) cube(size = [0.6, 0.6, 0.3]);
}

module switch(angle = 0, length = 1.1, thickness = 0.3)
{
    color("blue") translate([-0.6, -0.4, -1.1]) cube(size = [1.2, 0.8, 1]);
    color("silver") 
    {
        translate([0, 0, -0.1]) cylinder(d = 0.8, h = 0.1);
        difference()
        {
            translate([0, 0, 0]) cylinder(d = 0.6, h = 0.8);
            translate([0, 0, 0.4]) cylinder(d = 0.4, h = 0.5);
        }
        translate([0, 0, 0.4]) rotate([0, angle, 0]) cylinder(d1=0.25, d2 = 0.3, h = length + 0.4);
        // hardware
        translate([0, 0, thickness + 0.05]) washer(0.6);
        translate([0, 0, thickness + 0.25]) nut(0.2, 0.6);
    }
}

module small_switch_push(thickness = 0.3)
{
    color("blue") translate([0, 0, -1.1]) cylinder(d = 0.8, h = 1);
    color("DarkSlateGray") translate([0, 0, 1.1]) cylinder(d = 0.6, h = 0.3);
    color("silver") 
    {
        translate([0, 0, -0.1]) cylinder(d = 0.8, h = 0.1);
        translate([0, 0, 0]) cylinder(d = 0.6, h = 0.8);
        translate([0, 0, 0.4]) cylinder(d1=0.25, d2 = 0.3, h = 0.9);
        // hardware
        translate([0, 0, thickness + 0.05]) washer(0.6);
        translate([0, 0, thickness + 0.25]) nut(0.2, 0.6);
    }
}

module big_switch_push(c = "Red")
{
    color(c)
    {
        translate([0, 0, 0.3]) cylinder(d = 1.2, h = 0.4);
    }
    color("DarkSlateGray")
    {
        cylinder(d = 1.9, h = 0.3);
        translate([0, 0, -1.2]) cylinder(d = 1.6, h = 1.2);
    }
}

module jumper(count = 1)
{
    jumper_male(count);
}

module jumper_male(count = 1)
{
    n = count / 2;
    color("DarkSlateGray") translate([-0.25 * n, -0.15, 0]) cube(size = [0.25 * count, 0.3, 0.3]);
    color("gold") for(i = [0:count - 1]) translate([0.25 * (n - i) - 0.175, -0.05, 0]) cube(size = [0.1, 0.1, 0.9]);
}

module jumper_female(count = 1)
{
    n = count / 2;
    color("DarkSlateGray") translate([-0.25 * n, -0.15, 0]) cube(size = [0.25 * count, 0.3, 0.9]);
}

module ft232rl(extended_ports = false)
{
    // pcb
    color("DarkGreen") translate([-2, -1.5, -0.2]) cube(size = [4, 3, 0.2]);
    // jumpers
    translate([0.8, -1.2, 0]) jumper(8);
    translate([-0.7, -1.2, 0]) jumper(3);
    translate([0.8, 1.2, 0]) jumper(8);
    translate([-0.7, 1.2, 0]) jumper(3);
    // usb
    if(extended_ports)
    {
        color("silver") translate([-6, -0.6, 0]) cube(size = [5.7, 1.2, 1.1]);
    }
    else
    {
        color("silver") translate([-2, -0.6, 0]) cube(size = [1.7, 1.2, 1.1]);
    }
}

module power_supply(solid_holes = false, squares = 1)
{
    if(solid_holes) {
        translate([2.5, 0, 0]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
        translate([4, 11.4, 0]) rotate([0, 0, 180]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
        translate([17.5, 0, 0]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
        translate([19, 11.4, 0]) rotate([0, 0, 180]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
    }
    else {
        // body
        color("Silver") difference()
        {
            cube([21.5, 11.4, 5]);
            translate([19.7, 0.2, 1]) cube([1.9, 11, 4.1]);
        }
        // outputs
        color("DarkSlateGray") translate([19.7, 1.7, 1]) cube([1.8, 9.5, 1.6]);
        
        if(squares) {
            translate([2.5, 0, 0]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
            translate([4, 11.4, 0]) rotate([0, 0, 180]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
            translate([17.5, 0, 0]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
            translate([19, 11.4, 0]) rotate([0, 0, 180]) bracketL([1.5, 1.6, 1.9], 0.4, solid_holes);
       }
    }
}

module yl30sd(widthsd = true)
{
    // pcb
    color("DarkGreen") translate([-2.2, -1.7, -0.2]) cube(size = [4.4, 3.4, 0.2]);
    // jumpers
    translate([1.95, 0, 0]) rotate([0, 0, 90]) jumper(8);
    color("silver") translate([-2.2, -1.3, 0]) cube(size = [2.6, 2.6, 0.3]);
    // card
    if(widthsd)
    {
        color("blue") translate([-3.2, -1.2, 0.05]) cube(size = [3.2, 2.4, 0.2]);
    }
}

module lcd_16x2(thickness = 0.3, solid_holes = false)
{
    translate([-4, -1.8, -0.5])
    {
        // pcb
        color("DarkGreen") difference()
        {
            cube(size = [8, 3.6, 0.2]);
            translate([0.25, 0.25, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([7.75, 0.25, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([7.75, 3.35, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([0.25, 3.35, -0.1]) cylinder(d = 0.3, h = 0.4);
        }
        color("DarkGreen") translate([0.6, 0.05, -0.4]) cube(size = [4.1, 2.4, 0.4]);
        // screen
        color("black") translate([0.45, 0.6, 0.2]) difference()
        {
            cube(size = [7.1, 2.4, 0.7]);
            translate([0.3, 0.5, -0.1]) cube(size = [6.5, 1.4, 0.9]);
        }
        color("green") translate([0.75, 1.1, 0.1]) cube(size = [6.5, 1.4, 0.75]);
        // hardware
        color("silver") translate([0.25, 0.25, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        color("silver") translate([7.75, 0.25, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        color("silver") translate([7.75, 3.35, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        color("silver") translate([0.25, 3.35, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        
        if(solid_holes)
        {
            translate([0.45, 0.6, 0.2]) cube(size = [7.1, 2.4, 1.7]);
        }
    }
}

module servo_controller_24(spacer = false, solid_holes = false)
{
    if(solid_holes) {
        // spacer
        translate([0.45, 0.45, -2.5]) cylinder(d = 0.3, h = 2.5);
        translate([4.65, 0.45, -2.5]) cylinder(d = 0.3, h = 2.5);
        translate([0.45, 3.95, -2.5]) cylinder(d = 0.3, h = 2.5);
        translate([4.65, 3.95, -2.5]) cylinder(d = 0.3, h = 2.5);
        // usb
        color("silver") translate([4.2, 2.6, 0.2]) cube([1.9, 0.7, 0.3]);
        // power
        color("blue") translate([4.3, 0.8, 0.2]) cube([1.75, 1.5, 0.95]);
    }
    else {
        // pcb
        color("DarkGreen") difference()
        {
            cube([5.1, 4.4, 0.2]);
            translate([0.45, 0.45, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([4.65, 0.45, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([0.45, 3.95, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([4.65, 3.95, -0.1]) cylinder(d = 0.3, h = 0.4);
        }
        // jumpers
        translate([2.5, 4.2, 0.2]) jumper(10);
        translate([2.5, 3.9, 0.2]) jumper(10);
        translate([2.5, 3.6, 0.2]) jumper(10);  
        translate([2.5, 0.2, 0.2]) jumper(10);
        translate([2.5, 0.5, 0.2]) jumper(10);
        translate([2.5, 0.8, 0.2]) jumper(10);
        translate([0.2, 2.2, 0.2]) rotate([0, 0, 90]) jumper(8);
        translate([0.5, 2.2, 0.2]) rotate([0, 0, 90]) jumper(8);
        translate([0.8, 2.2, 0.2]) rotate([0, 0, 90]) jumper(8);
        // usb
        color("silver") translate([4.2, 2.6, 0.2]) cube([0.9, 0.7, 0.3]);
        // power
        color("blue") translate([4.3, 0.8, 0.2]) cube([0.75, 1.5, 0.95]);
        
        if(spacer)
        {
            translate([0.45, 0.45, 0]) nut(d = 0.3, h = 0.8);
            translate([4.65, 0.45, 0]) nut(d = 0.3, h = 0.8);
            translate([0.45, 3.95, 0]) nut(d = 0.3, h = 0.8);
            translate([4.65, 3.95, 0]) nut(d = 0.3, h = 0.8);
        }
    }
}

module dcdc_step_down(spacer = false, solid_holes = false)
{
    // pcb
    color("DarkGreen") difference()
    {
        cube([7, 3.6, 0.1]);
        translate([6.2, 1.6, -0.1]) cylinder(d = 0.4, h = 0.3);
    }
    // inputs / outpits
    color("Blue")
    {
        translate([0.2, 2.3, 0.1]) cube([0.7, 1.1, 1]);
        translate([6.1, 0.2, 0.1]) cube([0.7, 1.1, 1]);
    }
    // heatsinks
    color("Silver")
    {
        translate([2.2, 1.5, 0]) rotate([180, 0, 0]) heatsink(1.2, 0.5, 1, "d");
        translate([1.4, 2.2, 0.1]) heatsink(4.6, 2.2, 1, "w");
    }
    // components
    color("DarkSlateGray")
    {
        translate([1.7, 0.6, 0.1]) cylinder(d = 1, h = 2);
        translate([1.7, 1.6, 0.1]) cylinder(d = 1, h = 2);
        translate([5.5, 0.6, 0.1]) cylinder(d = 1, h = 2);
        translate([5.5, 1.6, 0.1]) cylinder(d = 1, h = 2);
    }
    if(spacer)
    {
        translate([6.2, 1.6, 0]) nut(d = 0.3, h = 0.8, solid_holes = solid_holes);
    }
}

module step_motor_driver(spacer = false)
{
    // pcb
    color("DarkGreen") difference()
    {
        cube([7.5, 5, 0.15]);
        translate([0.3, 0.35, -0.1]) cylinder(d = 0.35, h = 0.3);
        translate([0.3, 4.65, -0.1]) cylinder(d = 0.35, h = 0.3);
        translate([7.2, 0.35, -0.1]) cylinder(d = 0.35, h = 0.3);
        translate([7.2, 4.65, -0.1]) cylinder(d = 0.35, h = 0.3);        
    }
    // inputs / outputs
    color("LimeGreen")
    {
        translate([0, 1, 0.15]) cube([1, 3, 1.4]);
        translate([6.5, 1, 0.15]) cube([1, 3, 1.4]);
    }
    // heatsinks
    color("Silver")
    {
        translate([0.5, 0, -0.5]) rotate([180, 0, 90]) heatsink(5, 1.1, 4, "d");
    }
    // dip
    color("Red")
    {
        translate([4.8, 0.1, 0.15]) cube([1.7, 1, 0.5]);
    }
    // components
    color("DarkSlateGray")
    {
        translate([1.3, 4.5, 0.15]) cylinder(d = 1, h = 1.8);
        translate([1.5, 0.5, -0.5]) cube([1.5, 4, 0.5]);
    }
    if(spacer)
    {
        translate([0.3, 0.35, 2.65]) nut(d = 0.3, h = 2.5);
        translate([0.3, 4.65, 2.65]) nut(d = 0.3, h = 2.5);
        translate([7.2, 0.35, 2.65]) nut(d = 0.3, h = 2.5);
        translate([7.2, 4.65, 2.65]) nut(d = 0.3, h = 2.5);   
    }
}

module pwm_motor_driver(spacer = false)
{
    // pcb
    color("DarkGreen") difference()
    {
        cube([7.5, 7.5, 0.15]);
        translate([0.35, 0.35, -0.1]) cylinder(d = 0.4, h = 0.3);
        translate([0.35, 7.15, -0.1]) cylinder(d = 0.4, h = 0.3);
        translate([7.15, 0.35, -0.1]) cylinder(d = 0.4, h = 0.3);
        translate([7.15, 7.15, -0.1]) cylinder(d = 0.4, h = 0.3);   
    }
    // inputs / outputs
    color("DarkSlateGray")
    {
        translate([0.1, 2, 0.15]) cube([1.1, 1.7, 1.3]);
        translate([6.3, 2, 0.15]) cube([1.1, 1.7, 1.3]);
    }
    // pwm
    color("LimeGreen")
    {
        translate([5.7, 0.2, 0.15]) cube([1.1, 0.7, 1]);
    }
    // coolers
    color("Silver")
    {
        translate([0.7, 5.6, 0.15]) heatsink(6, 3.1, 1.8, "h");
    }
    // components
    color("DarkSlateGray")
    {
        translate([2.3, 3.1, 0.15]) cylinder(d = 1.5, h = 2.6);
    }
    if(spacer)
    {
        translate([0.35, 0.35, 0]) nut(d = 0.3, h = 2.5);
        translate([0.35, 7.15, 0]) nut(d = 0.3, h = 2.5);
        translate([7.15, 0.35, 0]) nut(d = 0.3, h = 2.5);
        translate([7.15, 7.15, 0]) nut(d = 0.3, h = 2.5);  
    }
}

module rs232(thickness = 0.3, extended_ports = 0)
{
    color("silver")
    {
        difference()
        {
            translate([-1.55, -0.6, -0.1]) cube(size = [3.1, 1.2, 0.1]);
            translate([-1.2, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
            translate([1.2, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
        }
        translate([-1, -0.55, -0.6]) cube(size = [2, 1.1, 0.5]);
        translate([-0.8, -0.4, 0]) cube(size = [1.6, 0.8, 0.6]);
        // hardware
        translate([-1.2, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.1]) nut(0.2, 0.3);
        }
        translate([1.2, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.1]) nut(0.2, 0.3);
        }
    }
    
    if (extended_ports)
    {
        translate([-0.925, -0.5, -0.6]) cube(size = [1.85, 1, 3.5]);
        translate([-1, -0.55, -0.6]) cube(size = [2, 1.1, 0.5]);
        translate([-1.2, 0, -0.6]) cylinder(d = 0.3, h = 3.5);
        translate([1.2, 0, -0.6]) cylinder(d = 0.3, h = 3.5);
    }
}

module antenna(extended_ports = 0)
{
    color("DarkSlateGray") cylinder(d1 = 1, d2 = 0.8, h = 11);
    color("Gold") translate([0, 0, -1]) cylinder(d = 0.6, h = 1);
    
    if (extended_ports)
    {
        translate([0, 0, -2]) cylinder(d = 0.6, h = 2.1);
    }
}

module battery()
{
    color("red") cube(size = [15.5, 2.2, 4.5]);
}

module battery2()
{
    color("red") cube(size = [16.5, 2.4, 4.9]);
}

module led_green()
{
    color("green") cylinder(d = 0.8, h = 0.7);
}

module heatsink(w, h, d, direction = "w")
{
    difference() 
    {
        cube([w, d, h]);
        if(direction == "w") 
        {
            for(i = [0.1 : 0.3 : w - 0.3]) translate([i, 0.1, -0.1]) cube([0.2, d,  h + 0.2]);
        }
        if(direction == "d") 
        {
            for(i = [0.1 : 0.3 : d - 0.3]) translate([-0.1, i, 0.1]) cube([w + 0.2, 0.2, h]);
        }
        if(direction == "h") 
        {
            for(i = [0.1 : 0.3 : h - 0.3]) translate([-0.1, 0.1, i]) cube([w + 0.2, d, 0.2]);
        }
    }
}

module banna_plug(c = "Red")
{
    color(c)
    {
        translate([0, 0, 0.2]) cylinder(d = 1.1, h = 0.4);
        translate([0, 0, 0.6]) cylinder(d = 1.2, h = 0.7);
        translate([0, 0, -0.3]) cylinder(d = 1.2, h = 0.3);
        translate([0, 0, -0.8]) cylinder(d = 0.9, h = 0.5);
    }
    color("Silver")
    {
        cylinder(d = 1.0, h = 0.2);
        translate([0, 0, -0.6]) cylinder(d = 0.6, h = 0.6);
        translate([0, 0, -0.6]) cylinder(d = 0.6, h = 0.6);
        translate([0, 0, -2]) cylinder(d = 0.4, h = 1.4);
        // hardware
        translate([0, 0, -0.8]) washer(0.4);
        translate([0, 0, -0.8]) nut(0.3, 0.4);
    }
}

module emergency_button()
{
    color("Silver")
    {
        cube([4, 3, 1.1]);
        translate([2, 1.5, 1.1]) cylinder(d = 2.2, h = 0.8);
        translate([2, 1.5, 1.9]) cylinder(d = 2.7, h = 1.1);
    }
    color("DarkSlateGray")
    {
        translate([0.55, 1.5, -3]) cube([2.9, 1.5, 3]);
    }
    color("Red")
    {
        translate([2, 1.5, 3]) cylinder(d = 3, h = 1.3);
        translate([2, 1.5, 4.3]) cylinder(d = 4, h = 0.5);
    }
}

module power_plug(solid_holes = 0)
{
    if(solid_holes) {
        translate([0, 0.95, 0]) cylinder(d = 0.3, h = 2);
        translate([4.3, 0.95, 0]) cylinder(d = 0.3, h = 2);
    }
    else {
        color("DarkSlateGray")
        {
            hull()
            {
                translate([0.8, 0, 0]) cube([2.7, 1.4, 2]);
                translate([1.3, 1.4, 0]) cube([1.7, 0.5, 2]);
            }
            
            difference() 
            {
                hull()
                {
                    translate([0.6, -0.2, -0.4]) cube([2.7 + 0.4, 1.9 + 0.4, 0.4]);
                    translate([0, 0.95, -0.4]) cylinder(d = 0.8, h = 0.4);
                    translate([4.3, 0.95, -0.4]) cylinder(d = 0.8, h = 0.4);
                }
                translate([0, 0.95, -0.5]) cylinder(d = 0.3, h = 0.6);
                translate([4.3, 0.95, -0.5]) cylinder(d = 0.3, h = 0.6);
            }
        }
    }
}

module power_plug_with_switch()
{
    color("DarkSlateGray")
    {
        hull()
        {
            translate([0.5, -0.1, 0]) cube([4.2, 4.1, 2.7]);
            translate([0, -0.1, 0.5]) cube([4.7, 4.1, 1.7]);
        }
        translate([-0.2, -0.3, -0.2]) cube([5.1, 0.3, 3.1]);
    }
}

module power_switch()
{
    color("DarkSlateGray")
    {
        cube([1.9, 1.2, 1]);
        translate([-0.1, -0.1, -0.2])cube([2.1, 1.4, 0.2]);
    }
}

module usb_b(thickness = 0.3, extended_ports = 0)
{
    if (!extended_ports) 
    {
        color("DarkSlateGray") difference()
        {
            translate([-3.8/2, -0.6, -0.5]) cube(size = [3.8, 1.2, 0.5]);
            translate([-1.5, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
            translate([1.5, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
        }
        color("DarkSlateGray") translate([-1.05, -0.6, -2.5]) cube(size = [2.1, 1.2, 2]);
        color("DarkSlateGray") translate([0, 0, -3]) cylinder(d = 1, h = 0.5);
        color("Silver") translate([-0.6, -0.55, 0]) cube(size = [1.2, 1.1, 0.1]);
        // hardware
        translate([-1.5, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
        }
        translate([1.5, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
        }
    }
    
    if (extended_ports)
    {
        translate([-0.65, -0.6, -0.1]) cube(size = [1.3, 1.2, 3.5]);
        translate([-1.5, 0, -0.1]) cylinder(d = 0.3, h = 3.5);
        translate([1.5, 0, -0.1]) cylinder(d = 0.3, h = 3.5);
    }
}

module usb_minia(thickness = 0.3, extended_ports = 0)
{
    if (!extended_ports) 
    {
        color("DarkSlateGray") difference()
        {
            translate([-3.6/2, -0.55, -0.7]) cube(size = [3.6, 1.1, 0.7]);
            translate([-1.4, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
            translate([1.4, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
        }
        color("DarkSlateGray") translate([-1.05, -0.55, -2]) cube(size = [2.1, 1.1, 1.3]);
        color("DarkSlateGray") translate([0, 0, -2.5]) cylinder(d = 0.8, h = 0.5);
        color("Silver") translate([-0.45, -0.25, 0]) cube(size = [0.9, 0.5, 0.1]);
        // hardware
        translate([-1.4, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
        }
        translate([1.4, 0, thickness + 0.05])
        {
            screw(thickness + 0.4, 0.3);
            washer(0.3);
        }
    }
    
    if (extended_ports)
    {
        translate([-0.5, -0.3, -0.1]) cube(size = [1, 0.6, 3.5]);
        translate([-1.4, 0, -0.1]) cylinder(d = 0.3, h = 3.5);
        translate([1.4, 0, -0.1]) cylinder(d = 0.3, h = 3.5);
    }
}

module test()
{
    $fn = 20;
    
    translate([0, 0, 0]) micro_switch(0.9);
    translate([5, 0, 0]) switch(10, 2.1);
    translate([10, 0, 0]) ft232rl();
    translate([15, 0, 0]) rs232();
    translate([20, 0, 0]) antenna();
    translate([25, 0, 0]) lcd_16x2();
    
    translate([0, 5, 0]) yl30sd();
    translate([5, 5, 0]) small_switch_push();
    translate([10, 5, 0]) big_switch_push();
    translate([15, 5, 0]) heatsink(1, 1, 1);
    translate([20, 5, 0]) banna_plug();
    translate([25, 5, 0]) emergency_button();
    
    translate([0, 10, 0]) servo_controller_24();
    translate([6, 10, 0]) dcdc_step_down();
    translate([14, 10, 0]) pwm_motor_driver();
    translate([22.5, 10, 0]) step_motor_driver();
    
    translate([0, 20, 0]) power_supply();
    translate([22.5, 20, 0]) power_plug();
    translate([22.5, 25, 0]) power_switch();
    translate([22.5, 30, 0]) power_plug_with_switch();
}

test();
