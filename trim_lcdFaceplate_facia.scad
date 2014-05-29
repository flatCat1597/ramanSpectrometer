use <electronic_lcdDisplay.scad>

module trim_lcdFacePlate_facia(){
	difference(){
		translate([0,6,20]){
			color([0.2,0.8,0.2]) cube(size=[150,60,2],center=true);
		}
		translate([30,6,20]){
			cube(size=[77,46,5],center=true);
		}
	}
	translate([70,0,12]){
		cube(size=[3,40,15],center=true);
	}
	difference(){
		translate([-55,15,12]){
			cylinder(r=5,h=14,center=true);
		}
		translate([-55,15,10]){
			cylinder(r=1.5,h=22,center=true);
		}
	}
	difference(){
		translate([-55,-15,12]){
			cylinder(r=5,h=14,center=true);
		}
		translate([-55,-15,10]){
			cylinder(r=1.5,h=22,center=true);
		}
	}
	//topLCDspacingTab
	translate([31,-19,17]){
		cube(size=[50,3,4],center=true);
	}
	//bottomCornerLCDspacingTabs
	translate([65,31,17]){
		cube(size=[10,3,4],center=true);
	}
	translate([-5,31,17]){
		cube(size=[10,3,4],center=true);
	}

	//topAngle
	difference(){
		rotate([0,90,0]){
			translate([-11,-24,0]){
				color([0.2,0.8,0.2]) cylinder(r=10,h=150,$fn=4,center=true);
			}
		}
		rotate([0,90,0]){
			translate([-7,-22,0]){
				color([0.2,0.8,0.9]) cylinder(r=13,h=155,$fn=4,center=true);
			}
		}
	}
	//bottomAngle
	difference(){
		rotate([0,90,0]){
			translate([-11,36,0]){
				color([0.2,0.8,0.2]) cylinder(r=10,h=150,$fn=4,center=true);
			}
		}
		rotate([0,90,0]){
			translate([-7,34,0]){
				color([0.2,0.8,0.9]) cylinder(r=13,h=155,$fn=4,center=true);
			}
		}
	}
		difference(){
		translate([65,-15,9]){
			cylinder(r=5,h=8,center=true);
		}
		translate([65,-15,10]){
			cylinder(r=1.5,h=20,center=true);
		}
	}

	//leftSideAngle
	difference(){
		rotate([90,90,0]){
			translate([-11,75,-6]){
				color([0.2,0.8,0.2]) cylinder(r=10,h=60,$fn=4,center=true);
			}
		}
		rotate([90,90,0]){
			translate([-9,72,-5]){
				color([0.2,0.8,0.9]) cylinder(r=13,h=65,$fn=4,center=true);
			}
		}
	}
	//rightSideAngle
	difference(){
		rotate([90,90,0]){
			translate([-11,-75,-6]){
				color([0.2,0.8,0.2]) cylinder(r=10,h=60,$fn=4,center=true);
			}
		}
		rotate([90,90,0]){
			translate([-9,-72,-5]){
				color([0.2,0.8,0.9]) cylinder(r=13,h=65,$fn=4,center=true);
			}
		}
	}
	//cornerCubes
	translate([78,38.5,14]){
		cube([10,10,10],center=true);
	}
	translate([78,-27.5,14]){
		cube([10,10,10],center=true);
	}

	translate([-78,38.5,14]){
		cube([10,10,10],center=true);
	}
	translate([-78,-27.5,14]){
		cube([10,10,10],center=true);
	}
}

rotate([90,180,0]){
	trim_lcdFacePlate_facia();
//	trim_lcdFacePlate_driveTray();
//	translate([30,6,20]){
//		lcdDisplay();
//	}
}