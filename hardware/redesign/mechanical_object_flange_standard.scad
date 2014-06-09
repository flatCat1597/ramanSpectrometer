module flange(){
	difference(){
		//tubeBody
		translate([5,0,0]) rotate([0,90,0]) cylinder(h=12,r=12,center=true);
		//throat
		translate([5,0,0]) rotate([0,90,0]) cylinder(h=13,r=10,center=true);
	}
}

module flangeFace(){
	difference(){
		union(){
			difference(){
				//flange
				translate([12,0,0]) rotate([0,90,0]) cylinder(r=20,h=4,center=true);
				//flangeThroat
				translate([12,0,0]) rotate([0,90,0]) cylinder(r=10,h=5,$fn=24,center=true);
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


union(){
	flange();
	flangeFace();
}