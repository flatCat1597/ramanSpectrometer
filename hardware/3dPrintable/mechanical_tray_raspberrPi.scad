use <mechanical_raspiMount.scad>
use <mechanical_tray_standard.scad>

module raspiMount(){
	//raspiMount
	translate([0,-30,0]){
		color([0.9,0.2,0]) object1(1);
	}
}

difference(){
	mainTray();
	translate([-15,-10,0]){
		cube(size=[45,45,4],center=true);
	}
	translate([5,-45,0]){
		cube(size=[20,5,4],center=true);
	}
}

raspiMount();