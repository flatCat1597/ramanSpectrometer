use <../opticsMount_verticalAperture_top.scad>
use <../opticsMount_standard_bottom.scad>
use <../opticsMount_retainingBracket.scad>

translate([0,0,0]){
	opticsMount_verticalAperture_top(.25);
}
translate([0,0,-49]){
	opticsMount_standard_base();
}

translate([-2,0,20]){
	retainingBracket();
}