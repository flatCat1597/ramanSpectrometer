use <rw_electronic_object_tftDisplay.scad>
use <rw_mechanical_object_stepperMotor.scad>
use <trim_tftFaceplate_facia.scad>
use <optics_module_beamSplitter_top.scad>
use <std_mechanical_object_flange3.scad>
use <mechanical_object_pinion.scad>
use <std_mechanical_lib_rackAndPinion.scad>

module mainBox(){
	difference(){
		//mainBox
			color([0.2,0.8,0.2]) cube(size=[41.3,170,146.1,],center=true);
		//hollowBox
		translate([6,0,0]){
			color([0.2,0.2,0.2])cube(size=[49,166,142],center=true);
		}
		//frontDoorHole
		translate([0,-85,-30]) cube(size=[30,7,70],center=true);
		//flangeHoles
		translate([-20,52.5,-20]) cube(size=[5,10,35],center=true);
		translate([0,82,-30]) cube(size=[30,10,50],center=true);
		//objectiveMountScrewBodyHole
		translate([-20,-39,-22]) cube(size=[5,10,18],center=true);
	}
	//back
	translate([-50,-86,50]){
		color([0.2,0.8,0.2]) cube(size=[147,2,50],center=true);
	}
	//top
	translate([-50,-90.75,77.25]){
		rotate([57,0,0]) color([0.2,0.8,0.2]) cube(size=[147,2,13],center=true);
	}
	//bottom
	translate([-50,-124.5,43.5]){
		rotate([32,0,0]) color([0.2,0.8,0.2]) cube(size=[147,2,13],center=true);
	}
	//left
	translate([-122.5,-107.75,60.55]) {
		rotate([-45,0,0]) color([0.2,0.8,0.2]) cube(size=[2,12,47],center=true);
	}
	//right
	translate([22.5,-107.75,60.55]) {
		rotate([-45,0,0]) color([0.2,0.8,0.2]) cube(size=[2,12,47],center=true);
	}
	//trayGuide	
	color([0.5,0.25,0.75]){
	translate([0,-4,-68]){
		cube(size=[30,130,6],center=true);
	}
	translate([0,-4,-62.75]){
		cube(size=[2,130,5],center=true);
	}
	translate([0,-4,-60]){
		cube(size=[5,130,2],center=true);
	}
	}
	difference(){
		translate([17.5,-10,-60]){
			cube(size=[5,45,25],center=true);
		}
		translate([17.5,-10,-51]){
			rotate([0,90,0]){
				cylinder(r=14.25,h=12,center=true);
			}
		}
		translate([15,-10,-50]){
			cube(size=[3,42.5,9.5],center=true);
		}
		translate([15,-27,-51]){
			rotate([0,90,0]){
				cylinder(r=1.5,h=12,center=true);
			}
		}
		translate([15,7,-51]){
			rotate([0,90,0]){
				cylinder(r=1.5,h=12,center=true);
			}
		}
		translate([20,-10,-65]){
			cube(size=[11,18,4],center=true);
		}
	}
	//wallMounts
	translate([-15,23,-9]){
		wallMount();
	}
	translate([-15,-27,-5]){
		wallMount();
	}
	translate([-15,23,-35]){
		rotate([180,0,0]) wallMount();
	}
	translate([-15,-27,-39]){
		rotate([180,0,0]) wallMount();
	}
}

module wallMount(){
	difference(){
		rotate([0,90,180]) screwHoleOuter();
		rotate([0,90,180]) screwHoleInner2();
		translate([4,0,-4]){
			cube(size=[10,10,3],center=true);
		}
		translate([-7,0,0]){
			cube(size=[5,10,10],center=true);
		}
	}
}

