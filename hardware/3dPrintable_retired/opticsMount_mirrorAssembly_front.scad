use <opticsMount_retainingBracket.scad>

module mirror(){
	rotate([0,90,0]) cylinder(r=13,h=5,$fn=100,center=true);
}

module mirrorAssembly_front(){
	translate([-7,0,0]){
		retainingBracket();
	}
	//faceHole
	difference(){
		translate([-7,0,0]){
			cube(size=[5,25,25],center=true);
		}
		translate([-5,0,0]){
			rotate([0,90,0]) color([.4,.2,.2]) cylinder(r=13.5,h=17,$fn=100,center=true);
		}
	}
	//mirrorTube
	difference(){
		translate([0,0,0]){
			rotate([0,90,0]) color([.4,.2,.2]) cylinder(r=14.5,h=15,$fn=100,center=true);
		}
		translate([0,0,0]){
			rotate([0,90,0]) color([.4,.2,.2]) cylinder(r=13.5,h=17,$fn=100,center=true);
		}
	}

	//insideMirrorRetainer
	difference(){
		translate([-3,0,0]){
			rotate([0,90,0]) color([.5,.2,.7]) cylinder(r=13.5,h=6,$fn=100,center=true);
		}
		translate([-3,0,0]){
			rotate([0,90,0]) color([.5,.2,.7]) cylinder(r=12,h=8,$fn=100,center=true);
		}
	}

	translate([2.50,0,0]){
//		%mirror();
	}	

}

mirrorAssembly_front();