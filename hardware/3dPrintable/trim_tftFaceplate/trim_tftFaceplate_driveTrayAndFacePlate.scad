use <../trim_tftFaceplate_facia.scad>
use <../trim_tftFaceplate_driveTray.scad>
use <../electronic_tftDisplay.scad>

rotate([90,180,0]){
	trim_tftFacePlate_facia();
	trim_tftFacePlate_driveTray();
}
rotate([90,0,0]){
	translate([-25.5,0,16.25]){
		screen();
	}
}