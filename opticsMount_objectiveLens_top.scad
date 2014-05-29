use <arrow.scad>

module objectiveLensMountTop(){
	difference(){
		//mainBody
		translate([0,0,2]) color([0,.6,.5]) cube(size=[28,45,16],center=true);
		//lensHole
		translate([9,0,-6]) rotate([0,90,0]) cylinder(h=13,r=12,center=true);
		translate([-6,0,-6]) rotate([0,90,0]) cylinder(h=18,r=10,center=true);
		//screwHoles
		translate([-9,17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([9,17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([-9,-17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([9,-17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
	}
	translate([0,-24,0]){
		rotate([90,0,90]){
			arrow();
		}
	}
}

translate([0,0,0]){
	objectiveLensMountTop();
}
