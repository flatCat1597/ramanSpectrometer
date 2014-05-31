use <arrow.scad>

module collimatingLensMountTop(){
	//arrow
	translate([24,0,0]){
		rotate([-90,0,0]){
			arrow();
		}
	}
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,12,29],center=true);
		//lensHole
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=8,r=11.5,$fn=100,center=true);
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=14,r=10,$fn=100,center=true);
		//screwHoles
		translate([-18,0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
		translate([18,-0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
	}
}

translate([0,0,0]){
	collimatingLensMountTop();
}
