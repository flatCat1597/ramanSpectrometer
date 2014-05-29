use <../arrow.scad>
use <../opticsMount_collimating_top.scad>
use <../opticsMount_collimating_bottom.scad>

translate([0,0,60]){
	collimatingLensMountTop();
}
translate([0,0,0]){
	collimatingLensMountBottom();
}
