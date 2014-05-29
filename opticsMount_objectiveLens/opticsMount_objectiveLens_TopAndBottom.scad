use <../opticsMount_objectiveLens_top.scad>
use <../opticsMount_objectiveLens_bottom.scad>

translate([0,0,30]){
	objectiveLensMountTop();
}
translate([0,0,0]){
	objectiveLensMountBottom();
}
