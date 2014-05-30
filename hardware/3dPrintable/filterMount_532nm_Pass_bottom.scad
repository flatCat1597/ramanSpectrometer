use <write.scad>

module 532nmPassFilter(){
	rotate([0,90,0]) {
		cylinder(r=13.25, h=6,$fn=100,center=true);
	}
}

module 532nmPassFilterBottom(){
	difference(){
		//base
		translate([0,0,-7]) color([0.8,1,.6]) cube(size=[12,40,14],center=true);	
		//filterHole
		rotate([0,90,0]) {
			cylinder(r=13.5, h=7,$fn=100,center=true);
		}
		rotate([0,90,0]) {
			cylinder(r=12, h=20,$fn=100,center=true);
		}
		//screwHoles
		translate([0,16.5,-3]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
		translate([0,-16.5,-3]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
	}
	difference(){
		//basePlate
		translate([0,0,-14]) color([0.8,1,.6]) cube(size=[25,55,2],center=true);	
		//filterHole
		rotate([0,90,0]) {
			cylinder(r=13.5, h=7,$fn=100,center=true);
		}
		//screwHoles
		translate([9,24,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([9,-24,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,24,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,-24,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
	rotate([90,0,90]){
		translate([0,-9,4]){
//			write("532nmPassFilter",h=3,t=3,center=true);
		}
	}
}
translate([0,0,0]){
	532nmPassFilterBottom();
}

//532nmPassFilter();