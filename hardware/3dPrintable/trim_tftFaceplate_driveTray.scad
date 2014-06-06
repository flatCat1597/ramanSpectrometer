use <electronic_tftDisplay.scad>
use <trim_tftFaceplate_facia.scad>
use <electronic_stNucleoF401RE.scad>

module trim_tftFacePlate_driveTray(){
	difference(){
		//mainBox
		translate([0,0,-45]){
			color([0.2,0.8,0.2]) cube(size=[146.1,41.3,100],center=true);
		}
		//hollowBox
		translate([0,-6,-53]){
			color([0.2,0.2,0.2])cube(size=[140,48,110],center=true);
		}
		//bottomHole
		translate([0,20,-50]){
			color([0.2,0.2,0.2])cube(size=[60,28,70],center=true);
		}
		//connectorHole
		translate([-6.5,0,-0]){
			cube(size=[5,30,15],center=true);
		}
		//screwHoles
		translate([-65,12,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([-65,-12,0]){
			cylinder(r=1.5,h=15,center=true);
		}
		translate([65,-10,1]){
			cylinder(r=1.5,h=25,center=true);
		}
		translate([65,10,1]){
			cylinder(r=1.5,h=25,center=true);
		}
		//lightBoxes-throughHoles (I'm sure this can be done with a for loop)
		//lightBoxes-okButton
		translate([-36,0,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,5]){
			cube(size=[5,5,10],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,5]){
			cube(size=[5,5,10],center=true);
		}
	}
	//tftSupports
	translate([25,-17.5,9]){
		cube(size=[70,5,8],center=true);
	}
	translate([57,10,9]){
		cube(size=[5,20,8],center=true);
	}
	translate([-2,4,9]){
		cube(size=[5,30,8],center=true);
	}
	translate([-10,0,9]){
		cube(size=[3,40,9],center=true);
	}
	difference(){
		//lightBoxes-mainCube
		translate([-36,0,11]){
			cube(size=[45,35,14],center=true);
		}
		//lightBoxes-okButton
		translate([-36,0,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,10.5]){
			cube(size=[9.5,9.5,15],center=true);
		}
	}
	//nucleoSupports
	//bottomRail_left
	translate([-36.25,13,-50]){
		color([1,0,0]) cube(size=[4,10,60],center=true);
	}	
	//topRail_left
	translate([-36.25,3,-50]){
		color([1,1,0]) cube(size=[4,2,60],center=true);
	}	
	//sideRail_left
	translate([-37.25,6,-50]){
		color([1,0,1]) cube(size=[2,4,60],center=true);
	}	
	//bottomRail_right
	translate([36.25,13,-50]){
		color([1,0,0]) cube(size=[4,10,60],center=true);
	}	
	//topRail_right
	translate([36.25,3,-50]){
		color([1,1,0]) cube(size=[4,2,60],center=true);
	}	
	//sideRail_right
	translate([37.25,6,-50]){
		color([1,0,1]) cube(size=[2,4,60],center=true);
	}	
	//bottomRail_top
	translate([0,13,-12]){
		color([1,0,0]) cube(size=[40,10,4],center=true);
	}	
	translate([-10,14.35,-15]){
		color([1,0,0]) cube(size=[12,12.5,4],center=true);
	}	

	translate([0,7,-11]){
		color([1,0,0]) cube(size=[20,4,2],center=true);
	}	
	//supports
	translate([-20,18.65,8]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-20,18.65,15]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-30,18.65,8]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-30,18.65,15]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-40,18.65,8]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-40,18.65,15]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-50,18.65,8]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
	translate([-50,18.65,15]){
		rotate([90,0,0]){
			color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
		}
	}
}



rotate([90,180,0]){
//	trim_tftFacePlate_facia();
	trim_tftFacePlate_driveTray();
}
rotate([90,0,0]){
	translate([-25.5,0,16.25]){
//		screen();
	}
}

rotate([0,0,270]){
	translate([-55,0,-10]){
//		st_nucleo_F401RE();
	}
}