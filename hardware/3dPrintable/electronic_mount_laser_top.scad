use <std_mechanical_object_flange3.scad>

module outerCasing_top(){
	union(){
		difference(){
			intersection(){
				//outsideBox
				translate([0,0,12.5]) cube(size=[105,60,25],center=true);
				//bevels
				translate([0,0,5]) rotate([45,0,0]) cube(size=[106,60,60],center=true);
			}
			union(){
				//innerBox
				cube(size=[97,42,42],center=true);
				//fanCutout
				translate([-50,0,0]) rotate([0,90,0]) sphere(r=19,center=true);
				//laserOutput
				translate([55,0,0]) rotate([0,90,0]) sphere(r=10,center=true);
			}
			//powerCable
			translate([-27.5,0,20]) rotate([0,0,0]) cylinder(h=12,r=4,center=true);
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
						translate([50, 17, 0]){
							rotate([45,90,0]){
								cylinder(r=4,h=9,center=true);
							}
						}
					}
				}
			}
			translate([50,15.75,15.75]) rotate([0,90,0]) cylinder(r=4,h=7,center=true);	
			translate([50,-15.75,15.75]) rotate([0,90,0]) cylinder(r=4,h=7,center=true);
			for (q=[0:8]){
				translate([(q*100 / 8)-50,0,24]){
					rotate([0,45,45]){
						cube (size=[5,55,7],center=true);
					}
				}
			}
			//screwHoles
			translate([35,-25,10]) cylinder(h=22,r=2,center=true);
			translate([-35,25,10]) cylinder(h=22,r=2,center=true);
			translate([35,25,10]) cylinder(h=22,r=2,center=true);
			translate([-35,-25,10]) cylinder(h=22,r=2,center=true);

			translate([35,-25,15]) cylinder(h=22,r=4,center=true);
			translate([-35,25,15]) cylinder(h=22,r=4,center=true);
			translate([35,25,15]) cylinder(h=22,r=4,center=true);
			translate([-35,-25,15]) cylinder(h=22,r=4,center=true);
			
			//alignmentPeg1
			translate([0,-25,5]) cylinder(h=12,r=2.25,center=true);
		}
		//alignmentPeg2
		translate([0,25,0]) cylinder(h=10,r=2,center=true);
	}
}

module structural_mount_laser_top(){
	union(){
		outerCasing_top();
		difference(){
			translate([50,0,0]){
				flange();
			}
			//bottomHalfCutoff
			translate([55,0,-12.5]){
				cube(size=[20,50,25],center=true);
			}
		}
	}
}

structural_mount_laser_top();