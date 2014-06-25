use <write.scad>
use <filterMount_screwHoles.scad>

module interferenceFilterMountBottom(){
	//Interference Filter Mount Top
	difference(){
		//mountBody
		color([.6,.1,.6]) cube(size=[90,45,25],center=true);
		//filterBody
		translate([0,-22.25,-2.5]) cylinder(h=16,r=32.5,$fn=100,center=true);
		//filterScrewMount
		translate([0,-22.5,6.5]) cylinder(h=6,r=26.5,$fn=100,center=true);
		//filterHole
		translate([0,-22.5,0]) cylinder(h=30,r=20,$fn=100,center=true);
		//screwHoles
		lowerScrewHoles();
	}
	rotate([0,0,180]){
		translate([0,-5,12]){
			write("Interference Filter",h=4,t=3,center=true);
		}
	}
}

rotate([-90,0,0]){
	translate([0,0,0]){
		interferenceFilterMountBottom();
	}
}