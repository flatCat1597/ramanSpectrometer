module mechanical_slideStepper_mountingBracket_small(){
	difference(){
		//movedMainBlockHigherAndTallerToAccommodateScrewHoleHeightAdjustments
//		translate([0,0,70]){
		translate([0,0,70.5]){
//			color([1,1,0]) cube(size=[90,29,20],center=true);
			color([1,1,0]) cube(size=[90,29,21],center=true);
		}
		translate([0,0,73]){
			color([1,1,0]) cube(size=[95,20,20],center=true);
		}
		//mountingScrewHoles
//		translate([35,-9.5,73.5]){
		translate([35,-9.5,74]){
			rotate([90,0,0]){
				cylinder(r=4.5,h=25,center=true);
			}
		}
//		translate([35,9,73.5]){
		translate([35,9,74]){
			rotate([90,0,0]){
				cylinder(r=4.5,h=25,center=true);
			}
		}
//		translate([-35,-9,73.5]){
		translate([-35,-9,74]){
			rotate([90,0,0]){
				cylinder(r=4.5,h=25,center=true);
			}
		}
//		translate([-35,9,73.5]){
		translate([-35,9,74]){
			rotate([90,0,0]){
				cylinder(r=4.5,h=25,center=true);
			}
		}
	}
	//cornerPads
	difference(){
		translate([35.5,-9.25,72]){
			color([1,1,0]) cube(size=[19,3,21],center=true);
		}	
		translate([35,-9.5,73.5]){
			rotate([90,0,0]){
				cylinder(r=2.5,h=25,center=true);
			}
		}
	}
	difference(){
		translate([35.5,9.25,72]){
			color([1,1,0]) cube(size=[19,3,21],center=true);
		}	
		translate([35,9,73.5]){
			rotate([90,0,0]){
				cylinder(r=2.5,h=25,center=true);
			}
		}
	}

	difference(){
		translate([-35.5,-9.25,72]){
			color([1,1,0]) cube(size=[19,3,21],center=true);
		}	
		translate([-35,-9,73.5]){
			rotate([90,0,0]){
				cylinder(r=2.5,h=25,center=true);
			}
		}
	}
	difference(){
		translate([-35.5,9.25,72]){
			color([1,1,0]) cube(size=[19,3,21],center=true);
		}
		translate([-35,9,73.5]){
			rotate([90,0,0]){
				cylinder(r=2.5,h=25,center=true);
			}
		}
	}

	//slidesAdjustedToMakeAtighterFit
	translate([0,0,58]){
//		color([1,1,0])  cube(size=[90,23.5,4],center=true);
		color([1,1,0])  cube(size=[90,24.75,4],center=true);
	}
	//verticalGuides
//	translate([0,-10.5,51]){
	translate([0,-11,51]){
		color([1,1,0])  cube(size=[90,2.75,10],center=true);
	}
//	translate([-5,10.5,51]){
	translate([-5,11,51]){
		color([1,1,0])  cube(size=[80,2.75,10],center=true);
	}
	//slides
//	translate([0,-11.75,50]){
	translate([0,-12,50]){
		color([1,1,0])  cube(size=[90,2.75,2],center=true);
	}
//	translate([-5,11.75,50]){
	translate([-5,12,50]){
		color([1,1,0])  cube(size=[80,2.75,2],center=true);
	}
	

	translate([39,-6,54]) cube(size=[2,12,5],center=true);
	translate([39,-6,52.5]) cube(size=[4,12,2],center=true);
	translate([30,-7,52]) cube(size=[5,6,9],center=true);
}

translate([0,0,-70]){
	mechanical_slideStepper_mountingBracket_small();
}