module objectiveMount(){	
	difference(){
		//mainBody
		intersection(){
			translate([0,3,0]) color([0,.6,.5]) cube(size=[30,30,25],center=true);
			translate([0,3,0]) rotate([90,0,0]) cylinder(r=18,h=35,center=true);
		}
		//lensHole
		translate([0,9,0]) rotate([90,0,0]) cylinder(h=13,r=12,center=true);
		translate([0,-6,0]) rotate([90,0,0]) cylinder(h=18,r=10,center=true);
		intersection(){
			translate([0,14,0]) cube(size=[20,10,15],center=true);
			translate([0,15,0]) rotate([90,0,0]) cylinder(r=10,h=10,center=true);
		}
		translate([-15,-4,0]) screwHoleInner();
		translate([15,-4,0]) screwHoleInner();
	}
	color([0.6,0.84,0.64]){
	union(){
		intersection(){
			difference(){
				translate([0,48,0]) cube(size=[30,60,20],center=true);
				intersection(){
					translate([0,48,0]) cube(size=[28,61,10],center=true);
					translate([0,48,0]) rotate([90,0,0]) cylinder(r=7,h=62,center=true);
				}
			translate([0,48,0]) rotate([0,0,0]) cube(size=[27.5,40,14],center=true);
		//mainScrewHoles
		translate([-12,70,0]) screwHoleInner();
		translate([12,70,0]) screwHoleInner();
		translate([-12,25,0]) screwHoleInner();
		translate([12,25,0]) screwHoleInner();
			}
			translate([0,48,0]) rotate([90,0,0]) cylinder(r=15,h=62,center=true);
		}
		translate([0,73.5,0]){
			rotate([0,0,90]){
				flange();
			}
		}
}	}
	//mainScrewHoles
	difference(){
		translate([-12,70,0])  screwHoleOuter();
		translate([-12,70,0])  screwHoleInner();
	}
	difference(){
		translate([12,70,0]) screwHoleOuter();
		translate([12,70,0]) screwHoleInner();
	}
	difference(){
		translate([-12,25,0]) screwHoleOuter();
		translate([-12,25,0]) screwHoleInner();
	}
	difference(){
		translate([12,25,0]) screwHoleOuter();
		translate([12,25,0]) screwHoleInner();
	}

	difference(){
		translate([-15,-4,0]) screwHoleOuter();
		translate([-15,-4,0]) screwHoleInner();
	}
	difference(){
		translate([15,-4,0]) screwHoleOuter();
		translate([15,-4,0]) screwHoleInner();
	}
	//sideScrewHoles
	rotate([0,90,0]){
	difference(){
		translate([-17,8,0]) screwHoleOuter();
		translate([-17,8,0]) screwHoleInner2();
	}
	difference(){
		translate([17,8,0]) screwHoleOuter();
		translate([17.5,8,0]) screwHoleInner2();
	}
	difference(){
		translate([-13,58,0]) screwHoleOuter();
		translate([-13,58,0]) screwHoleInner2();
	}
	difference(){
		translate([13,58,0]) screwHoleOuter();
		translate([13,58,0]) screwHoleInner2();
	}
	}
	color([0,0.7,0.4]){
	translate([0,8,13]){
		intersection(){
			cube(size=[15,15,2],center=true);
			translate([0,0,-12.5]){
				sphere(r=15,center=true);
			}
		}
	}
	translate([0,8,-13]){
		intersection(){
			cube(size=[15,15,2],center=true);
			translate([0,0,12.5]){
				sphere(r=15,center=true);
			}
		}
	}
	}

}

module screwHoleOuter(){
		cylinder(r=5,h=15,center=true);
}

module screwHoleInner(){
		translate([0,0,5]) cylinder(r=1.5,h=15,center=true);
		translate([0,0,11]) cylinder(r=3,h=15,center=true);
}
module screwHoleInner2(){
		translate([0,0,5]) cylinder(r=1.5,h=35,center=true);
		translate([0,0,11]) cylinder(r=3,h=15,center=true);
}

translate([0,-35,-22]){
		objectiveMount();
}

