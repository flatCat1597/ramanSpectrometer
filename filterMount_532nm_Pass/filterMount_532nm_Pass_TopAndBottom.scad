use <../filterMount_532nm_Pass_top.scad>
use <../filterMount_532nm_Pass_bottom.scad>

translate([0,0,20]){
	532nmPassFilterTop();
}
translate([0,0,0]){
	532nmPassFilterBottom();
}
