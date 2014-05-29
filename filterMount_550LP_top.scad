use <arrow.scad>
use <filterMount_screwHoles.scad>

module 550LP_filterMountTop(){
	//arrow
	translate([44,0,0]){
		rotate([0,0,0]){
			arrow();
		}
	}
	//550LP Filter Mount Top
	difference(){
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//filterBody
		translate([0,22.5,0]) cylinder(h=3.5,r=4,center=true);
		//filterHole
		translate([0,22.5,0]) cylinder(h=30,r=3,center=true);
		//screwHoles
		upperScrewHoles();
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,center=true);
	}
}

//550LP_filterMount
rotate([-90,0,0]) {
	translate([0,0,0]){
		550LP_filterMountTop();
	}
}
