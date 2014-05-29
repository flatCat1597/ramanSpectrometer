/*
use <filterMount_interference_bottom.scad>
use <filterMount_interference_top.scad>
use <filterMount_retainingBracket.scad>
use <mechanical_slideStepper_mountingBracket_large.scad>
filterInPosition = -10;
filterInStorage = 50;

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
translate([filterInStorage,34,-38]){
	mechanical_slideStepper_mountingBracket_large();
}
*/

module mechanical_slideStepper_frame(){
	difference(){
		translate([7.25,0,0]) {
			color([0.4,0.4,0.4]) cube(size=[190.5,110,2],center=true);
		}
		//motorWells
		translate([87,-34,1]){
			cube(size=[11,15,3],center=true);
		}
		translate([87,34,1]){
			cube(size=[11,15,3],center=true);
		}
		translate([87,-4,1]){
			cube(size=[11,15,3],center=true);
		}
		//screwHoles
		translate([97,34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([97,-34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([97,-4,0]){
			cylinder(r=2,h=10,center=true);
		}

		translate([-78,34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([-78,-34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([-78,-4,0]){
			cylinder(r=2,h=10,center=true);
		}

		translate([-35,34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([-35,-34,0]){
			cylinder(r=2,h=10,center=true);
		}
		translate([-35,-4,0]){
			cylinder(r=2,h=10,center=true);
		}
	}
	//centerTrackPads
	translate([34,-4,2])color([0.4,0.4,0.5]) cube(size=[95,27,5],center=true);	
	translate([34,-34,2])color([0.4,0.4,0.5]) cube(size=[95,27,5],center=true);	
	translate([34,34,2])color([0.4,0.4,0.5]) cube(size=[95,37,5],center=true);	
	//photoSensorMounts
	difference(){
		translate([-40,-34,6]) color([0.7,0.8,0.3]) cube(size=[60,10,11],center=true);
		//#1sensorCutout
		translate([-65,-34,10]) cube(size=[5,7,6],center=true);
		//#1sensorThrough
		translate([-65,-34,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//#2sensorCutout
		translate([-15,-34,10]) cube(size=[5,7,6],center=true);
		//#2sensorThrough
		translate([-15,-34,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//sensorWireThrough
		translate([-40,-34,8]) rotate([0,90,0])  cylinder(r=2,h=52,center=true);
	}
	difference(){
		translate([-40,34,6]) color([0.7,0.8,0.3]) cube(size=[60,10,11],center=true);
		//#1sensorCutout
		translate([-65,34,10]) cube(size=[5,7,6],center=true);
		//#1sensorThrough
		translate([-65,34,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//#2sensorCutout
		translate([-15,34,10]) cube(size=[5,7,6],center=true);
		//#2sensorThrough
		translate([-15,34,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//sensorWireThrough
		translate([-40,34,8]) rotate([0,90,0])  cylinder(r=2,h=52,center=true);
	}
	difference(){
		translate([-40,-4,6]) color([0.7,0.8,0.3]) cube(size=[60,10,11],center=true);
		//#1sensorCutout
		translate([-65,-4,10]) cube(size=[5,7,6],center=true);
		//#1sensorThrough
		translate([-65,-4,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//#2sensorCutout
		translate([-15,-4,10]) cube(size=[5,7,6],center=true);
		//#2sensorThrough
		translate([-15,-4,8]) rotate([90,0,0])  cylinder(r=2,h=12,center=true);
		//sensorWireThrough
		translate([-40,-4,8]) rotate([0,90,0])  cylinder(r=2,h=52,center=true);
	}
}
module mechanical_slideStepper_slides(){
	translate([20,0,12]){
		difference(){
			//mainBody
			translate([7,0,0]){
				color([0.5,0.5,0.5]) cube(size=[170,110,20],center=true);	
			}
			//mainHoles
			translate([23,-34,0]) cube(size=[166,25.5,22],center=true);
			translate([23,-4,0]) cube(size=[166,25.5,22],center=true);
			translate([23,34,0]) cube(size=[166,30.5,22],center=true);
			//slides
			translate([23,-34,0]) cube(size=[166,28.5,3.25],center=true);			
			translate([23,-4,0]) cube(size=[166,28.5,3.25],center=true);
			translate([23,34,0]) cube(size=[166,34.5,3.25],center=true);

			//bigScrewHoles
			translate([-68,34,5]){
				cylinder(r=3,h=40,center=true);
			}
			translate([-68,-34,5]){
				cylinder(r=3,h=40,center=true);
			}
			translate([-68,-4,5]){
				cylinder(r=3,h=40,center=true);
			}
			translate([-68,-41,-2]) rotate([0,90,0])  cylinder(r=4,h=22,center=true);
			translate([-68,27,-2]) rotate([0,90,0])  cylinder(r=4,h=22,center=true);
			translate([-68,-11,-2]) rotate([0,90,0])  cylinder(r=4,h=22,center=true);
		}
	}
}

module mechanical_lensCassette(){
	translate([14,0,2]){
		mechanical_slideStepper_frame();
	}
	translate([-16,0,0]){
		mechanical_slideStepper_slides();
	}
}
mechanical_lensCassette();
