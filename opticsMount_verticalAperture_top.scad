use <write.scad>
use <opticsMount_standard_top.scad>

module opticsMount_verticalAperture_top(slitWidth){
	translate([0,0,0]){
		difference(){
			opticsMount_standard_top("Vertical","Aperture");
//			//slit
//			translate([2,0,20]) cube(size=[5,slitWidth,25],center=true);
			//lensHole
			translate([-0,0,20]) cube(size=[6,25,25],center=true);
		}
	}
}

translate([0,0,0]){
	opticsMount_verticalAperture_top(.25);
}