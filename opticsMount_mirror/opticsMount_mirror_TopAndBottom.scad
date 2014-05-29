use <../opticsMount_mirror_top.scad>
use <../opticsMount_standard_bottom.scad>
use <../opticsMount_retainingBracket.scad>
use <../opticsMount_mirrorAssembly_front.scad>
use <../opticsMount_mirrorAssembly_rear.scad>

translate([0,0,0]){
	opticsMount_mirror_top(0);
}
translate([0,0,-49]){
	opticsMount_standard_base();
}

translate([0,0,20]){
	mirrorAssembly_front();
}
translate([10,0,20]){
	mirrorAssembly_rear();
}

translate([2.5,0,20]){
//	%mirror();
}