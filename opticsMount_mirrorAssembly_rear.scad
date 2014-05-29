use <opticsMount_retainingBracket.scad>

module mirrorAssembly_rear(){
	translate([0,0,0]){
		rotate([180,180,0]){
			retainingBracket();
		}
	}
	translate([0,0,0]){
			cube(size=[5,25,25],center=true);
		}
		translate([-1,0,0]){
			rotate([0,90,0]) color([.3,.7,.2]) cylinder(r=13,h=8,$fn=100,center=true);
		}
}

mirrorAssembly_rear();