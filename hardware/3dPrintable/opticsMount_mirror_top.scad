use <write.scad>
use <opticsMount_standard_top.scad>

module opticsMount_mirror_top(){
	translate([0,0,0]){
		difference(){
			opticsMount_standard_top("Surface","Mirror");
			//removalTabInserts
			rotate([45,0,0]){
				translate([-2,14,14]) cube(size=[6,25,25],center=true);
			}
			//lensHole
			translate([0,0,20]){
				rotate([0,90,0]){
//					cylinder(r=13,h=7,$fn=100,center=true);
					cylinder(r=16,h=7,$fn=100,center=true);
				}
			}
		}
	}
}

module supports(){
	//supports
	translate([0,0,20]){
		cube(size=[5,.5,25],center=true);
	}
	translate([0,1.75,6]){
		rotate([45,0,0]){
			cube(size=[5,.25,5],center=true);
		}
	}
	translate([0,-1.75,6]){
		rotate([-45,0,0]){
			cube(size=[5,.25,5],center=true);
		}
	}
	translate([0,-1.75,34]){
		rotate([45,0,0]){
			cube(size=[5,.25,5],center=true);
		}
	}
	translate([0,1.75,34]){
		rotate([-45,0,0]){
			cube(size=[5,.25,5],center=true);
		}
	}

	translate([0,10,20]){
		cube(size=[5,.5,20],center=true);
	}
	translate([0,11,9.25]){
		rotate([45,0,0]){
			cube(size=[5,.25,3],center=true);
		}
	}
	translate([0,11,30.75]){
		rotate([-45,0,0]){
			cube(size=[5,.25,3],center=true);
		}
	}


	translate([0,-10,20]){
		cube(size=[5,.5,20],center=true);
	}
	translate([0,-11,9.25]){
		rotate([-45,0,0]){
			cube(size=[5,.25,3],center=true);
		}
	}
	translate([0,-11,30.75]){
		rotate([45,0,0]){
			cube(size=[5,.25,3],center=true);
		}
	}
}

translate([0,0,0]){
	opticsMount_mirror_top();
	supports();
}