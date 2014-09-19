use <std_mechanical_lib_rackAndPinion.scad>
use <mechanical_device_filterSelectorAssembly_centerHub_Front.scad>
use <mechanical_device_filterSelectorAssembly_centerHub_Back.scad>

module filterWheel(){
	difference(){
		rotate([90,0,0]) color([.6,.7,.2]) pinion(4,60,4,8);
		//unused filterHole
		translate([0,-2,26.25]) rotate([90,0,0]) cylinder(r=8,h=5,center=true);
	
		//522nmSP filterHole
		union(){
			translate([-26.25,-2,-0]) rotate([90,0,0]) cylinder(r=2.5,h=5,$fn=100,center=true);
			translate([-26.25,-2.5,0]) cube(size=[7,4,45],center=true);
		}

		//550nmLP filterHole
		translate([0,-2,-26.25]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
		translate([0,-3,-26.25]) rotate([90,0,0]) cylinder(r=6,h=4,center=true);

		//hub screwHoles
		translate([0,-2,6.5]) rotate ([90,0,0]) cylinder(r=2,h=7,center=true);
		translate([0,-2,-6.5]) rotate ([90,0,0]) cylinder(r=2,h=7,center=true);
		translate([-6.5,-2,0]) rotate ([90,0,0]) cylinder(r=2,h=7,center=true);
		translate([6.5,-2,0]) rotate ([90,0,0]) cylinder(r=2,h=7,center=true);

		//filter#1 (550nmLP)_screwHoles
		translate([8,-2,-18]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([-8,-2,-18]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([-11,-2,-30]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([11,-2,-30]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);

		//filter#2 (522nmSP)_screwHoles
		translate([-20,-2,-15]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([-20,-2,15]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([-32,-2,-10]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);
		translate([-32,-2,10]) rotate([90,0,0]) cylinder(r=1.5,h=5,center=true);

	}
}

module 522nmSP_cover(){
	difference(){
		translate([-26.25,-5,0]) cube(size=[7,2,25],center=true);	
		translate([-26.25,-5,-0]) rotate([90,0,0]) cylinder(r=2.5,h=5,$fn=100,center=true);
	}
	difference(){
		translate([-26.25,-5,-12.5]) rotate([0,-67,0]) cube(size=[5,2,19],center=true);	
		translate([-20,-5,-15]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
		translate([-32,-5,-10]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
	}
	difference(){
		translate([-26.25,-5,12.5]) rotate([0,67,0]) cube(size=[5,2,19],center=true);	
		translate([-20,-5,15]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
		translate([-32,-5,10]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
	}
}

module 550nmSP_cover(){
	difference(){
		intersection(){
			translate([0,-5,-26.25]) cube(size=[30,2,23],center=true);
			translate([0,-5,-17]) rotate([90,0,0]) cylinder(r=20,h=3,center=true);
		}
		//centerHole
		translate([0,-5,-26.25]) rotate([90,0,0]) cylinder(r=4,h=3,center=true);
		//screwHoles
		translate([8,-5,-18]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
		translate([-8,-5,-18]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
		translate([-11,-5,-30]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
		translate([11,-5,-30]) rotate([90,0,0]) cylinder(r=2,h=5,center=true);
	}
}

filterWheel();
//centerHubFront();
centerHubBack();

522nmSP_cover();
550nmSP_cover();
