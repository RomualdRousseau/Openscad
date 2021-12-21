include <raspberrypi.scad>

module usb_plug() {
    translate([15 - 8, -10, 0]) cube([16, 20, 12]);
    translate([0, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3.1, h = 20, $fn = 20);
    translate([30, 10, 6]) rotate([90, 0, 0]) cylinder(d = 3.1, h = 20, $fn = 20);
}

module fan() {
    translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4, h = 20, $fn = 20);
    translate([32, 10, 0]) rotate([90, 0, 0]) cylinder(d = 4, h = 20, $fn = 20);
    translate([32, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4, h = 20, $fn = 20);
    translate([0, 10, 32]) rotate([90, 0, 0]) cylinder(d = 4, h = 20, $fn = 20);
    translate([16, 10, 16]) rotate([90, 0, 0]) cylinder(d = 40, h = 20, $fn = 20);
}

module led() {
    translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(h = 20, d = 8);
}

module power_plug() {
    rotate([90, 0, 0]) cylinder(h = 20, d = 12);
}

module power_button() {
    rotate([90, 0, 0]) cylinder(h = 20, d = 28);
}

module renfort(r = 0, solid_holes = false) {
    if (solid_holes) {
        rotate([0, 0, r])  translate([5, 5, -10]) cylinder(d = 3.1, h = 20, $fn = 20);
    } else {
        rotate([0, 0, r]) difference() {
            linear_extrude(height = 4) polygon([[0, 0], [20, 0], [0, 20]]);
            translate([5, 5, -10]) cylinder(d = 3.1, h = 20, $fn = 20);
        }
    }
}

module bottom_plate() {
    difference() {
        cube([200, 100, 4]);
        // Raspberry PI
        translate([80, 53, 14]) raspberrypi(solid_holes = true);
        // holes
        translate([0, 0, 4]) renfort(r = 0, solid_holes = true);
        translate([200, 0, 4]) renfort(r = 90, solid_holes = true);
        translate([200, 100, 4]) renfort(r = 180, solid_holes = true);
        translate([0, 100, 4]) renfort(r = 270, solid_holes = true);
    }
}

module top_plate() {
    difference() {
        cube([200, 100, 4]);
    }
}

module side_plate() {
    cube([4, 100, 50]);
}

module back_plate() {
    difference() {
        cube([208, 2, 50]);
        // Raspberry PI back panel
        translate([84, 55, 14]) raspberrypi(solid_holes = true, extended_port = true);
        // Power plug
        translate([20, 10, 18]) power_plug();
        // Cooling holes
        translate([40, 0, 9]) fan();
        translate([150, 0, 9]) fan();
    }
}

module front_plate() {
    difference() {
        cube([208, 2, 50]);
        // Power button
        translate([170, 10, 25]) power_button();
        // USB ports
        translate([110, 0, 19]) usb_plug();
        translate([60, 0, 19]) usb_plug();
        // LED
        translate([15, 0, 35]) led();
    }
}

module box() {
    bottom_plate();
    translate([0, 0, 46]) top_plate();

    translate([-4, 0, 0]) side_plate();
    translate([200, 0, 0]) side_plate();
    
    translate([-4, 100, 0]) front_plate();
    translate([-4, -2, 0]) back_plate();
    
    translate([0, 0, 4]) renfort(r = 0);
    translate([200, 0, 4]) renfort(r = 90);
    translate([200, 100, 4]) renfort(r = 180);
    translate([0, 100, 4]) renfort(r = 270);
    
    translate([0, 0, 42]) renfort(r = 0);
    translate([200, 0, 42]) renfort(r = 90);
    translate([200, 100, 42]) renfort(r = 180);
    translate([0, 100, 42]) renfort(r = 270);
    
    translate([80, 53, 14]) raspberrypi(spacer= true);
}

module blueprint() {
    projection() {
        bottom_plate();
        translate([0, 110, 0]) top_plate();
        
        translate([210, 110, 4]) rotate([0, 90, 0]) side_plate();
        translate([210, 0, 4]) rotate([0, 90, 0]) side_plate();
        
        translate([0, 220, 2]) rotate([-90, 0, 0]) front_plate();
        translate([0, 280, 2]) rotate([-90, 0, 0]) back_plate();
        
        translate([215, 220, 0]) renfort(r = 0);
        translate([260, 220, 0]) renfort(r = 90);
        translate([235, 250, 0]) renfort(r = 180);
        translate([240, 250, 0]) renfort(r = 270);
        
        translate([215, 260, 0]) renfort(r = 0);
        translate([260, 260, 0]) renfort(r = 90);
        translate([235, 290, 0]) renfort(r = 180);
        translate([240, 290, 0]) renfort(r = 270);
    }
}

box();

