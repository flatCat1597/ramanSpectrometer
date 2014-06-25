use <mechanical_object_9gServo.scad>
use <mechanical_device_laserShutter_top.scad>
use <mechanical_device_laserShutter_bottom.scad>

//translate([0,0,20]) cube(size=[48,1,1],center=true);
translate([0,25,0]) rotate([90,0,0]) 9g_motor();

laserShutter_Top();
laserShutter_Bottom();