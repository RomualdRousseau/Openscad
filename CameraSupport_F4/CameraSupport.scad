use <hardware.scad>;

$fn = 50;

module board(s = [30, 30], o = 2.5, d = 3, hs = 10, layout = 4, hole = true, spacer = true)
{
    w = s[0];
    h = s[1];
    
    difference() {
        cube([w, h, 2]);
    
        translate([o, o, -1]) cylinder(d = d + 0.5, h = 4);
        translate([w - o, h - o, -1]) cylinder(d = d + 0.5, h = 4);
        if(layout == 4)
        {
            translate([w - o, o, -1]) cylinder(d = d + 0.5, h = 4);
            translate([o, h - o, -1]) cylinder(d = d + 0.5, h = 4);
        }
    }
    
    if (spacer) {
        translate([o, o, 0]) scale(10) nut(hs/10, d/10);
        translate([w - o, h - o, 0]) scale(10) nut(hs/10, d/10);
        if(layout == 4)
        {
            translate([w - o, o, 0]) scale(10) nut(hs/10, d/10);
            translate([o, h - o, 0]) scale(10) nut(hs/10, d/10);
        }
    }
    
    if (hole) {
        a = hs + 15;
        translate([o, o,  3 - a]) cylinder(d = d + 0.2, h = a);
        translate([w - o, h - o, 3 - a]) cylinder(d = d + 0.2, h = a);
        if(layout == 4)
        {
            translate([w - o, o, 3 - a]) cylinder(d = d + 0.2, h = a);
            translate([o, h - o, 3 - a]) cylinder(d = d + 0.2, h = a);
        }
    }
}

module gps(hole = false, spacer = false)
{
    board(s = [36, 25], o = 3, d = 3, hs = 5, layout = 4, hole = hole, spacer = spacer);
}

module camera(angle = 0, solid_holes = 0) { 
    translate([3.1, -1.25, 1.25])
        rotate([0, angle, 0])
            if (solid_holes == 0) {
                translate([-0.5, 0, -0.65]) cube([2.8, 2.5, 2.2]);
            } else {
                translate([0, 2.9, 0])rotate([90, 0, 0]) cylinder(d = 0.22, h = 3.3);
                translate([0, 2.9, 0.9]) rotate([90, 0, 0]) cylinder(d = 0.22, h = 3.3);
            }
}

module bottom_plate() {
    difference() {
        union() {
            hull() {
                translate([5.9, -2.25, 0]) cube([3.5, 4.5, 0.15]);
                translate([5.9, -2.85, 0]) cube([2.9, 5.7, 0.15]);
            }
            hull() {
                translate([-5.9, -2.85, 0]) cube([11.8, 5.7, 0.15]);
                translate([-2.5, -5.9, 0]) cube([5, 11.8, 0.15]);
            }
            hull() {
                translate([-9.4, -2.25, 0]) cube([3.5, 4.5, 0.15]);
                translate([-8.8, -2.85, 0]) cube([2.9, 5.7, 0.15]);
            }
        }
        translate([5.85, 1.5, -0.1]) cube([3, 0.5, 0.3]);
        translate([5.85, -2, -0.1]) cube([3, 0.5, 0.3]);
        translate([-8.85, 1.5, -0.1]) cube([3, 0.5, 0.3]);
        translate([-8.85, -2, -0.1]) cube([3, 0.5, 0.3]);
    }
}
    
module camera_plate(solid_holes = 0) {
    translate([2.1, 0, 0])
        if(solid_holes == 0)
            difference() {
                cube([2, 0.3, 3.6]);
                translate([0.5, -0.1, -0.1]) cube([1, 0.5, 0.4]);
                translate([0.8, -0.1, 0.2]) cube([0.4, 0.5, 0.3]);
                translate([0.5, -0.1, 3.3]) cube([1, 0.5, 0.4]);
                translate([0.8, -0.1, 3.1]) cube([0.4, 0.5, 0.3]);
                translate([2.7, 0.4, 1.7]) rotate([90, 0, 0]) cylinder(d = 2, h = 0.5);
                translate([-0.7, 0.4, 1.7]) rotate([90, 0, 0]) cylinder(d = 2, h = 0.5);
            }
        else {
            translate([0, 0, -0.1]) cube([0.5, 0.2, 3.8]);
            translate([1.5, 0, -0.1]) cube([0.5, 0.2, 3.8]);
        }
}

module camera_bottom_plate() {
    difference() {
        translate([0, -2.1, 0.15]) rcube([3.5, 4.2, 0.3], 0.5);
        
        translate([-0.8, 1.25, 0.15]) camera_plate(solid_holes = 1);
        translate([-0.8, -1.55, 0.15]) camera_plate(solid_holes = 1);
        translate([0.35, 1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, 1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([0.35, -1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, -1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
    }
}

module camera_upper_plate() {
    difference() {
        translate([0, -2.1, 3.45]) rcube([3.5, 4.2, 0.3], 0.5);

        translate([-0.8, 1.25, 0.15]) camera_plate(solid_holes = 1);
        translate([-0.8, -1.55, 0.15]) camera_plate(solid_holes = 1);
        translate([0.35, 1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, 1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([0.35, -1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, -1.85, 3.45]) nut(d = 0.32, h = 3, solid_holes = 1);
        
        translate([0.55, -0.4, 3.4]) cylinder(d = 0.62, h = 0.4);
    }
}

module gps_upper_plate() {
    difference() {
        translate([0, -2.1, 3.15]) rcube([3.2, 4.2, 0.3], 0.5);

        translate([1, 1.85, 3.15]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, 1.85, 3.15]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([1, -1.85, 3.15]) nut(d = 0.32, h = 3, solid_holes = 1);
        translate([2.85, -1.85, 3.15]) nut(d = 0.32, h = 3, solid_holes = 1);
        
        translate([2.7, -1.8, 3.9]) rotate([0, 0, 90]) scale(0.1) gps(true, false);
    }
}

module drone() {
    bottom_plate();

    translate([5.85, 0, 0]) {
        camera_bottom_plate();
            
        camera_upper_plate();
        
        translate([-0.8, 1.25, 0.15]) camera_plate();
        translate([-0.8, -1.55, 0.15]) camera_plate();
        
        translate([0.35, 1.85, 3.45]) nut(d = 0.3, h = 3);
        translate([2.85, 1.85, 3.45]) nut(d = 0.3, h = 3);
        translate([0.35, -1.85, 3.45]) nut(d = 0.3, h = 3);
        translate([2.85, -1.85, 3.45]) nut(d = 0.3, h = 3);
    }

    translate([-8.85, 0, 0]) { 
        gps_upper_plate();
        
        translate([2.7, -1.8, 3.9]) rotate([0, 0, 90]) scale(0.1) gps(false, true);
        
        translate([1, 1.85, 3.15]) nut(d = 0.3, h = 3);
        translate([2.85, 1.85, 3.15]) nut(d = 0.3, h = 3);
        translate([1, -1.85, 3.15]) nut(d = 0.3, h = 3);
        translate([2.85, -1.85, 3.15]) nut(d = 0.3, h = 3);
    }
}

module blueprint() {
    projection() {
        camera_bottom_plate();
        translate([5, 0, 0]) camera_upper_plate();
        translate([10, 0, 0]) gps_upper_plate();
    }
}

drone();
