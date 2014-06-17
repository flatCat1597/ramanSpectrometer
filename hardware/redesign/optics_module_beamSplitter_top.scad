use <std_mechanical_object_flange3.scad>

module bodyTubes(){
	union(){
		difference(){
			//mainTubeOuter
			intersection(){
				cube(size=[30,77,20],center=true);
				rotate([90,0,0]){
					cylinder(r=15,h=78,center=true);
				}
			}
			//mainTubeInner
			intersection(){
				cube(size=[25,78,15],center=true);
				rotate([90,0,0]){
					cylinder(r=10,h=79,center=true);
				}
			}
			//crossWallCutout
				translate([0,-15,0]) cube(size=[45,25,15],center=true);
		}
	}
	union(){
		difference(){
			//crossTubeOuter
			intersection(){
				translate([-4.5,-15,0]) cube(size=[51,30,20],center=true);
				translate([-4.5,-15,0]) rotate([0,90,0]) cylinder(r=15,h=52,center=true);
			}
			//crossTubeInner
			intersection(){
				translate([-4.5,-15,0]) cube(size=[52,25,15],center=true);
				translate([-4.5,-15,0]) rotate([0,90,0]) cylinder(r=11,h=53,center=true);
			}
			//mainWallCutout
				cube(size=[25,70,15],center=true);
		}
	}
}

module centralHub(){
	difference(){
		intersection(){
			translate([0,-15,0]) sphere(r=22,center=true);
			translate([0,-15,0]) cube(size=[30,30,30],center=true);
		}
		translate([0,-15,17]) cube(size=[32,32,10],center=true);
		translate([0,-15,-17]) cube(size=[32,32,10],center=true);
		union(){
			translate([0,-15,0]) cube(size=[32,20,20],center=true);
			translate([0,-15,0]) cube(size=[20,32,20],center=true);
		}
		//bottomCutout
		translate([0,-15,-11.5]) cylinder(r=10,h=2,center=true);
	}
	//objectiveFlange
	rotate([0,0,90]){
		translate([28.5,0,0]){
			flangeFace();
		}
	}
	//mirrorFlange
	rotate([0,0,270]){
		translate([28.5,0,0]){
			flangeFace();
		}
	}
	//beamStopFlange
	rotate([0,0,0]){
		translate([11,-15,0]){
			flangeFace();
		}
	}
	//lensSelectorFlange
	rotate([0,0,180]){
		translate([20,15,0]){
			flangeFace();
		}
	}
}

//translate([20,0,0]) color([1,0,0]) cube(size=[1,85,1],center=true);

module bodyUnit(){
	difference(){
		union(){
			bodyTubes();
			centralHub();
		}
		//accessHole
		translate([0,-15,10]) cylinder(r=12,h=10,center=true);
		//accessHoleScrewHoles
		translate([10.5,-4.5,10]) cylinder(r=2,h=10,center=true);
		translate([-10.5,-4.5,10]) cylinder(r=2,h=10,center=true);
		translate([10.5,-25.5,10]) cylinder(r=2,h=10,center=true);
		translate([-10.5,-25.5,10]) cylinder(r=2,h=10,center=true);
		//mainScrewHoles
		translate([-12,30,0]) screwHoleInner();
		translate([12,30,0]) screwHoleInner();
		translate([-12,-35,0]) screwHoleInner();
		translate([12,-35,0]) screwHoleInner();
		translate([-15,-0,0]) screwHoleInner();
	}
	//mainScrewHoles
	difference(){
		translate([-12,30,0])  screwHoleOuter();
		translate([-12,30,0])  screwHoleInner();
	}
	difference(){
		translate([12,30,0]) screwHoleOuter();
		translate([12,30,0]) screwHoleInner();
	}
	difference(){
		translate([-12,-35,0]) screwHoleOuter();
		translate([-12,-35,0]) screwHoleInner();
	}
	difference(){
		translate([12,-35,0]) screwHoleOuter();
		translate([12,-35,0]) screwHoleInner();
	}
	difference(){
		translate([-15,-0,0]) screwHoleOuter();
		translate([-15,-0,0]) screwHoleInner();
	}
}

module screwHoleOuter(){
		cylinder(r=5,h=15,center=true);
}

module screwHoleInner(){
		translate([0,0,5]) cylinder(r=1.5,h=15,center=true);
		translate([0,0,11]) cylinder(r=3,h=15,center=true);
}

module beamSplitterTop(){
	difference(){
		bodyUnit();
		//chopBottom
//		translate([0,0,-10]) cube([100,100,20],center=true);
	}
}

beamSplitterTop();