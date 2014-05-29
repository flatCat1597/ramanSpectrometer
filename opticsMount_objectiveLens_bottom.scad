use <write.scad>
use <arrow.scad>

module objectiveLensMountBottom(){
	difference(){
		//mainBody
		translate([0,0,1]) color([0,.6,.5]) cube(size=[28,45,18],center=true);
		//lensHole
		translate([9,0,10]) rotate([0,90,0]) cylinder(h=13,r=12,center=true);
		translate([-6,0,10]) rotate([0,90,0]) cylinder(h=18,r=10,center=true);
		//screwHoles
		translate([-9,17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,-17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,-17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		//keys
		translate([0,17,7]) cube(size=[6,8,7],center=true);
		translate([0,-17,7]) cube(size=[8,6,7],center=true);
	}
	difference(){
		//base
		translate([0,0,-9]) color([0,.6,.5]) cube(size=[45,45,2],center=true);
		//screwHoles
		translate([-18,17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([18,17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([-18,-17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([18,-17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
	}
	//arrow
	translate([0,-24,0]){
		rotate([90,0,90]){
			arrow();
		}
	}
	rotate([0,0,-90]){
		translate([0,-18,-8]){
			write("Objective Lens",h=3,t=3,center=true);
		}
	}
	rotate([0,-90,0]){
		translate([0,-18,14]){
			write("100x",h=3,t=3,center=true);
		}
	}
}

translate([0,0,0]){
	objectiveLensMountBottom();
}
