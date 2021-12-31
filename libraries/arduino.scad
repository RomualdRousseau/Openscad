/* arduino.scad
 *
 * Copyright (C) Jestin Stoffel 2012
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

use <hardware.scad>

// Throughout this entire model, (0,0) is the top left mounting hole (nearest the USB port)

// thickness of the PCB
board_height = 1.8;

module arduino(spacer, solid_holes, extended_port, $fn = 20)
{
    if(solid_holes) {
        translate([0, 0, -1.5]) MountingHoles();
    }
    else {
        difference()
		{
			union()
			{
				Board();
				FemaleHeaders(0);
				MaleHeaders();
				ResetButton();
				ATMega();
			}
			MountingHoles();
		}
        
        if(spacer)
        {
            translate([0, 0, 0]) scale(10) nut(d = 0.3, h = 0.8);
            translate([-1.1, -48.4, 0]) scale(10) nut(d = 0.3, h = 0.8);
            translate([51, -15.25, 0]) scale(10) nut(d = 0.3, h = 0.8);
            translate([51, -43.25, 0]) scale(10) nut(d = 0.3, h = 0.8);
        }
    }
    
    PowerPlug(extended_port);
    USB(extended_port);
}

module ResetButton()
{
	translate([39, -26, board_height])
	{
		color([0.8, 0.8, 0.8])
		cube([6, 6, 2.2]);
		
		color([0.6, 0.4, 0.2])
		translate([3, 3, 0]) cylinder(r=1.4, h=3.5, $fn=25);
	}
}

module MaleHeaders()
{
	color([0.6, 0.6, 0.6])
	translate([0, 0, board_height])
	{
		translate([0, -7, 0]) cube([7, 5, 9.2]);
		translate([47.5, -26, 0]) cube([5, 7, 9.2]);
	}
}

module ATMega()
{
	color([0.3, 0.3, 0.3])
	translate([14, -39, board_height])
	{
		cube([35.5, 10, 7.5]);
	}
}

module FemaleHeaders(combined)
{
	color([0.3, 0.3, 0.3])
	translate([0, 0, board_height])
	{
		translate([0, -1, 0])
		{
			translate([7, 0, 0])
			{
				if(combined == 1)
				{
					cube([43, 2, 8.2]);
				}
				else
				{
					cube([21, 2, 8.2]);
					translate([22, 0, 0]) cube([21, 2, 8.2]);
				}
			}
		}

		translate([0, -50, 0])
		{
			translate([17, 0, 0])
			{
				if(combined == 1)
				{
					cube([33, 2, 8.2]);
				}
				else
				{
					cube([15.5, 2, 8.2]);
					translate([17.5, 0, 0]) cube([15.5, 2, 8.2]);
				}
			}
		}
	}
}

module PowerPlug(extended)
{
	if(extended)
	{
		translate([-26.893, -47.4929962, board_height])
		color([0.3, 0.3, 0.3])
		cube([24, 9, 11]);
	}
	else
	{
		translate([-16.893, -47.4929962, board_height])
		color([0.3, 0.3, 0.3])
		cube([14, 9, 11]);
	}
}

module USB(extended)
{
	if(extended)
	{
		translate([-31.465, -18.5623962, board_height])
		color([0.8, 0.8, 0.8])
		cube([26, 12, 11]);
	}
	else
	{
		translate([-21.465, -18.5623962, board_height])
		color([0.8, 0.8, 0.8])
		cube([16, 12, 11]);
	}
}


module Board()
{
	color([0, 0.6, 0.8])
	linear_extrude(height = board_height, convexity = 10, twist = 0)
	{
		polygon( points = [ [-15.115, 2.545],
						[49.4, 2.545],
						[50.925, 1.021],
						[50.925, -10.409],
						[53.465, -12.949],
						[53.465, -45.715],
						[50.925, -48.255],
						[50.925, -50.795],
						[-15.115, -50.795] ],
				paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8]],
				convexity = 10);
	}
}

module MountingHoles()
{
	translate([0, 0, -10])
	{
		ArduinoHole(25);
		translate([-1.0929112, -48.4026972, 0]) ArduinoHole(25);
		translate([51, -15.25, 0]) ArduinoHole(25);
		translate([51, -43.25, 0]) ArduinoHole(25);
	}
}

module ArduinoHole(length)
{
	cylinder(r=1.5, h=length, $fn=25);
}

