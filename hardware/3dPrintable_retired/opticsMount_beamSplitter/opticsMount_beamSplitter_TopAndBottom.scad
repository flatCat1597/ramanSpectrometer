use <../write.scad>
use <../opticsMount_beamSplitter_top.scad>
use <../opticsMount_beamSplitter_bottom.scad>

translate([0,0,30]){
	beamSplitterMountTop();
}
translate([0,0,0]){
	beamSplitterMountBottom();
}
