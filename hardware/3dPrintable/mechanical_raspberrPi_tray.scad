use <raspiMount.scad>

module mainTray(){
	difference(){
	//tray
	color([0.4,0.8,0]) cube(size=[105,102,1.25],center=true);
	translate([-15,-10,0]){
		cube(size=[45,45,4],center=true);
	}
	translate([5,-45,0]){
		cube(size=[20,5,4],center=true);
	}
	}
	//walls
	translate([6.5,-52,5.5]){
		color([0.4,0.8,0]) cube(size=[73,2,10],center=true);
	}
	translate([6.5,52,5.5]){
		color([0.4,0.8,0]) cube(size=[73,2,10],center=true);
	}
	//wallSupports
	translate([30,-50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([30,50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([-20,-50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([-20,50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	//raspiMount
//	difference(){
		translate([0,-30,0]){
			color([0.9,0.2,0]) object1(1);
		}
		//attemptForEnhancedScrewHoles
//		translate([-42,-25.75,2]){
//			cylinder(r=1.5,h=7,$fn=8,center=true);
//		}
//		translate([13,.125,2]){
//			cylinder(r=1.5,h=7,$fn=8,center=true);
//		}
//	}
}

mainTray();