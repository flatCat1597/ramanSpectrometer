use <std_mechanical_lib_rackAndPinion.scad>
module mechanical_cuvetteTrayMotorPinion(){
	rotate([90,5,0]){
		color([.6,.7,.2]) pinion(4,14,6.25,5);
	}
}

translate([0,0,0]){
	mechanical_cuvetteTrayMotorPinion();
}