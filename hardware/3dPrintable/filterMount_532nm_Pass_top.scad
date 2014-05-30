module 532nmPassFilter(){
	rotate([0,90,0]) {
		cylinder(r=13.25, h=6,$fn=100,center=true);
	}
}

module 532nmPassFilterTop(){
	difference(){
		//filterHolderTop
		translate([0,0,8]) color([0.8,1,.6]) cube(size=[12,40,16],center=true);	
		//filterHole
		rotate([0,90,0]) {
			cylinder(r=13.5, h=7,$fn=100,center=true);
		}
		rotate([0,90,0]) {
			cylinder(r=12, h=20,$fn=100,center=true);
		}
		//screwHoles
		translate([0,16.5,8]) color([1,0,0]) cylinder(h=17,r=1.5,$fn=8,center=true);
		translate([0,-16.5,8]) color([1,0,0]) cylinder(h=17,r=1.5,$fn=8,center=true);
	}
}
translate([0,0,0]){
	532nmPassFilterTop();
}

//532nmPassFilter();