/* raspberrypi.scad
 *
 * Copyright (C) Romuald Rousseau 2020
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
use <electronic.scad>

// Throughout this entire model, (0,0) is the top left mounting hole (nearest the GPIO port)

// thickness of the PCB
board_height = 1.8;

module raspberrypi(type = "B", spacer, solid_holes, extended_port, $fn = 20)
{
    translate([-3.5, -52.5, 0]) 
    {
        if (solid_holes) {
            MountingHoles();
        }
        else {
            difference() {
                union() {
                    Board(type);
                    SdCard();
                    GPIO();
                }
                MountingHoles();
            }

            if (spacer) {
                translate([3.5, 3.5, 0]) scale(10) nut(d = 0.3, h = 1);
                translate([3.5, 52.5, 0]) scale(10) nut(d = 0.3, h = 1);
                translate([61.5, 3.5, 0]) scale(10) nut(d = 0.3, h = 1);
                translate([61.5, 52.5, 0]) scale(10) nut(d = 0.3, h = 1);
            }
        }
        
        if (type == "A") {
            USB_A(extended_port);
        } 
        if (type == "B") {
            USB_B(extended_port);
            Ethernet(extended_port);
        } 
        Power(extended_port);
        HDMI(extended_port);
        HeadPhone(extended_port);
    }
}

module raspberrypi_hat(spacer, solid_holes, $fn = 20)
{
    translate([-3.5, -52.5, 13.3]) 
    {
        if (solid_holes) {
            MountingHoles();
        }
        else {
            difference() {
                union() {
                    Board("A");
                    translate([32.4, 51, board_height - 10.5]) scale(10) jumper_female(count = 20);
                    translate([32.4, 53.5, board_height - 10.5]) scale(10) jumper_female(count = 20);
                }
                MountingHoles();
            }
        }
        
        if (spacer) {
            translate([3.5, 3.5, 0.3]) scale(10) nut(d = 0.3, h = 1.2);
            translate([3.5, 52.5, 0.3]) scale(10) nut(d = 0.3, h = 1.2);
            translate([61.5, 3.5, 0.3]) scale(10) nut(d = 0.3, h = 1.2);
            translate([61.5, 52.5, 0.3]) scale(10) nut(d = 0.3, h = 1.2);
        }
    }
}

module Ethernet(extended_port)
{
    if(extended_port) {
        translate([66, 2.5, board_height]) color("Silver") cube([31, 15.3, 13.5]);
    }
    else {
        translate([66, 2.5, board_height]) color("Silver") cube([21, 15.3, 13.5]);
    }
}

module SdCard()
{
    translate([0, 21, -1.5]) color("Silver") cube([15.1, 14.5, 1.5]);
}

module Power(extended_port)
{
    if(extended_port) {
        translate([6.5, -11, board_height]) color("Silver") cube([8, 15, 3]);
    }
    else {
        translate([6.5, -1, board_height]) color("Silver") cube([8, 5, 3]);
    }
}

module USB_A(extended_port)
{
    if(extended_port) {
        translate([49.5, 25, board_height]) color("Silver") cube([27.5, 14, 7]);
    }
    else {
        translate([49.5, 25, board_height]) color("Silver") cube([17.5, 14, 7]);
    }
}

module USB_B(extended_port)
{
    if(extended_port) {
        translate([69.5, 22, board_height]) color("Silver") cube([27.5, 14, 15.5]);
        translate([69.5, 40, board_height]) color("Silver") cube([27.5, 14, 15.5]);
    }
    else {
        translate([69.5, 22, board_height]) color("Silver") cube([17.5, 14, 15.5]);
        translate([69.5, 40, board_height]) color("Silver") cube([17.5, 14, 15.5]);
    }
}

module HDMI(extended_port)
{
    if(extended_port) {
        translate([24.3, -12, board_height]) color("Silver") cube([15.1, 22, 6.6]);
    }
    else {
        translate([24.3, -2, board_height]) color("Silver") cube([15.1, 12, 6.6]);
    }
}

module GPIO()
{
    translate([32.4, 51, board_height]) scale(10) jumper(count = 20);
    translate([32.4, 53.5, board_height]) scale(10) jumper(count = 20);
}

module HeadPhone(extended_port)
{
    translate([50, 0, board_height]) color("DarkSlateGray") cube([6.9, 11.5, 6]);
    if(extended_port) {
        translate([53.5, 0, board_height + 3]) rotate([90, 0, 0]) color("Silver") cylinder(d = 6, h = 12.5);
    }
    else {
        translate([53.5, 0, board_height + 3]) rotate([90, 0, 0]) color("Silver") cylinder(d = 6, h = 2.5);
    }
}

module Board(type = "A")
{
    if (type == "A") {
        color("green") rcube(size = [65, 56, board_height], radius = 5);
    }
    
    if (type == "B") {
        color("green") rcube(size = [85, 56, board_height], radius = 5);
    }
}

module MountingHoles()
{
    translate([3.5, 3.5, -20]) cylinder(d = 3, h = 40);
    translate([3.5, 52.5, -20]) cylinder(d = 3, h = 40);
    translate([61.5, 3.5, -20]) cylinder(d = 3, h = 40);
    translate([61.5, 52.5, -20]) cylinder(d = 3, h = 40);
}
