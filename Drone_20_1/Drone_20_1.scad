use <hardware.scad>;

$fn = 50;
prop_size = 3;
prop_pitch = 2;
arm_len = floor(prop_size * 2.54 / 2 + 3);

module propeller() {
    color("Purple", 0.5) cylinder(d = prop_size * 2.54, h = prop_pitch * 2.54 * 0.1);
}

module motor(solid_holes = 0) {
    if (solid_holes == 0) {
        color("DarkSlateGray") cylinder(d = 1.4, h = 1.2);
    } else {
        translate([0, 0, -0.9]) cylinder(d = 0.4, h = 1);
        translate([0.45, 0, -0.9]) cylinder(d = 0.22, h = 1);
        translate([-0.45, 0, -0.9]) cylinder(d = 0.22, h = 1);
        translate([0, 0.45, -0.9]) cylinder(d = 0.22, h = 1);
        translate([0, -0.45, -0.9]) cylinder(d = 0.22, h = 1);
    }
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

module antenna_filler() {
    difference() {
        translate([-5.9, -0.4, 1.2])
            rotate([0, 90, 0])
                cylinder(d = 0.9, h = 0.1);
        translate([-6, -0.4, 1.2])
                rotate([0, 90, 0])
                    cylinder(d = 0.61, h = 0.3);
    }
}

module antenna_support(solid_holes = 0) {
    if (solid_holes == 0) {
        difference() {
            union() {
                translate([-5.8, -1, 0.3])
                    cube([0.3, 2, 1.5]);
                translate([-5.8, -0.75, 0])
                    cube([0.3, 1.5, 0.3]);
            }
            translate([-5.9, -0.4, 1.2])
                    rotate([0, 90, 0])
                        cylinder(d = 0.61, h = 0.5);
        }
    } else {
        translate([-5.8, -0.75, -0.1])
            cube([0.3, 1.5, 0.5]);
    }
}

module bottom_plate() {
    difference() {
        union() {
            // Body
            translate([-5, -2, 0])
                rcube([10, 4, 0.3], 1);
           // Arms
            hull() {
                translate([arm_len, arm_len, 0])
                    cylinder(d = 1.5, h = 0.3);
                translate([-arm_len, -arm_len, 0])
                    cylinder(d = 1.5, h = 0.3);
            }
            hull() {
                translate([-arm_len, arm_len, 0])
                    cylinder(d = 1.5, h = 0.3);
                translate([arm_len, -arm_len, 0])
                    cylinder(d = 1.5, h = 0.3);
            }
        }
        translate([-5, -2, 0]) {
            translate([2, 1, -0.1]) rcube([1.5, 2, 0.5], 0.3);
            translate([6.5, 1, -0.1]) rcube([2.5, 2, 0.5], 0.5);
            translate([5, 2, -0.1]) cylinder(d = 2, h = 0.5);
            translate([3.4, 1.5, -0.1]) cube([3.2, 1, 0.5]);
        }
    }
}

module upper_plate() {
    translate([-5, -2, 3.3])
        difference() {
            rcube([10, 4, 0.2], 1);
            translate([1, 0.5, -0.1]) rcube([4.5, 1, 0.5], 0.4);
            translate([1, 2.5, -0.1]) rcube([4.5, 1, 0.5], 0.4);
            translate([6.5, 1, -0.1]) rcube([2.5, 2, 0.5], 0.4);
            translate([0.25, 0.8, -0.1]) rcube([0.25, 0.5, 0.4]);
            translate([0.25, 2.7, -0.1]) rcube([0.25, 0.5, 0.4]);
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
            translate([0, 0, -0.1]) cube([0.5, 0.2, 3.7]);
            translate([1.5, 0, -0.1]) cube([0.5, 0.2, 3.7]);
        }
}

module propellers() {
    translate([arm_len, arm_len, 1.5])
        propeller();
    translate([-arm_len, arm_len, 1.5])
        propeller();
    translate([-arm_len, -arm_len, 1.5])
        propeller();
    translate([arm_len, -arm_len, 1.5])
        propeller();
}

module motors(solid_holes = 0) {
    translate([arm_len, arm_len, 0.3])
        motor(solid_holes);
    translate([-arm_len, arm_len, 0.3])
        motor(solid_holes);
    translate([-arm_len, -arm_len, 0.3])
        motor(solid_holes);
    translate([arm_len, -arm_len, 0.3])
        motor(solid_holes);
}


module toises(solid_holes = 0) {
    // Plates support
    translate([4.5, 1.5, 3.3])
        nut(d = 0.32, h = 3, solid_holes = solid_holes);
    translate([4.5, -1.5, 3.3])
        nut(d = 0.32, h = 3, solid_holes = solid_holes);
    translate([-4.5, -1.5, 3.3])
        nut(d = 0.32, h = 3, solid_holes = solid_holes);
    translate([-4.5, 1.5, 3.3])
        nut(d = 0.32, h = 3, solid_holes = solid_holes);
    
    // 4-in-1 ESC
    translate([1, 1, 0.8])
        nut(d = 0.22, h = 0.5, solid_holes = solid_holes);
    translate([1, -1, 0.8])
        nut(d = 0.22, h = 0.5, solid_holes = solid_holes);
    translate([-1, -1, 0.8])
        nut(d = 0.22, h = 0.5, solid_holes = solid_holes);
    translate([-1, 1, 0.8])
        nut(d = 0.22, h = 0.5, solid_holes = solid_holes);
    
    // Flight Controller
    //translate([1.775, 1.775, 1.2])
    //    nut(d = 0.32, h = 1, solid_holes = solid_holes);
    //translate([1.775, -1.775, 1.2])
    //    nut(d = 0.32, h = 1, solid_holes = solid_holes);
    //translate([-1.775, -1.775, 1.2])
    //    nut(d = 0.32, h = 1, solid_holes = solid_holes);
    //translate([-1.775, 1.775, 1.2])
    //    nut(d = 0.32, h = 1, solid_holes = solid_holes);
    
    // Landing gear
    translate([arm_len / 2 + 0.5, arm_len / 2 + 0.5, 0])
        nut(d = 0.32, h = 1, solid_holes = solid_holes); 
    translate([arm_len / 2 + 0.5, -arm_len / 2 - 0.5, 0])
        nut(d = 0.32, h = 1, solid_holes = solid_holes); 
    translate([-arm_len / 2 - 0.5, -arm_len / 2 - 0.5, 0])
        nut(d = 0.32, h = 1, solid_holes = solid_holes); 
    translate([-arm_len / 2 - 0.5, arm_len / 2 + 0.5, 0])
        nut(d = 0.32, h = 1, solid_holes = solid_holes); 
}

module drone() {
    color("lime") difference() {
        bottom_plate();
        motors(solid_holes = 1);
        toises(solid_holes = 1);
    }

    color("lime") difference() {
        upper_plate();
        motors(solid_holes = 1);
        toises(solid_holes = 1);
    }
    
    toises();
    motors();
    propellers();
}

module blueprint() {
    translate([6.5, 6.5, 0]) {
        projection() rotate([0, 0, 90]) difference() {
            bottom_plate();
            motors(solid_holes = 1);
            toises(solid_holes = 1);
        }
        
        translate([11.5, 0, 0]) projection() rotate([0, 0, 90]) difference() {
            upper_plate();
            toises(solid_holes = 1);
        }
    }
}

drone();
//scale(10) blueprint();