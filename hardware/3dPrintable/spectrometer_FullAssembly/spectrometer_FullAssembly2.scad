use <../mechanical_rackAndPinion.scad>
use <../mechanical_stepperMotor.scad>
use <../mechanical_cuvetteHolderTray_half1.scad>
use <../mechanical_cuvetteHolderTray_half2.scad>
use <../mechanical_cuvetteTraySlideMotorBlock.scad>
use <../mechanical_cuvetteTrayMotorPinion.scad>
use <../electronic_photoInterrupter.scad>
use <../opticsMount_mirror_top.scad>
use <../opticsMount_mirrorAssembly_front.scad>
use <../opticsMount_mirrorAssembly_rear.scad>
use <../opticsMount_verticalAperture_top.scad>
use <../opticsMount_verticalAperture_bracket_025.scad>
use <../opticsMount_diffractionGrating_top.scad>
use <../opticsMount_standard_bottom.scad>
use <../opticsMount_retainingBracket.scad>
use <../opticsMount_beamSplitter_bottom.scad>
use <../opticsMount_beamSplitter_top.scad>
use <../opticsMount_objectiveLens_Bottom.scad>
use <../opticsMount_objectiveLens_Top.scad>
use <../filterMount_532nm_Pass_bottom.scad>
use <../filterMount_532nm_Pass_top.scad>
use <../filterMount_522SP_bottom.scad>
use <../filterMount_522SP_top.scad>
use <../filterMount_550LP_bottom.scad>
use <../filterMount_550LP_top.scad>
use <../filterMount_interference_bottom.scad>
use <../filterMount_interference_top.scad>
use <../filterMount_retainingBracket.scad>
use <../mechanical_slideStepperAssembly.scad>
use <../mechanical_slideStepperMotor.scad>

use <../mechanical_slideStepper_frame.scad>
use <../mechanical_slideStepper_mountingBracket_large.scad>
use <../mechanical_slideStepper_mountingBracket_small.scad>

module laserEmitter(){
	difference(){
		color([0.4,0.4,0.4]) cube(size=[96,40,40],center=true);	
		translate([-45,0,0]){
			rotate([0,90,0]) cylinder(r=11.75,h=10,$fn=20,center=true);
		}
	}
}
module laserEmitter_powerSupply(){
//	color([0.4,0.4,0.4]) cube(size=[102.5,47,47.5],center=true);	
	color([0.4,0.4,0.4]) cube(size=[47.5,47,102.5],center=true);	
	translate([24,-4,0]){
//		color([0.4,0.4,0.4]) cube(size=[102.5,67,1],center=true);		
		color([0.4,0.4,0.4]) cube(size=[1,67,102.5],center=true);		
	}
}
module laserBeam(length){
	rotate([0,90,0]) color([0,1,0]) cylinder(h=length,r=.5,$fn=50,center=true);	
}
module container(){
	%translate([0,0,0]) color([0.9,0.9,0.7]) cube(size=[280,230,2],center=true);
}
module containerWalls(){
	translate([0,0,59]){
		difference(){
			color([0.7,0.1,0.7]) cube(size=[280,230,117],center=true);
			color([0.7,0.7,0.7]) cube(size=[278,228,120],center=true);
			translate([-140,-85,7]) color([0.9,0.9,0.8]) cube(size=[5,50,80],center=true);
		}
	}
}
module opticsShelf(){
	translate([27.5,-85,49]) color([0,0.7,0.7]) cube(size=[225,60,2],center=true);
}


module door(){
	//door
	translate([-125,0,25]) color([0.9,0.9,0.8]) cube(size=[5,48,78],center=true);
	translate([-110,-22,0]) color([0.9,0.9,0.8]) cube(size=[30,2,28],center=true);
	translate([-110,22,0]) color([0.9,0.9,0.8]) cube(size=[30,2,28],center=true);
	translate([-120,0,-6]) rotate([90,0,0]) cylinder(r=2,h=48,$fn=50,center=true);
}




