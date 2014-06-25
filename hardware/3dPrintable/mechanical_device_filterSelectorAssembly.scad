use <std_mechanical_object_flange3.scad>
use <mechanical_rackAndPinion.scad>
use <mechanical_object_pinion.scad>
use <rw_mechanical_object_stepperMotor.scad>

module main(){
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

//beamEntryPort
translate([0,-20,0]){
	rotate([0,0,90]){
		flangeFace();
	}
}
translate([0,27,0]){
	rotate([0,0,90]){
		flangeFace();
	}
}

difference(){
	translate([20,15,-17]){
		rotate([90,0,0]){
			color([.6,.7,.2]) pinion(4,60,4,5);
		}
	}
}
}

module box(){
	difference(){
		union(){
			translate([20,15,-25]){
				intersection(){
					cube(size=[85,25,100],center=true);
					rotate([90,0,0]){
						cylinder(r=52,h=30,,$fn=100,center=true);
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
		translate([20,14,-17]){
			rotate([90,0,0]){
				cylinder(r=42,h=10,center=true);
			}
		}
		translate([0,20,0]){
			rotate([90,0,0]){
				cylinder(r=10,h=50,center=true);
			}
		}
		union(){
			translate([39.25,29,-52]){
				rotate([90,0,0]){
					cylinder(r=15,h=21,center=true);
				}
			}
			translate([39.25,29,-52]){
				cube(size=[44,21,10],center=true);
			}
			translate([39.25,29,-40]){
				cube(size=[20,30,10],center=true);
			}
			translate([39.25,14,-60]){
				rotate([90,0,0]){
					cylinder(r=12,h=10,center=true);
				}
			}
		}
	}
}

translate([39.25,29,-52]){
	rotate([0,180,180]){
		mechanical_StepperMotor();
		translate([0,18,8]){
			rotate([90,0,0]){
				color([.6,.7,.2]) pinion(4,14,6.25,5);
			}
		}
	}
}

main();
%box();