use <rw_mechanical_object_9gServo.scad>
use <std_mechanical_object_flange3.scad>

module passFilter(){
	translate ([0,0,0]) rotate([0,90,0]) color([0,.5,0]) cylinder(r=14,h=6,$fn=100,center=true);
}

module mainFrame(){
	union(){
		difference(){
			intersection(){
				//mainSpehere
				translate([0,0,0]) sphere(r=20,center=true);
				//sqaureCutouts
				cube(size=[30,30,25],center=true);
			}
			//servoNeck
			translate([7.5,10,3]) cube(size=[6,15,9],center=true);
			//crossChannels
			union(){
				intersection(){
					rotate([0,90,0]) cylinder(r=9,h=32,center=true);
					cube(size=[32,15,15],center=true);
				}
				intersection(){
					rotate([90,0,0]) cylinder(r=9,h=32,center=true);
					cube(size=[15,32,15],center=true);
				}
			}
			//insetRoundedSquare
			intersection(){
				translate([0,0,12]) cube(size=[15,15,2],center=true);
				translate([0,0,12]) cylinder(r=9,h=3,center=true);
			}
			//insetRoundedSquare
			intersection(){
				translate([0,0,-12]) cube(size=[15,15,2],center=true);
				translate([0,0,-12]) cylinder(r=9,h=3,center=true);
			}
			//deflectionIndicator1
			translate([0,0,10]) cylinder(r=5,h=10,center=true);
			//deflectionIndicator2
			translate([0,0,-10]) cylinder(r=5,h=10,center=true);
		}
		//servoMounts
		difference(){
			translate([-14.5,15,0]) cube(size=[5.5,8,12],center=true);
			translate([-14.5,17.5,0]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		}
		difference(){
			translate([14.5,15,0]) cube(size=[5.5,8,12],center=true);
			translate([14.5,17.5,0]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		}
		//block
		translate([0,-13,0]) cube(size=[15,1,15],center=true);
	}
}

//translate([0,0,20]) cube(size=[48,1,1],center=true);

module laserShutter_Module(){
	union(){
		mainFrame();
		translate([10,0,0]){
			difference(){
				flange();
				//servoNeck
				translate([0,10,3]) cube(size=[6,15,9],center=true);
			}
		}
		translate([-10,0,0]){
			rotate([0,180,0]) flange();
		}
	}
	
}

//translate([0,25,0]) rotate([90,0,0]) 9g_motor();

module laserShutter_Top(){
	difference(){
		laserShutter_Module();
//		translate([-6.5,0,0]){
//			passFilter();
//		}
		//bottomChop
		translate([0,0,-25]) cube(size=[50,50,50],center=true);
		//screwHoles
		translate([-11,-11,2]) cylinder(r=1.75,h=10,center=true);
		translate([11,-11,2]) cylinder(r=1.75,h=10,center=true);
		translate([12,11,2]) cylinder(r=1.75,h=10,center=true);
		translate([-11,11,2]) cylinder(r=1.75,h=10,center=true);

		translate([-11,-11,10]) cylinder(r=2.5,h=7,center=true);
		translate([11,-11,10]) cylinder(r=2.5,h=7,center=true);
		translate([12,11,10]) cylinder(r=2.5,h=7,center=true);
		translate([-11,11,10]) cylinder(r=2.5,h=7,center=true);
	}
}
laserShutter_Top();