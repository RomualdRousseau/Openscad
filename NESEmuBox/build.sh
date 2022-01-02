#!/bin/sh

mkdir dxf
openscad --o dxf/blueprint1.dxf -D 'output="blueprint1"' NESEmuBox_v2.scad
openscad --o dxf/blueprint2.dxf -D 'output="blueprint2"' NESEmuBox_v2.scad
openscad --o dxf/blueprint3.dxf -D 'output="blueprint3"' NESEmuBox_v2.scad
openscad --o dxf/blueprint4.dxf -D 'output="blueprint4"' NESEmuBox_v2.scad
