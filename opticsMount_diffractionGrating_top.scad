use <write.scad>
use <opticsMount_standard_top.scad>

module opticsMount_diffractionGrating_top(){
	translate([0,0,0]){
		difference(){
			opticsMount_standard_top("Diffraction","Grating");
			//lensHole
			translate([-5,0,20]) cube(size=[6,25,25],center=true);
		}
	}
}

translate([0,0,0]){
	opticsMount_diffractionGrating_top();
}