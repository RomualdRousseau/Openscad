include <raspberrypi.scad>

output = "model";
clearance = 0.1;
gap = 18;

module joystick(space = 5, holes = false) {
    if (holes) {
        translate([0, 0, -1]) {
            translate([-53 / 2 + 5 / 2 + 4, -95 / 2 + 5 / 2 + 2, -2]) cylinder(h = 20, d = 3 + clearance, $fn = 20);
            translate([-53 / 2 + 5 / 2 + 4, 95 / 2 - 5 / 2 - 2, -2]) cylinder(h = 20, d = 3 + clearance, $fn = 20);
            translate([53 / 2 - 5 / 2 - 4, 95 / 2 - 5 / 2 - 2, -2]) cylinder(h = 20, d = 3 + clearance, $fn = 20);
            translate([53 / 2 - 5 / 2 - 4, -95 / 2 + 5 / 2 + 2, -2]) cylinder(h = 20, d = 3 + clearance, $fn = 20);
            translate([0, 0, -2]) cylinder(h = 20, d = 24, $fn = 20);
        }
    } else {
        color("Red") translate([0, 0, 31 + 35 / 2]) sphere(d = 35);
        color("Silver") cylinder(h = 33, d = 7);
        color("Black") translate([0, 0, space]) cylinder(h = 1, d = 39);
        
        translate([0, 0, -1]) difference() {
            color("Silver") cube([53, 95, 2], center = true);
            translate([-53 / 2 + 5 / 2 + 4, -95 / 2 + 5 / 2 + 2, -2]) cylinder(h = 4, d = 5);
            translate([-53 / 2 + 5 / 2 + 4, 95 / 2 - 5 / 2 - 2, -2]) cylinder(h = 4, d = 5);
            translate([53 / 2 - 5 / 2 - 4, 95 / 2 - 5 / 2 - 2, -2]) cylinder(h = 4, d = 5);
            translate([53 / 2 - 5 / 2 - 4, -95 / 2 + 5 / 2 + 2, -2]) cylinder(h = 4, d = 5);
        }
        
        color("Black")  translate([0, 0, -35 / 2 - 2]) cube([63, 63, 35], center = true);
    }
}

module button_big(space = 5, holes = false) {
    if (holes) {
        translate([0, 0, -18 + space]) cylinder(h = 20, d = 30 + clearance, $fn = 20);
    } else {
        color("Red") translate([0, 0, space - 12]) cylinder(h = 12, d = 30);
        color("Red") translate([0, 0, space]) cylinder(h = 4, d = 33);
        color("Red") translate([0, 0, space + 4]) cylinder(h = 4, d = 29);
    }
}

module button_small(space = 5, holes = false) {
    if (holes) {
        translate([0, 0, -18 + space]) cylinder(h = 20, d = 24 + clearance, $fn = 20);
    } else {
        color("Red") translate([0, 0, space - 15]) cylinder(h = 15, d = 23);
        color("Red") translate([0, 0, space]) cylinder(h = 4, d = 27);
        color("Red") translate([0, 0, space + 4]) cylinder(h = 4, d = 22);
    }
}

