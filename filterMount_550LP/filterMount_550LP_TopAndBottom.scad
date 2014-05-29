use <../filterMount_550LP_top.scad>
use <../filterMount_550LP_bottom.scad>
use <../filterMount_retainingBracket.scad>

//550LP_filterMount
rotate([-90,0,0]) {
	translate([0,-32.5,0]){
		550LP_filterMountTop();
	}
}
rotate([-90,0,0]) {
	translate([0,32.5,0]){
		550LP_filterMountBottom();
	}
}

//filterMountRetainingBracket
rotate([-90,0,0]) translate([0,0,40]){
	filterMountRetainingBracket();
}
rotate([90,180,0]) translate([0,0,40]){
	filterMountRetainingBracket();
}