use <../filterMount_522SP_top.scad>
use <../filterMount_522SP_bottom.scad>
use <../filterMount_retainingBracket.scad>

//522SP_filterMount
rotate([-90,0,0]) translate([0,-32.5,0]){
	522SP_filterMountTop();
}
rotate([-90,0,0]) translate([0,32.5,0]){
	522SP_filterMountBottom();
}

//filterMountRetainingBracket
rotate([-90,0,0]) translate([0,0,40]){
	filterMountRetainingBracket();
}
rotate([90,180,0]) translate([0,0,40]){
	filterMountRetainingBracket();
}