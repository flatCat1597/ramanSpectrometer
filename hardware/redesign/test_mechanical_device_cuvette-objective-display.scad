use <rw_electronic_object_tftDisplay.scad>
use <trim_tftFaceplate_facia.scad>
use <optics_module_beamSplitter_top.scad>
use <std_mechanical_object_flange3.scad>

module mainBox(){
	difference(){
		//mainBox
			color([0.2,0.8,0.2]) cube(size=[41.3,170,146.1,],center=true);
		//hollowBox
		translate([6,0,0]){
			color([0.2,0.2,0.2])cube(size=[49,166,142],center=true);
		}
		//frontDoorHole
		translate([0,-85,-30]) cube(size=[30,7,70],center=true);
		//flangeHoles
		translate([-20,52.5,-20]) cube(size=[5,10,35],center=true);
		translate([0,82,-30]) cube(size=[30,10,50],center=true);
	}
	//back
	translate([-50,-86,50]){
		color([0.2,0.8,0.2]) cube(size=[147,2,50],center=true);
	}
	//top
	translate([-50,-90.75,77.25]){
		rotate([57,0,0]) color([0.2,0.8,0.2]) cube(size=[147,2,13],center=true);
	}
	//bottom
	translate([-50,-124.5,43.5]){
		rotate([32,0,0]) color([0.2,0.8,0.2]) cube(size=[147,2,13],center=true);
	}
	//left
	translate([-122.5,-107.75,60.55]) {
		rotate([-45,0,0]) color([0.2,0.8,0.2]) cube(size=[2,12,47],center=true);
	}
	//right
	translate([22.5,-107.75,60.55]) {
		rotate([-45,0,0]) color([0.2,0.8,0.2]) cube(size=[2,12,47],center=true);
	}
}

module objectiveMount(){	
	difference(){
		//mainBody
		intersection(){
			translate([0,3,0]) color([0,.6,.5]) cube(size=[30,30,25],center=true);
			translate([0,3,0]) rotate([90,0,0]) cylinder(r=18,h=35,center=true);
		}
		//lensHole
		translate([0,9,0]) rotate([90,0,0]) cylinder(h=13,r=12,center=true);
		translate([0,-6,0]) rotate([90,0,0]) cylinder(h=18,r=10,center=true);
		intersection(){
			translate([0,14,0]) cube(size=[20,10,15],center=true);
			translate([0,15,0]) rotate([90,0,0]) cylinder(r=10,h=10,center=true);
		}
	}
	union(){
		intersection(){
			difference(){
				translate([0,48,0]) cube(size=[30,60,20],center=true);
				intersection(){
					translate([0,48,0]) cube(size=[28,61,10],center=true);
					translate([0,48,0]) rotate([90,0,0]) cylinder(r=7,h=62,center=true);
				}
			translate([0,48,0]) rotate([0,0,0]) cube(size=[27,40,17],center=true);
			}
			translate([0,48,0]) rotate([90,0,0]) cylinder(r=15,h=62,center=true);
		}
		translate([0,73.5,0]){
			rotate([0,0,90]){
				flange();
			}
		}
	}
}

translate([0,-35,-22]){
		objectiveMount();
}

module tray(){
	//mainTray
	color([0.2,0.8,0.9]) cube(size=[28,150,2],center=true);
	difference(){
		intersection(){
			translate([0,-60,11]) cube(size=[25,25,20],center=true);
			translate([0,-60,11]) sphere(r=15,center=true);
		}
		translate([0,-60,15]) cube(size=[14,14,25],center=true);
	}
	intersection(){
		translate([0,-55,5]) cube(size=[28,35,10],center=true);
		translate([0,-55,11]) sphere(r=20,center=true);
	}
}

//cuvetteTrayMovement
translate([0,-100,-60]){
	tray();
	//cuvette
	%translate([0,-60,35]) cube(size=[12,12,45],center=true);
}

module displayPlate(){
	difference(){
		//mainBox
		translate([0,0,4]){
			color([0.2,0.8,0.2]) cube(size=[147,50,2],center=true);
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
		//connectorHole
		translate([-6.5,0,-0]){
			cube(size=[5,30,15],center=true);
		}

		//lightBoxes-throughHoles (I'm sure this can be done with a for loop)
		//lightBoxes-okButton
		translate([-36,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,5]){
			cube(size=[5,5,12],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,5]){
			cube(size=[5,5,12],center=true);
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
			color([0.6,1,0]) cube(size=[45,35,14],center=true);
		}
		//lightBoxes-okButton
		translate([-36,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-upButton
		translate([-36,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-downButton
		translate([-36,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-leftButton
		translate([-25,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-rightButton
		translate([-47,0,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-helpButton
		translate([-47,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-homeButton
		translate([-25,-11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-selectButton
		translate([-47,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
		//lightBoxes-undoButton
		translate([-25,11,10.5]){
			cube(size=[9.5,9.5,17],center=true);
		}
	}
}

/*
difference(){
	translate([-110,91,0]) color([0.25,0.25,0.25]) cube(size=[310,350,250],center=true);
	translate([-110,91,2]) color([0.25,0.25,0.25]) cube(size=[308,348,248],center=true);
}
*/

translate([0,95,-22]){
	rotate([0,0,180]){
		beamSplitterTop();
	}
}

translate([-50,-101,53.75]){
		translate([-25.25,-11.5,11.5]){
			rotate([45,0,0]){
				screen();
			}
		}
	rotate([-45,0,180]){
		displayPlate();
		trim_tftFacePlate_facia();
	}
}

mainBox();