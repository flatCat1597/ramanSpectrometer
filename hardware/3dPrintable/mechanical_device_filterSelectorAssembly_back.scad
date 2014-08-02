use <std_mechanical_object_flange3.scad>
use <std_mechanical_lib_rackAndPinion.scad>
use <mechanical_object_pinion.scad>
use <rw_mechanical_object_stepperMotor.scad>
use <rw_mechanical_object_608zBearing.scad>
use <std_trim_lib_write.scad>

module mainBox(){
	translate([0,0,0]){
		intersection(){
			cube(size=[86,26,102],center=true);
			rotate([90,0,0]){
				cylinder(r=53,h=30,,$fn=100,center=true);
			}
		}
	}
}

module outerCase(){
	intersection(){
		mainBox();
		intersection(){
			translate([0,90,0]) sphere(r=110,$fn=100,center=true);
			translate([0,-90,0]) sphere(r=110,$fn=100,center=true);
		}
	}
}

module flangeTube(){
	intersection(){
		cube(size=[30,47,20],center=true);
		rotate([90,0,0]) cylinder(r=15,h=48,center=true);
	}
	translate ([0,10,0]) rotate([0,0,90]) flangeFace();
	translate ([0,-34,0]) rotate([0,0,90]) flangeFace();
}

module centerCutouts(){
	union(){
		//stepperBodyCutout
		translate([19.25,15,-27]) rotate([90,0,0]) cylinder(r=15,h=21,center=true);
		//stepperMountTabCoutout
		translate([19.25,15,-27]) cube(size=[44,21,10],center=true);
		//stepperBlueBoxCutout 
		translate([19.25,15,-15]) cube(size=[20,30,10],center=true);
		//pinionGearCutout
		translate([19.25,0,-35]) rotate([90,0,0])	color([0.2,0.6,0.9]) cylinder(r=12,h=10,center=true);
	}
	//mainPinionCutout
	translate([0,0,8]) rotate([90,0,0]) color([0.2,0.6,0.9]) cylinder(r=42,h=10,center=true);
	//bearingMountCutout
	translate([0,0,8]) rotate ([90,0,0]) cylinder(r=11.5,h=25,center=true);
	//opticalEncoderPinionCutout
	translate([-19.25,0,-35]) rotate([90,0,0]) color([0.2,0.6,0.9]) cylinder(r=12,h=10,center=true);
	//opticalEncoderCutout
	translate([-19.25,10,-35]) cube(size=[14.5,16.5,15.5],center=true);		
}

module screwHoles(){
	//screwHoles
	union(){
		translate([-36,5,-27]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([-36,9,-27]) rotate([90,0,0]) cylinder(r=3,h=7,center=true);
	}
	translate([36.5,5,-27]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);

	union(){
		translate([-38.5,5.5,29]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([-38.5,9,29]) rotate([90,0,0]) cylinder(r=3,h=5,center=true);
	}
	union(){
		translate([38.5,5,29]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([38.5,9,29]) rotate([90,0,0]) cylinder(r=3,h=5,center=true);
	}
}





module filterWheel(){
	difference(){
		rotate([90,0,0]) color([.6,.7,.2]) pinion(4,60,4,10);
		//filterHoles
		translate([-20,-2,17]) rotate([90,0,0]) cylinder(r=8,h=5,center=true);
		translate([20,-2,-17]) rotate([90,0,0]) cylinder(r=8,h=5,center=true);
		translate([-20,-2,-17]) rotate([90,0,0]) cylinder(r=8,h=5,center=true);
	}
	union(){
		//centerHub
		rotate ([90,0,0]) cylinder(r=10,h=10,center=true);
		rotate ([90,0,0]) cylinder(r=3.75,h=24,$fn=50,center=true);
	}
}
module gearsAndMotor(){
	translate([19.25,14.75,-27]){
		rotate([0,180,180]){
			mechanical_StepperMotor();
		}
	}
	translate([19.25,-14,-43]){
		//stepperPinion
		translate([0,18,8]) rotate([90,0,0]) color([.6,.7,.2]) pinion(4,14,6.25,5);
	}
	translate([-19.25,-14,-43]){
		//stepperPinion
		translate([0,18,8]) rotate([90,0,0]) color([.6,.7,.2]) pinion(4,14,6.25,5);
	}
}
	
//translate([-10,-30,-10]) rotate([90,0,0]) color([0,1,0]) write("meridianScientific",h=6,t=3,center=true);	

difference(){
	union(){
		outerCase();
		translate([-20,0,25]) flangeTube();
	}
	centerCutouts();
	screwHoles();

	//mainTubeInner
	translate([-20,0,25]){
		intersection(){
			cube(size=[25,48,15],center=true);
			rotate([90,0,0]) cylinder(r=10,h=49,center=true);
		}
	}
	//chopFont
	translate([0,-15,0]) cube(size=[100,30,120],center=true);
}

//translate([0,0,8]) filterWheel();
//gearsAndMotor();
