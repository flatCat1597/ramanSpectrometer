use <write.scad>
use <opticsMount_standard_top.scad>

module opticsMount_mirror_top(){
	translate([0,0,0]){
		difference(){
			opticsMount_standard_top("Surface","Mirror");
			//lensHole
//			translate([-2,0,20]) cube(size=[6,25,25],center=true);
			translate([0,0,20]){
				rotate([0,90,0]){
//					cylinder(r=13,h=7,$fn=100,center=true);
					cylinder(r=16,h=7,$fn=100,center=true);
				}
			}
		}
	}
}

translate([0,0,0]){
	opticsMount_mirror_top();
}