//stepperAssembly
translate([14,0,2]){
	mechanical_slideStepper_frame();
}
translate([-16,0,0]){
	mechanical_slideStepper_slides();
}
translate([filterInPosition,-34,-38]){
	mechanical_slideStepper_mountingBracket_small();
}
translate([filterInStorage,-4,-38]){
	mechanical_slideStepper_mountingBracket_small();
}
translate([filterInStorage,34,-38]){
	mechanical_slideStepper_mountingBracket_large();
}

translate([0,0,2]){
	mechanical_lensCassette();
}

//steppers
translate([70,-34,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
}
translate([70,-4,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
}
translate([70,34,12]){
	rotate([0,0,180]){
		slideStepper(64);
	}
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


translate([-73,-105,31.5]){
	 rotate([0,90,0]){
	 	photoInterrupter();
	}
}

translate([90,-85,70]){
	laserEmitter();
}
translate([110,85,52]){
	laserEmitter_powerSupply();
}
translate([-35,-85,38]){
	cuvetteTraySlideMotorBlock();
}
translate([-35,-82,27]){
	mechanical_cuvetteTrayMotorPinion();
}
translate([-25,-85,41]){
	cuvetteHolderTray_half1();
	cuvetteHolderTray_half2();
	door();
}
translate([0,0,0]){
	container();
}
translate([0,0,0]){
	opticsShelf();
}
translate([0,0,0]){
//	containerWalls();
}


//									MIRROR #1
translate([-10.5,85,70]){
	rotate([0,0,45]){
		mirrorAssembly_front();
	}
}
translate([-10.5,85,50]){
	rotate([0,0,45]){
		opticsMount_mirror_top();
	}
}
translate([-10.5,85,2]){
	opticsMount_standard_base();
}
translate([-3.5,92,70]){
	rotate([0,0,225]){
		mirrorAssembly_rear();
	}
}


//  									VERTICAL APERTURE
translate([-57,85,70]){
	rotate([0,0,180]){
		retainingBracket();
	}
}
translate([-61,85,50]){
	rotate([0,0,180]){
		opticsMount_verticalAperture_top();
	}
	translate([-3,0,20]){
		rotate([0,0,0]){
			retainingBracket();
			aperture();
		}
	}	
}
translate([-61,85,2]){
	opticsMount_standard_base();
}

translate([-109,82,70]){
	rotate([0,0,115]){
		retainingBracket();
	}
}
translate([-111,85,50]){
	rotate([0,0,115]){
		opticsMount_diffractionGrating_top();
	}
}
translate([-111,85,2]){
	opticsMount_standard_base();
}

translate([-35,-70,19]){    //70 was 74
	rotate([0,0,180]){
		mechanical_StepperMotor();
	}
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

filterInPosition = -10;
filterInStorage = 50;

//									532nm_Pass
translate([28,-85,70]){
	532nmPassFilterBottom();
}
translate([28,-85,70]){
	532nmPassFilterTop();
}

//									beamSplitter
translate([-10,-85,60]){
	rotate([0,0,270]){
		beamSplitterMountBottom();
	}
}
translate([-10,-85,75]){
	rotate([0,0,270]){
		beamSplitterMountTop();
	}
}

//									objectiveLens
translate([-62,-85,60]){
	objectiveLensMountBottom();
}
translate([-62,-85,76]){
	objectiveLensMountTop();
}

//									522SP_Filter
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

//									550LP_Filter
translate([filterInStorage,-10,70]){
	rotate([90,180,0]){
		filterMountRetainingBracket();
	}
}
translate([filterInStorage,2,70]){
	rotate([90,180,180]){
		filterMountRetainingBracket();
	}
}
translate([filterInStorage,-4,92.5]){
	rotate([90,180,0]){
		550LP_filterMountTop();
	}
}
translate([filterInStorage,-4,47.5]){
	rotate([90,180,0]){
		550LP_filterMountBottom();
	}
}

//									Interference_Filter
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
