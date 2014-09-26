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

use <mechanical_device_filterSelectorAssembly.scad>
use <optics_module_spectrometer_v04.scad>

module ramanSystem(){
structural_mount_laser_top();
structural_mount_laser_bottom();
laserEmitter();

color([0.4,0.6,0]){
	translate([85,-45,0]){
		rotate([0,0,270]){
			laserShutter_Top();
			laserShutter_Bottom();
		}
	}
}
translate([110,-46,0]){
	 rotate([90,0,270]){
		color("blue") 9g_motor();
	}
}

color([0.2,0.8,0.6]){
	translate([85,0,0]){
		mirror_mount_top();
		mirror_mount_bottom();
	}
}
translate([85,0,0]){
	mirror();
}
translate([85,-206,22]){
	stepperMotorPinion();
}
//translate([50,0,30]) color([1,0,0]) cube(size=[200,1,1],center=true);

translate([85,-111,0]){
	rotate([0,0,180]){
		bodyUnit();
	}
}

translate([85,-206,22]){
	//mainBox();
	translate([0,-35,-22]){
		objectiveMount();
	}
	translate([0,-70,-60]){
		tray();
		traySupports();
		%translate([0,-60,35]) cube(size=[12,12,45],center=true);
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
translate([-35,-96,-0]) rotate([-90,-90,180]) spectrometer();
translate([50,-96,0]){
	rotate([0,0,90]){
		main();
color("orange")		box();
	}
}
}

difference(){
//	translate([-30,-115,20]) color([0.25,0.25,0.25]) cube(size=[310,350,250],center=true);
//	translate([-30,-115,22]) color([0.25,0.25,0.25]) cube(size=[308,348,248],center=true);
}

//animate
function saw(t) = 1 - 2*abs(t-0.5);    
rotate([0,0,saw($t)*360,0])  ramanSystem();