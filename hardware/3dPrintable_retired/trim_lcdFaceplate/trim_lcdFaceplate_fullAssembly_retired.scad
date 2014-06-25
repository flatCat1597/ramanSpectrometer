use <../electronic_lcdDisplay.scad>
use <../trim_lcdFacePlate_facia.scad>
use <../trim_lcdFacePlate_driveTray.scad>

rotate([90,180,0]){
	trim_lcdFacePlate_facia();
	trim_lcdFacePlate_driveTray();
	translate([30,6,20]){
		lcdDisplay();
	}
}