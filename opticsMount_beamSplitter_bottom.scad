use <write.scad>

module beamSplitterMountBottom(){
	difference(){
		//mainBody
		translate([0,0,3.25]) color([.95,.95,.95]) cube(size=[25,25,23],center=true);
		//centerCube
		translate([0,0,8.25]) color([.25,.95,.95]) cube(size=[13,13,13],center=true);
		//laserPath
		translate([0,0,10]) color([0,.95,0]) cube(size=[30,10,10],center=true);
		translate([0,0,10]) color([.1,.15,.95]) cube(size=[10,30,10],center=true);
		//topScrewholes
		translate([9,9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,-9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,-9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
	}
	difference(){
		//base
		translate([0,0,-9]) color([.95,.95,.95]) cube(size=[40,40,2],center=true);
		//baseScrewholes
		translate([16,16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([16,-16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,-16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
	rotate([0,0,0]){
		translate([0,-16,-8]){
			write("Beam Splitter",h=3,t=3,center=true);
		}
	}
}

translate([0,0,0]){
	beamSplitterMountBottom();
}
