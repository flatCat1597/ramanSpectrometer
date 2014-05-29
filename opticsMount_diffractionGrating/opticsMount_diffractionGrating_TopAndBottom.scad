use <../opticsMount_diffractionGrating_top.scad>
use <../opticsMount_standard_bottom.scad>
use <../opticsMount_retainingBracket.scad>

translate([0,0,0]){
	opticsMount_diffractionGrating_top();
}
translate([0,0,-49]){
	opticsMount_standard_base();
}
translate([-10,0,20]){
	retainingBracket();
}