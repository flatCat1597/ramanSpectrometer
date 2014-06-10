use <std_mechanical_object_flange.scad>
use <trim_lib_write.scad>

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
			for (q=[0:8]){
				translate([(q*100 / 8)-50,0,-24]){
					rotate([0,45,-45]){
						cube (size=[5,55,7],center=true);
					}
				}
			}
			//screwHoles
			translate([35,-25,-4]) cylinder(h=10,r=1.75,center=true);
			translate([-35,25,-4]) cylinder(h=10,r=1.75,center=true);
			translate([35,25,-4]) cylinder(h=10,r=1.75,center=true);
			translate([-35,-25,-4]) cylinder(h=10,r=1.75,center=true);
			//alignmentPeg1
			translate([0,25,-4]) cylinder(h=10,r=3,center=true);
		}
		//alignmentPeg2
		translate([0,-25,0]) cylinder(h=10,r=2,center=true);
		translate([-10,-30,-10]) rotate([90,0,0]) color([0,1,0]) write("meridianScientific",h=6,t=3,center=true);	
	}
}


module structural_mount_laser_bottom(){
	union(){
		outerCasing_bottom();
		difference(){
			translate([50,0,0]){
				flange();
			}
				//topHalfCutoff
			translate([55,0,12.5]){
				cube(size=[20,50,25],center=true);
			}
		}
	}
}

//translate([6,0,7]) color([1,0,0])cube(size=[116,1,1],center=true);
structural_mount_laser_bottom();
