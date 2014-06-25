use <arrow.scad>

module beamSplitterMountTop(){
	//arrow
	translate([0,0,2]){
		rotate([0,90,90]){
			arrow();
		}
	}

	difference(){
		translate([0,0,0]) color([.95,.95,.95]) cube(size=[25,25,2],center=true);
		//topScrewholes
		translate([9,9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([9,-9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,-9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}

translate([0,0,0]){
	beamSplitterMountTop();
}
