module flangeBody(){
	difference(){
		//tubeBody
		intersection(){
			translate([5,0,0]) rotate([0,90,0]) cylinder(h=12,r=12,center=true);
			translate([5,0,0]) cube(size=[20,20,20],center=true);
		}
		//throat
		intersection(){
			translate([5,0,0]) rotate([0,90,0]) cylinder(h=13,r=10,center=true);
			translate([5,0,0]) cube(size=[15,15,15],center=true);
		}
	}
}

module flangeFace(){
	difference(){
		union(){
			difference(){
				//flange
				intersection(){
					translate([12,0,0]) rotate([0,90,0]) cylinder(r=23,h=4,center=true);
					translate([12,0,0]) cube(size=[10,40,35],center=true);
				}
				//flangeThroat
				intersection(){
					translate([12,0,0]) rotate([0,90,0]) cylinder(r=10,h=5,$fn=24,center=true);
					translate([12,0,0]) cube(size=[10,20,15],center=true);
				}
			}
		}
		//tubeMountingHoles
		rotate([22.5,0,0]){
			for ( v = [0 : 8] ){
				rotate( v * 360 / 8, [1, 0, 0]){
					translate([12, 15, 0]){
						rotate([0,90,0]){
							cylinder(r=2,h=5,$fn=36,center=true);
						}
					}
				}
			}
		}
	}
}

module flange(){
	union(){
		flangeBody();
		flangeFace();
	}
}

flange();