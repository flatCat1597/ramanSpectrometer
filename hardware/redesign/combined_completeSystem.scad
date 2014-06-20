use <rw_electronic_object_laser_emitter.scad>
use <electronic_mount_laser_top.scad>
use <electronic_mount_laser_bottom.scad>
use <rw_mechanical_object_9gServo.scad>
use <mechanical_device_laserShutter_top.scad>
use <mechanical_device_laserShutter_bottom.scad>
use <optics_module_surfaceMirror_top.scad>
use <optics_module_surfaceMirror_bottom.scad>
use <optics_module_beamSplitter_top.scad>

use <combined_optoMechanical_objective-cuvette-displayAssembly.scad>
use <rw_electronic_object_tftDisplay.scad>
use <trim_tftFaceplate_facia.scad>

structural_mount_laser_top();
structural_mount_laser_bottom();
laserEmitter();

translate([85,-45,0]){
	rotate([0,0,270]){
		laserShutter_Top();
		laserShutter_Bottom();
	}
}
translate([110,-46,0]){
	 rotate([90,0,270]){
		9g_motor();
	}
}


translate([85,0,0]){
	mirror_mount_top();
	mirror_mount_bottom();
}
translate([85,0,0]){
	mirror();
}

translate([50,0,30]) color([1,0,0]) cube(size=[200,1,1],center=true);

translate([85,-111,0]){
	rotate([0,0,180]){
		bodyUnit();
	}
}


translate([85,-206,22]){
	mainBox();
	translate([0,-35,-22]){
		objectiveMount();
	}
	translate([0,-100,-60]){
		tray();
	}
	translate([-50,-101,53.75]){
		translate([-25.25,-11.5,11.5]){
			rotate([45,0,0]){
				screen();
			}
		}
		rotate([-45,0,180]){
			displayPlate();
			trim_tftFacePlate_facia();
		}
	}
}