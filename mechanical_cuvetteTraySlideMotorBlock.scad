use <mechanical_rackAndPinion.scad>
use <electronic_photoInterrupter.scad>
use <arrow.scad>

module cuvetteTraySlideMotorBlock(){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[70,60,20],center=true);
		//trayHole
		translate([0,0,3]) color([.73,.75,.95]) cube(size=[75,40,4],center=true);
		//railHoles
		translate([0,20,-1]) color([.73,.75,.95]) cube(size=[75,4,12],center=true);
		translate([0,-20,-1]) color([.73,.75,.95]) cube(size=[75,4,12],center=true);
		//rackHole
		translate([0,0,0]) color([.73,.75,.95]) cube(size=[75,15,10],center=true);
		//motorAndGearHole
		translate([0,10,-10]) color([.73,.75,.95]) cube(size=[27,45,15],center=true);
	}
	//verticalSupports
	translate([-32.5,0,-22]) color([.1,.5,.9]) cube(size=[5,30,30],center=true);
	translate([32.5,0,-22]) color([.1,.5,.9]) cube(size=[5,30,30],center=true);
	difference(){
		//stepperMountingPlate
		translate([0,3,-22]) color([.1,.5,.9]) cube(size=[65,5,30],center=true);
		//stepperShaftAndGearHole
		translate([0,3,-10]) rotate([90,0,0]) cylinder(h=10,r=13.75,center=true);
		//stepperMountingScrewHoles
		translate([17,3,-19]) rotate([90,0,0]) cylinder(h=10,r=2,center=true);
		translate([-17,3,-19]) rotate([90,0,0]) cylinder(h=10,r=2,center=true);
	}
	difference(){
		//mountingPlate
		translate([0,0,-36]) color([.1,.5,.9]) cube(size=[65,30,2],center=true);
		//wirePassSlot
		translate([0,12,-35])  cube(size=[10,20,5],center=true);
		//stepperMountingScrewHoles
		translate([17,-10,-35]) rotate([0,0,0]) cylinder(h=10,r=2,center=true);
		translate([-17,-10,-35]) rotate([0,0,0]) cylinder(h=10,r=2,center=true);
		translate([17,10,-35]) rotate([0,0,0]) cylinder(h=10,r=2,center=true);
		translate([-17,10,-35]) rotate([0,0,0]) cylinder(h=10,r=2,center=true);
	}
	translate([34,0,-20]){
		rotate([-90,0,0]){
			arrow();
		}
	}
	//photoInterrupter
//	translate([-38,-19,-6.5]) rotate([0,90,0])  photoInterrupter();
	difference(){	
		translate([-38,-19,-8]) cube(size=[6,22,18],center=true);
		translate([-39,-19,-5]) cube(size=[15,10,14],center=true);
		translate([-38,-19,-6]) cube(size=[4,20,17],center=true);
		translate([-38,-19,-15]) cube(size=[4,17,5],center=true);

		translate([-40,-23.5,-15]) cube(size=[11,17,10],center=true);
	}
//		translate([-38,-23,-16]) cube(size=[4,4,2],center=true);	
//		translate([-38,-15,-16]) cube(size=[4,4,2],center=true);	
}


translate([0,0,0]){
	cuvetteTraySlideMotorBlock();
}