module usb_plug(holes = false) {
    if (holes) {
        translate([15 - 8, -10, 1]) cube([16, 20, 10]);
        translate([0, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3 + clearance, h = 20, $fn = 20);
        translate([30, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3 + clearance, h = 20, $fn = 20);
    } else {
        color("Gray", 0.5) translate([15 - 8, -10, 1]) cube([16, 20, 10]);
        color("Gray", 0.5) translate([0, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3, h = 20);
        color("Gray", 0.5) translate([30, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3, h = 20);
    }
}

module fan(holes = false) {
    if (holes) {
        translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4 + clearance, h = 20, $fn = 20);
        translate([32, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4 + clearance, h = 20, $fn = 20);
        translate([32, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4 + clearance, h = 20, $fn = 20);
        translate([0, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4 + clearance, h = 20, $fn = 20);
        translate([16, 10, 16]) rotate([90, 0, 0]) cylinder(d = 40, h = 20, $fn = 20);
    } else {
        color("Gray", 0.5) translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4, h = 20);
        color("Gray", 0.5) translate([32, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4, h = 20);
        color("Gray", 0.5) translate([32, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4, h = 20);
        color("Gray", 0.5) translate([0, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4, h = 20);
        color("Gray", 0.5) translate([16, 10, 16]) rotate([90, 0, 0]) cylinder(d = 40, h = 20);
    }
}

module power_led(holes = false) {
    if (holes) {
        translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(h = 20, d = 8 + clearance);
    } else {
        color("Gray", 0.5) translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(h = 20, d = 8);
    }
}

module power_plug(holes = false) {
    if (holes) {
        rotate([90, 0, 0]) cylinder(h = 20, d = 12 + clearance);
    } else {
        color("Gray", 0.5) rotate([90, 0, 0]) cylinder(h = 20, d = 12);
    }
}

module power_button(holes = false) {
    if (holes) {
        rotate([90, 0, 0]) cylinder(h = 20, d = 28 + clearance);
    } else {
        color("Gray", 0.5) rotate([90, 0, 0]) cylinder(h = 20, d = 28);
    }
}

module renfort(r = 0, holes = false) {
    if (holes) {
        rotate([0, 0, r]) translate([-4, -4, 0]) {
            translate([10, 10, -10]) cylinder(d = 3 + clearance, h = 20, $fn = 20);
            translate([-1, -1, 0]) cube([25, 25, 4]);
        }
    } else {
        rotate([0, 0, r]) translate([-4, -4, 0]) difference() {
            linear_extrude(height = 4) polygon([[0, 0], [24, 0], [24, 4], [4, 24], [0, 24]]);
            translate([10, 10, -10]) cylinder(d = 3 + clearance, h = 20, $fn = 20);
        }
    }
}

module parts(holes = false) {
    translate([0, 0, 0]) joystick(space = 4, holes = holes);

    translate([150, -10, 0]) rotate([0, 0, 10]) {
        translate([-gap * 3, gap, 0]) button_big(space = 4, holes = holes);
        translate([-gap, gap * 2 + 10, 0]) button_big(space = 4, holes = holes);
        translate([gap, gap * 2, 0]) button_big(space = 4, holes = holes);
        translate([gap * 3, gap, 0]) button_big(space = 4, holes = holes);

        translate([-gap * 3, -gap, 0]) button_big(space = 4, holes = holes);
        translate([-gap, 10, 0]) button_big(space = 4, holes = holes);
        translate([gap, 0, 0]) button_big(space = 4, holes = holes);
        translate([gap * 3, -gap, 0]) button_big(space = 4, holes = holes);
    }

    translate([40, 70, 0]) button_small(space = 4, holes = holes);
    translate([40 + gap * 2, 70, 0]) button_small(space = 4, holes = holes);

    translate([200, 46, -39]) rotate([0, 0, 180])
        raspberrypi(spacer= true, solid_holes = holes, extended_port = holes);
    
    translate([180, -100, -30]) usb_plug(holes = holes);
    translate([130, -100, -30]) usb_plug(holes = holes);
    
    translate([100, 100, -40]) fan(holes = holes);
    
    translate([0, 110, -35]) power_plug(holes = holes);
    
    translate([-60, 60, -25]) rotate([0, 0, 90]) power_button(holes = holes);
    translate([-20, 80, 0]) rotate([90, 0, 0]) power_led(holes = holes);
}

module renforts(holes = false) {
    color("DeepPink") translate([-50, -100, 0]) {
        translate([0, 0, -4 - clearance]) renfort(r = 0, holes = holes);
        translate([300, 0, -4 - clearance]) renfort(r = 90, holes = holes);
        translate([300, 200, -4 - clearance]) renfort(r = 180, holes = holes);
        translate([0, 200, -4 - clearance]) renfort(r = 270, holes = holes);
        
        translate([0, 0, -49 + clearance]) renfort(r = 0, holes = holes);
        translate([300, 0, -49 + clearance]) renfort(r = 90, holes = holes);
        translate([300, 200, -49 + clearance]) renfort(r = 180, holes = holes);
        translate([0, 200, -49 + clearance]) renfort(r = 270, holes = holes);
    }
}

module front_plate() {
    difference() {
        translate([-50, -100, 0]) color("Pink") translate([0, -4, -53]) cube([300, 4, 58]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module back_plate() {
    difference() {
        translate([-50, -100, 0]) color("Pink") translate([0, 200, -53]) cube([300, 4, 58]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module left_plate() {
    difference() {
        translate([-50, -100, 0]) color("Pink") translate([-4, -4, -53]) cube([4, 208, 58]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module right_plate() {
    difference() {
        translate([-50, -100, 0]) color("Pink") translate([300, -4, -53]) cube([4, 208, 58]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module top_plate() {
    difference() {
        translate([-50, -100, 0]) color("Silver", 0.5) cube([300, 200, 4]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module bottom_plate() {
    difference() {
        translate([-50, -100, 0]) color("Pink") translate([0, 0, -53]) cube([300, 200, 4]);
        renforts(holes = true);
        parts(holes = true);
    }
}

module box() {
    top_plate();
    bottom_plate();
    back_plate();
    front_plate();
    left_plate();
    right_plate();
}

module model() {
    translate([54, 104, 53]) {
        box();
        renforts();
        parts();
    }
}

module blueprint() {
    projection() {
        translate([50, 100, 0]) top_plate();
        translate([50, 310, 0]) bottom_plate();
        
        translate([360, 4, 0 ]) rotate([90, 0, 0]) front_plate();
        translate([360, 72, 0 ]) rotate([90, 0, 0]) back_plate();
        translate([414, 189, 0 ]) rotate([0, 90, 90]) left_plate();
        translate([414, 257, 0 ]) rotate([0, 90, 90]) right_plate();
        
        translate([532, 140, 0 ]) renfort();
        translate([532 + 35, 140, 0 ]) renfort();
        translate([532 + 70, 140, 0 ]) renfort();
        translate([532, 210, 0 ]) renfort();
        
        translate([532, 175, 0 ]) renfort();
        translate([532 + 35, 175, 0 ]) renfort();
        translate([532 + 70, 175, 0 ]) renfort();
        translate([532 + 35, 210, 0 ]) renfort();
    }
}

module blueprint1() {
    projection() {
        translate([100, 50, 0]) rotate([0, 0, 90]) top_plate();
    }
}

module blueprint2() {
    projection() {
        translate([100, 50, 0]) rotate([0, 0, 90]) bottom_plate();
    }
}

module blueprint3() {
    projection() {
        translate([53, 50, 0 ]) rotate([90, 0, 90]) front_plate();
        translate([121, 50, 0 ]) rotate([90, 0, 90]) back_plate();
    }
}

module blueprint4() {
    projection() {
        translate([53, 104, 0 ]) rotate([0, 90, 0]) left_plate();
        translate([121, 104, 0 ]) rotate([0, 90, 0]) right_plate();
        
        translate([4, 222, 0 ]) renfort();
        translate([4 + 35, 222, 0 ]) renfort();
        translate([4 + 70, 222, 0 ]) renfort();
        translate([4 + 105, 222, 0 ]) renfort();
        
        translate([4, 252, 0 ]) renfort();
        translate([4 + 35, 252, 0 ]) renfort();
        translate([4 + 70, 252, 0 ]) renfort();
        translate([4 + 105, 252, 0 ]) renfort();
    }
}

if (output == "blueprint") {
    blueprint();
} else if (output == "blueprint1") {
    blueprint1();
} else if (output == "blueprint2") {
    blueprint2();
} else if (output == "blueprint3") {
    blueprint3();
} else if (output == "blueprint4") {
    blueprint4();
} else {
    scale(0.1) model();
}