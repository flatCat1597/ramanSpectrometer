use <../filterMount_interference_top.scad>
use <../filterMount_interference_bottom.scad>
use <../filterMount_retainingBracket.scad>

//interferenceMount
rotate([-90,0,0]) translate([0,-32.5,0]){
	interferenceFilterMountTop();
}
rotate([-90,0,0]) translate([0,32.5,0]){
	interferenceFilterMountBottom();
}

//filterMountRetainingBracket
rotate([-90,0,0]) translate([0,0,34]){
	filterMountRetainingBracket();
}
rotate([90,180,0]) translate([0,0,34]){
	filterMountRetainingBracket();
}