module tray(){
	//mainTray
	color([0.2,0.8,0.9]) cube(size=[28,150,2],center=true);
	//cuvetteHolder
	difference(){
		intersection(){
			translate([0,-60,11]) cube(size=[25,25,20],center=true);
			translate([0,-60,11]) sphere(r=15,center=true);
		}
		translate([0,-60,15]) cube(size=[14,14,25],center=true);
	}
	intersection(){
		translate([0,-55,5]) cube(size=[28,35,10],center=true);
		translate([0,-55,11]) sphere(r=20,center=true);
	}
	//rackGear
	translate([7.5,15,3.5]){
		rotate([90,180,90]){
				rack(4,30,6.25,2);
		}
	}
	//rackSupport
	color([1,0.4,0]){
	translate([10.65,17.5,2]){
		cube(size=[6.25,115,3],center=true);
	}
	//opticalSensorBlock
	translate([-10,40,6]){
		cube(size=[2,10,12],center=true);
	}
	}
}
module traySupports(){
	color([1,0.4,0]){
	translate([-3.75,-5,-3]){
		cube(size=[2,130,4],center=true);
	}
	translate([3.75,-5,-3]){
		cube(size=[2,130,4],center=true);
	}
	translate([3,-5,-4.25]){
		cube(size=[3.5,130,2],center=true);
	}
	translate([-3,-5,-4.25]){
		cube(size=[3.5,130,2],center=true);
	}

	translate([-12,-5,-3]){
		cube(size=[2,130,7.5],center=true);
	}
	translate([12,-5,-3]){
		cube(size=[2,130,7.5],center=true);
	}
	translate([-8,-5,-2]){
		cube(size=[7,130,5],center=true);
	}
	translate([8,-5,-2]){
		cube(size=[7,130,5],center=true);
	}
	}
}

//cuvetteTrayMovement
translate([0,-70,-58]){
	tray();
	traySupports();
	//cuvette
	%translate([0,-60,35]) cube(size=[12,12,45],center=true);
}

module stepperMotorPinion(){
	translate([25,-10,-51]){
		rotate([0,0,90]){
			mechanical_StepperMotor();
			translate([0,17.5,8]){
				rotate([0,14.5,0]){
					mechanical_cuvetteTrayMotorPinion();
				}
			}
		}
	}
}
stepperMotorPinion();

module 6x12x4Bearing(){
		rotate([0,90,0]){
			difference(){
				cylinder(r=6,h=4,$fn=25,center=true);
				cylinder(r=3,h=5,$fn=25,center=true);
			}
		}
}

module displayPlate(){
	difference(){
		//mainBox
		translate([0,0,4]){
			color([0.2,0.8,0.2]) cube(size=[147,50,2],center=true);
		}
		//screwHoles
		translate([-65,12,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([-65,-12,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([65,-10,1]){
			cylinder(r=1.5,h=25,center=true);
		}
		translate([65,10,1]){
			cylinder(r=1.5,h=25,center=true);
		}
		//connectorHole
		translate([-6.5,0,-0]){
			cube(size=[5,30,15],center=true);
		}

		//lightBoxes-throughHoles (I'm sure this can be done with a for loop)
		//lightBoxes-okButton
		translate([-36,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,5]){
			cube(size=[5,5,12],center=true);
		}
	}

	//tftSupports
	translate([25,-17.5,9]){
		cube(size=[70,5,8],center=true);
	}
	translate([57,10,9]){
		cube(size=[5,20,8],center=true);
	}
	translate([-2,4,9]){
		cube(size=[5,30,8],center=true);
	}
	translate([-10,0,9]){
		cube(size=[3,40,9],center=true);
	}
	difference(){
		//lightBoxes-mainCube
		translate([-36,0,11]){
			color([0.6,1,0]) cube(size=[45,35,14],center=true);
		}
		//lightBoxes-okButton
		translate([-36,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
	}
}

/*
difference(){
	translate([-110,91,0]) color([0.25,0.25,0.25]) cube(size=[310,350,250],center=true);
	translate([-110,91,2]) color([0.25,0.25,0.25]) cube(size=[308,348,248],center=true);
}
*/

translate([0,95,-22]){
	rotate([0,0,180]){
		beamSplitterTop();
	}
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

mainBox();