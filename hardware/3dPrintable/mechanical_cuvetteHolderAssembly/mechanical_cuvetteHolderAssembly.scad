use <../mechanical_rackAndPinion.scad>
use <../mechanical_stepperMotor.scad>
use <../mechanical_cuvetteHolderTray_half1.scad>
use <../mechanical_cuvetteHolderTray_half2.scad>
use <../mechanical_cuvetteTraySlideMotorBlock.scad>
use <../mechanical_cuvetteTrayMotorPinion.scad>

translate([0,0,38]){
	cuvetteTraySlideMotorBlock();
}
translate([0,3,27]){
	mechanical_cuvetteTrayMotorPinion();
}
translate([5,0,41]){
	cuvetteHolderTray_half1();
	cuvetteHolderTray_half2();
	door();
}
