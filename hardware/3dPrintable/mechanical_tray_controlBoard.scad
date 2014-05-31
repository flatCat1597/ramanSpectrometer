use <mechanical_tray_standard.scad>
use <electronic_stNucleoF401RE.scad>

module edgeClips(){
	translate([0,0,6]){
		color([0.8,0.2,0.1]) cube(size=[4,5,12],center=true);
	}
	translate([2,0,5]){
		color([0.8,0.2,0.1]) cube(size=[2,5,9],center=true);
	}
	translate([1.75,2.5,11.5]){
		rotate([90,0,0]){
			cylinder(r=.5,h=5,$fn=10);
		}
	}
}

module edgeClipPositions(){
	translate([-67,-36,0]){
		edgeClips();
	}
	translate([-67,30,0]){
		edgeClips();
	}
	translate([-7,-45.75,0]){
		rotate([0,0,90]){
			edgeClips();
		}
	}
	translate([-7,37.75,0]){
		rotate([0,0,270]){
			edgeClips();
		}
	}
}

translate([-30,-4,10.25]){
	rotate([0,0,270]){
//		st_nucleo_F401RE();
	}
}

difference(){
	mainTray();
	translate([-32,-4,0]){
		cube(size=[55,70,4],center=true);
	}
	translate([32,-4,0]){
		cube(size=[55,70,4],center=true);
	}
}
edgeClipPositions();