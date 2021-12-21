$fn = 50;

//linear_extrude(height = 2, center = true, convexity = 10)
//		import(file = "source_one-master/SO_v3_cam_plate_2mm_2x.dxf");

module top_plate()
{
    translate([6, 0, 0]) linear_extrude(height = 2, center = true, convexity = 10)
            import(file = "source_one-master/SO_v3_top_plate_2mm.dxf");
}

module center_plate()
{
    linear_extrude(height = 3, center = true, convexity = 10)
		import(file = "source_one-master/SO_v3_center_plate_3mm.dxf");
}

module bottom_plate()
{
   linear_extrude(height = 3, center = true, convexity = 10)
		import(file = "source_one-master/SO_v3_bottom_plate_3mm.dxf");
}

module arm()
{
    translate([11.9, -254.7, 0.5]) linear_extrude(height = 4, center = true, convexity = 10)
        scale([0.25, 0.25, 0.25]) import(file = "arm.dxf");
}

translate([0, 0, 30]) top_plate();
translate([0, 0, -3]) center_plate();
translate([0, 0, -10]) bottom_plate();
translate([-15.2, -15.2, -7]) rotate([0, 0, 55]) arm();
translate([15.2, 15.2, -7]) rotate([0, 0, 55+180]) arm();
translate([-15.2, 15.2, -7]) rotate([0, 0, 35+270]) arm();
translate([15.2, -15.2, -7]) rotate([0, 0, 35+90]) arm();