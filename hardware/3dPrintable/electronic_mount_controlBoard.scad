use <std_mechanical_object_tray.scad>
use <electronic_stNucleoF401RE.scad>

module edgeClips(){
	translate([0,0,6]){
		color([0.8,0.2,0.1]) cube(size=[3,25,12],center=true);
	}
	translate([3,0,4]){
		color([0.8,0.2,0.1]) cube(size=[8,15,9],center=true);
	}
	translate([1.5,0,13]){
		color([0.8,0.2,0.1]) cube(size=[6,25,2],center=true);
	}
}

module edgeClipPositions(){
	translate([-68,-36,0]){
		edgeClips();
	}
	translate([-68,35,0]){
		edgeClips();
	}
	translate([-15,-46,0]){
		rotate([0,0,90]){
			edgeClips();
		}
	}
	translate([-15,46,0]){
		rotate([0,0,270]){
			edgeClips();
		}
	}
	translate([45,-46,0]){
		rotate([0,0,90]){
			edgeClips();
		}
	}
	translate([45,46,0]){
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