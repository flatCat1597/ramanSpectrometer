use <../mechanical_rackAndPinion.scad>
use <../mechanical_cuvetteHolderTray_half1.scad>
use <../mechanical_cuvetteHolderTray_half2.scad>

cuvetteHolderTray_half1();
translate([0,0,15]){
	cuvetteHolderTray_half2();
}