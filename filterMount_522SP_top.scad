use <arrow.scad>
use <filterMount_screwHoles.scad>

module 522SP_filterMountTop(){
	//arrow
	translate([44,0,0]){
		rotate([0,0,0]){
			arrow();
		}
	}
	//522SP Filter Mount Top
	difference(){
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//lfilterBody
		translate([0,22.5,0]) cube(size=[40,5,3],center=true);
		//filterHole
		translate([0,22.5,0]) cube(size=[30,4,20],center=true);
		//screwHoles
		upperScrewHoles();
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,center=true);
		//key
		translate([30,20,0]){
			cube(size=[11,6,6],center=true);
		}
	}
	//key
	translate([-30,25,0]){
		cube(size=[10,5,5],center=true);
	}
}

//522SP_filterMount
rotate([-90,0,0]) translate([0,0,0]){
	522SP_filterMountTop();
}
