use <std_mechanical_object_flange3.scad>
use <std_mechanical_lib_rackAndPinion.scad>
use <mechanical_object_pinion.scad>
use <rw_mechanical_object_stepperMotor.scad>
use <rw_mechanical_object_608zBearing.scad>

module main(){
	union(){
	//beamEntryTube
	difference(){
			intersection(){
				cube(size=[30,17,20],center=true);
				rotate([90,0,0]){
					cylinder(r=15,h=18,center=true);
				}
			}
			//mainTubeInner
			intersection(){
				cube(size=[25,18,15],center=true);
				rotate([90,0,0]){
					cylinder(r=10,h=19,center=true);
				}
			}
	}
	//beamEntryPort
	translate([0,-20,0]){
		rotate([0,0,90]){
			flangeFace();
		}
	}
	}
	union(){
	//beamExitTube
	translate([0,30,0]){
		difference(){
			intersection(){
				cube(size=[30,17,20],center=true);
				rotate([90,0,0]){
					cylinder(r=15,h=18,center=true);
				}
			}
			//mainTubeInner
			intersection(){
				cube(size=[25,18,15],center=true);
				rotate([90,0,0]){
					cylinder(r=10,h=19,center=true);
				}
			}
		}
	}
	translate([0,27,0]){
		rotate([0,0,90]){
			flangeFace();
		}
	}
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

module box(){
	main();
	difference(){
		union(){
			translate([20,15,-25]){
				intersection(){
					cube(size=[86,26,102],center=true);
					rotate([90,0,0]){
						cylinder(r=53,h=30,,$fn=100,center=true);
					}
					translate([0,90,0]){
						sphere(r=110,$fn=100,center=true);
					}
					translate([0,-90,0]){
						sphere(r=110,$fn=100,center=true);
					}
				}
			}
		}
		//hubClearance
		translate([20,15,-17]) rotate ([90,0,0]) cylinder(r=11.5,h=25,center=true);
//		translate([20,15,-17]) rotate ([90,0,0]) cylinder(r=5,h=20,center=true);
		//mainPinionCutout
		translate([20,14,-17]){
			rotate([90,0,0]){
				color([0.2,0.6,0.9]) cylinder(r=42,h=10,center=true);
			}
		}
		//beamPathCutout
		translate([0,20,0]){
			rotate([90,0,0]){
				cylinder(r=10,h=50,center=true);
			}
		}
		union(){
			//stepperBodyCutout
			translate([39.25,29,-52]){
				rotate([90,0,0]){
					cylinder(r=15,h=21,center=true);
				}
			}
			//stepperMountTabCoutout
			translate([39.25,29,-52]){
				cube(size=[44,21,10],center=true);
			}
			//stepperBlueBoxCutout
			translate([39.25,29,-40]){
				cube(size=[20,30,10],center=true);
			}
			//pinionGearCutout
			translate([39.25,14,-60]){
				rotate([90,0,0]){
					color([0.2,0.6,0.9]) cylinder(r=12,h=10,center=true);
				}
			}
		}
		//opticalEncoderPinionCutout
		translate([0,14,-60]){
			rotate([90,0,0]){
				color([0.2,0.6,0.9]) cylinder(r=12,h=10,center=true);
			}
		}
		//opticalEncoderCutout
		translate([0,24,-60]){
			cube(size=[14.5,16.5,15.5],center=true);
		}		
		//screwHoles
		union(){
		translate([-16,18,-50]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([-16,24,-50]) rotate([90,0,0]) cylinder(r=3,h=7,center=true);
		}
		translate([56.5,18,-51.75]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);

		union(){
		translate([-18.5,18.5,6]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([-18.5,22,6]) rotate([90,0,0]) cylinder(r=3,h=5,center=true);
		}
		union(){
		translate([58.5,18,6]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
		translate([58.5,22,6]) rotate([90,0,0]) cylinder(r=3,h=5,center=true);
		}
	}
}


translate([39.25,29,-52]){
	rotate([0,180,180]){
		mechanical_StepperMotor();
		//stepperPinion
		translate([0,18,8]){
			rotate([90,0,0]){
				color([.6,.7,.2]) pinion(4,14,6.25,5);
			}
		}
	}
}
translate([0,18,-60]){
	//opticalEncoderPinion
		rotate([90,3,0]){
			color([.6,.7,.2]) pinion(4,14,6.25,5);
		}
	
}

translate([20,15,-17]){
	rotate([0,0,0]){
		filterWheel();
	}
}
translate([20,6.25,-17]) bearing();
translate([20,23.75,-17]) bearing();
//main();
difference(){
	box();
	//chopFront
	translate([20,0,-20]) cube(size=[100,30,120],center=true);
	//chopBack
//	translate([20,30,-20]) cube(size=[100,30,120],center=true);
}