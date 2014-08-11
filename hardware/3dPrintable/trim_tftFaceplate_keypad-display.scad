use <electronic_tftDisplay.scad>
use <trim_tftFaceplate_facia.scad>

module trim_tftFacePlate_driveTray(){
	difference(){
		//mainBox
		translate([0,0,-45]) color([0.2,0.8,0.2]) cube(size=[146.1,41.3,100],center=true);
		//hollowBox1
		translate([0,-35,-60]) rotate([45,0,0]) color([0.2,0.2,0.2])cube(size=[150,100,140],center=true);
		//hollowBox2
		translate([0,0,-17]) rotate([0,0,0]) color([0.2,0.2,0.2])cube(size=[140,35,40],center=true);
		//connectorHole
		translate([-6.5,0,-0]) cube(size=[5,30,15],center=true);
		//screwHoles
		translate([-65,12,0]) cylinder(r=1.5,h=15,center=true);
		translate([-65,-12,0]) cylinder(r=1.5,h=15,center=true);
		translate([65,-10,1]) cylinder(r=1.5,h=25,center=true);
		translate([65,10,1]) cylinder(r=1.5,h=25,center=true);
		//lightBoxes-throughHoles (I'm sure this can be done with a for loop)
		//lightBoxes-okButton
		translate([-36,0,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-upButton
		translate([-36,11,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-downButton
		translate([-36,-11,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-leftButton
		translate([-25,0,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-rightButton
		translate([-47,0,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-helpButton
		translate([-47,-11,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-homeButton
		translate([-25,-11,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-selectButton
		translate([-47,11,5]) cube(size=[5.25,5.25,10],center=true);
		//lightBoxes-undoButton
		translate([-25,11,5]) cube(size=[5.25,5.25,10],center=true);

		//lightBoxes-wireHoleforButtons
		//lightBoxes-okButton
		translate([-32,4,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-upButton
		translate([-32,7,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-downButton
		translate([-32,-7,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-leftButton
		translate([-21,4,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-rightButton
		translate([-43,4,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-helpButton
		translate([-43,-7,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-homeButton
		translate([-21,-7,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-selectButton
		translate([-43,7,5]) cylinder(r=1,h=10,$fn=50,center=true);
		//lightBoxes-undoButton
		translate([-21,7,5]) cylinder(r=1,h=10,$fn=50,center=true);

		translate([65,-2,-3])  rotate ([-45,0,0]) cylinder(r=2.5,h=27,center=true);
		translate([-65,-2,-3])  rotate ([-45,0,0]) cylinder(r=2.5,h=27,center=true);

	}
	//tftSupports
	translate([25,-17.5,9]) cube(size=[70,5,8],center=true);
	translate([57,10,9]) cube(size=[5,20,8],center=true);

	translate([-2,4,9]) cube(size=[5,30,8],center=true);
	translate([-10,0,9]) cube(size=[3,40,9],center=true);

	difference(){
		translate([65,-2,-3]) rotate ([-45,0,0]) cylinder(r=6,h=20,center=true);
		translate([65,-2,-3]) rotate ([-45,0,0]) cylinder(r=2,h=22,center=true);
	}
	difference(){
		translate([-65,-2,-3]) rotate ([-45,0,0]) cylinder(r=6,h=20,center=true);
		translate([-65,-2,-3]) rotate ([-45,0,0]) cylinder(r=2,h=22,center=true);
	}

	difference(){
		//lightBoxes-mainCube
		translate([-36,0,11]) cube(size=[45,35,14],center=true);
		//lightBoxes-okButton
		translate([-36,0,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-upButton
		translate([-36,11,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-downButton
		translate([-36,-11,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-leftButton
		translate([-25,0,10.5])	cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-rightButton
		translate([-47,0,10.5])	cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-helpButton
		translate([-47,-11,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-homeButton
		translate([-25,-11,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-selectButton
		translate([-47,11,10.5]) cube(size=[9.5,9.5,16],center=true);
		//lightBoxes-undoButton
		translate([-25,11,10.5]) cube(size=[9.5,9.5,16],center=true);
	}
	//supports
	translate([-20,18.65,8]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-20,18.65,15]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-30,18.65,8]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-30,18.65,15]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-40,18.65,8]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-40,18.65,15]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-50,18.65,8]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
	translate([-50,18.65,15]) rotate([90,0,0]) color([.4,.3,.2]) cylinder(r=1,h=4,center=true);
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
