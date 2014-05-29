use <electronic_lcdDisplay.scad>

module trim_lcdFacePlate_driveTray(){
	difference(){
		translate([0,0,-45]){
			color([0.2,0.8,0.2]) cube(size=[146.1,41.3,100],center=true);
		}
		translate([0,-6,-53]){
			color([0.2,0.2,0.2])cube(size=[140,48,110],center=true);
		}
		translate([0,20,-45]){
			color([0.2,0.2,0.2])cube(size=[100,28,70],center=true);
		}
		translate([-55,15,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([-55,-15,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([65,-15,1]){
			cylinder(r=1.5,h=25,center=true);
		}
	}
	translate([30,-10,9]){
		cube(size=[80,5,8],center=true);
	}
	translate([62,0,9]){
		cube(size=[5,20,8],center=true);
	}
	translate([-2,4,9]){
		cube(size=[5,30,8],center=true);
	}
	translate([-10,0,12]){
		cube(size=[3,40,15],center=true);
	}
}

rotate([90,180,0]){
//	trim_lcdFacePlate_facia();
	trim_lcdFacePlate_driveTray();
//	translate([30,6,20]){
//		lcdDisplay();
//	}
}