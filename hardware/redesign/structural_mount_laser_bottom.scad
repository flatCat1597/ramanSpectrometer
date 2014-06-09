module outerCasing_bottom(){
	union(){
		difference(){
			intersection(){
				//outsideBox
				translate([0,0,-12.5]) cube(size=[105,60,25],center=true);
				//bevels
				translate([0,0,-5]) rotate([45,0,0]) cube(size=[106,60,60],center=true);
			}
			union(){
				//innerBox
				cube(size=[97,42,42],center=true);
				//fanCutout
				translate([-50,0,0]) rotate([0,90,0]) sphere(r=19,center=true);
				//laserOutput
				translate([55,0,0]) rotate([0,90,0]) sphere(r=10,center=true);
			}
			//rearMountingScrewHoles
			rotate([22.5,0,0]){
				for ( x = [0 : 7] ){
					rotate( x * 360 / 8, [1, 0, 0]){
						translate([-50, 22.5, 0]){
							rotate([0,90,0]){
								cylinder(r=1.25,h=6,center=true);
							}
						}
					}
				}
			}
			//ventilationHoles
			rotate([22.5,0,0]){
				for ( z = [0 : 7] ){
					rotate( z * 360 / 8, [1, 0, 0]){
						translate([50, 15, 0]){
							rotate([0,90,0]){
								cylinder(r=3,h=7,center=true);
							}
						}
					}
				}
			}
			//screwHoles
			translate([35,-25,-4]) cylinder(h=10,r=1.25,center=true);
			translate([-35,25,-4]) cylinder(h=10,r=1.25,center=true);
			translate([35,25,-4]) cylinder(h=10,r=1.25,center=true);
			translate([-35,-25,-4]) cylinder(h=10,r=1.25,center=true);
			//alignmentPeg1
			translate([0,25,-4]) cylinder(h=10,r=2.25,center=true);
		}
		//alignmentPeg2
		translate([0,-25,0]) cylinder(h=10,r=2,center=true);
	}
}

module flange(){
	difference(){
		//tubeBody
		translate([55,0,0]) rotate([0,90,0]) cylinder(h=12,r=12,center=true);
		//throat
		translate([55,0,0]) rotate([0,90,0]) cylinder(h=13,r=10,center=true);
		//topHalfCutoff
		translate([55,0,6.5]) cube(size=[13,30,13],center=true);
	}
}

module flangeFace(){
	difference(){
		union(){
			difference(){
				//flange
				translate([62,0,0]) rotate([0,90,0]) cylinder(r=20,h=4,center=true);
				//flangeThroat
				translate([62,0,0]) rotate([0,90,0]) cylinder(r=10,h=5,$fn=24,center=true);
			}
		}
		//tubeMountingHoles
		rotate([22.5,0,0]){
			for ( v = [0 : 8] ){
				rotate( v * 360 / 8, [1, 0, 0]){
					translate([62, 15, 0]){
						rotate([0,90,0]){
							cylinder(r=2,h=5,$fn=36,center=true);
						}
					}
				}
			}
		}
		//topHalfCutoff
		translate([55,0,12.5]){
			cube(size=[20,50,25],center=true);
		}
	}
}

module structural_mount_laser_bottom(){
	union(){
		outerCasing_bottom();
		flange();
		flangeFace();
	}
}

//translate([6,0,7]) color([1,0,0])cube(size=[116,1,1],center=true);

structural_mount_laser_bottom();