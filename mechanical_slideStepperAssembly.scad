use <mechanical_slideStepperMotor.scad>
use <filterMount_550LP_top.scad>
use <filterMount_550LP_bottom.scad>
use <filterMount_522SP_bottom.scad>
use <filterMount_522SP_top.scad>
use <filterMount_interference_bottom.scad>
use <filterMount_interference_top.scad>
use <filterMount_retainingBracket.scad>

use <mechanical_slideStepper_mountingBracket_large.scad>
use <mechanical_slideStepper_mountingBracket_small.scad>
use <mechanical_slideStepper_frame.scad>

filterInPosition = -10;
filterInStorage = 50;

//%translate([0,0,0]) color([0.9,0.9,0.7]) cube(size=[280,230,2],center=true);
module laserBeam(length){
	rotate([0,90,0]) color([0,1,0]) cylinder(h=length,r=.5,$fn=50,center=true);	
}
translate([0,-85,70]) {
	laserBeam(200);
}
rotate([0,0,90]){
	translate([0,10,70]) {
		laserBeam(170);
	}
}
translate([-60,85,70]) {
	laserBeam(100);
}
module photoSensor(){
	rotate([0,90,0]) color([0.9,0.2,0.0]) cube(size=[4.65,6.10,4.39],center=true);
	translate([-1.11,0,1.5]) color([0,0,0]) cube(size=[1,3,2],center=true);
	translate([1.11,0,1.5]) color([0,0,0]) cube(size=[1,3,2],center=true);
}

//photoSensors
translate([-51,-34,12]){
	photoSensor();
}
translate([-1,-34,12]){
	photoSensor();
}
translate([-51,34,12]){
	photoSensor();
}
translate([-1,34,12]){
	photoSensor();
}
translate([-51,-4,12]){
	photoSensor();
}
translate([-1,-4,12]){
	photoSensor();
}

/*
//stepperAssembly
translate([14,0,2]){
	mechanical_slideStepper_frame();
}
translate([-16,0,0]){
	mechanical_slideStepper_slides();
}
*/
mechanical_lensCassette();
translate([filterInPosition,-34,-38]){
	mechanical_slideStepper_mountingBracket_small();
}
translate([filterInPosition,-4,-38]){
	mechanical_slideStepper_mountingBracket_small();
}
translate([filterInStorage,34,-38]){
	mechanical_slideStepper_mountingBracket_large();
}

//steppers
translate([69,-34,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
}
translate([69,-4,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
}
translate([69,34,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
}

//522SP_Filter
translate([filterInPosition,-40,70]){
	rotate([90,180,0]){
		filterMountRetainingBracket();
	}
}
translate([filterInPosition,-28,70]){
	rotate([90,180,180]){
		filterMountRetainingBracket();
	}
}
translate([filterInPosition,-34,92.5]){
	rotate([90,180,0]){
		522SP_filterMountTop();
	}
}
translate([filterInPosition,-34,47.5]){
	rotate([90,180,0]){
		522SP_filterMountBottom();
	}
}

//550LP_Filter
translate([filterInPosition,-10,70]){
	rotate([90,180,0]){
		filterMountRetainingBracket();
	}
}
translate([filterInPosition,2,70]){
	rotate([90,180,180]){
		filterMountRetainingBracket();
	}
}
translate([filterInPosition,-4,92.5]){
	rotate([90,180,0]){
		550LP_filterMountTop();
	}
}
translate([filterInPosition,-4,47.5]){
	rotate([90,180,0]){
		550LP_filterMountBottom();
	}
}


//Interference_Filter
translate([filterInStorage,20.5,70]){
	rotate([90,180,0]){
		filterMountRetainingBracket();
	}
}
translate([filterInStorage,47.5,70]){
	rotate([90,180,180]){
		filterMountRetainingBracket();
	}
}
translate([filterInStorage,34,92.5]){
	rotate([90,180,0]){
		interferenceFilterMountTop();
	}
}
translate([filterInStorage,34,47.5]){
	rotate([90,180,0]){
		interferenceFilterMountBottom();
	}
}


