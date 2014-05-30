//use <write.scad>

//module 532nmPassFilter(){
//	rotate([0,90,0]) {
//		cylinder(r=13.25, h=6,$fn=100,center=true);
//	}
//}

module 532nmPassFilterBottom(){
	difference(){
		//basePlate
		translate([0,0,-14]){
			color([0.8,1,.6]) cube(size=[25,55,2],center=true);	
		}
		//filterHole
		rotate([0,90,0]) {
			cylinder(r=13.5, h=7,$fn=50,center=true);
		}
		//screwHoles
		translate([9,24,-14]){
			 color([1,0,0]) cylinder(r=1.5,h=5,$fn=8,center=true);
		}
		translate([9,-24,-14]) {
			color([1,0,0]) cylinder(r=1.5,h=5,$fn=8,center=true);
		}
		translate([-9,24,-14]){
			color([1,0,0]) cylinder(r=1.5,h=5,$fn=8,center=true);
		}
		translate([-9,-24,-14]){
			color([1,0,0]) cylinder(r=1.5,h=5,$fn=8,center=true);
		}
	}
	difference(){
		//base
		translate([0,0,-7]){
			color([0.8,1,.6]) cube(size=[12,40,14],center=true);	
		}
		//filterHole
		translate([0,0,0]){
			rotate([0,90,0]) {
				cylinder(r=13.5, h=7,$fn=50,center=true);
			}
		}
		translate([0,0,0]){
			rotate([0,90,0]) {
				cylinder(r=12, h=15,$fn=50,center=true);
			}
		}
		//screwHoles
		translate([0,16.5,-3]){
			color([1,0,0]) cylinder(r=1.5,h=8,$fn=8,center=true);
		}
		translate([0,-16.5,-3]){
			color([1,0,0]) cylinder(r=1.5,h=8,$fn=8,center=true);
		}
		//keyNub_innie
		translate([-4,18,-1]){
			 cube(size=[2.5,4.5,2.5],center=true);
		}
	}
	//keyNub_outtie
	translate([4,-18,1]){
		cube(size=[2,4,2],center=true);
	}
}


translate([0,0,0]){
	532nmPassFilterBottom();
}

//532nmPassFilter();