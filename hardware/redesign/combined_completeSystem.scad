use <electronic_object_laser_emitter.scad>
use <structural_mount_laser_top.scad>
use <structural_mount_laser_bottom.scad>
use <mechanical_object_9gServo.scad>
use <mechanical_device_laserShutter_top.scad>
use <mechanical_device_laserShutter_bottom.scad>


structural_mount_laser_top();
structural_mount_laser_bottom();
laserEmitter();

translate([88,0,0]){
	translate([0,25,0]) rotate([90,0,0]) 9g_motor();
	laserShutter_Top();
	laserShutter_Bottom();
}

translate([30,0,30]) color([1,0,0]) cube(size=[165,1,1],center=true);