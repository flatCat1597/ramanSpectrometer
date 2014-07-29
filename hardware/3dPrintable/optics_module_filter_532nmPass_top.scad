use <std_mechanical_object_flange3.scad>

module passFilter(){
	translate ([0,0,0]) rotate([0,90,0]) color([0,.5,0]) cylinder(r=13,h=5,$fn=100,center=true);
}

module passFilterBody(){
	union(){
		difference(){
			//mainBody
			intersection(){
				cube(size=[10,32,32],center=true);
				sphere(r=18,center=true);
			}
			//laserPath
			intersection(){
				cube(size=[40,20,20],center=true);
				rotate([0,90,0]) cylinder(r=12,h=45,center=true);
			}
		}
		//screwHoles
		translate([0,17,0]) cylinder(r=5,h=10,center=true);
		translate([0,-17,0]) cylinder(r=5,h=10,center=true);
	}
			//flange
			rotate([0,180,0]){ 
				translate([0,0,0]){
					difference(){
						flange();
						cube(size=[6,24,24],center=true);
					}
				}
			}
			//flange
			rotate([0,0,0]){
				translate([0,0,0]){
					difference(){
						 flange();
						cube(size=[6,25,24],center=true);
					}
				}
			}
}

module passFilter_mount_top(){
	difference(){
		passFilterBody();
		//filterSlot
		translate ([0,0,0]) rotate([0,90,0]) cylinder(r=14,h=6,$fn=100,center=true);
		//screwHoles
		translate([0,17,-5]) cylinder(r=1.5,h=14,center=true);
		translate([0,-17,-5]) cylinder(r=1.5,h=14,center=true);

		translate([0,17,8]) cylinder(r=3,h=14,center=true);
		translate([0,-17,8]) cylinder(r=3,h=14,center=true);
		//bottomChop
		translate([0,0,-11]) cube(size=[50,50,22],center=true);
	}
}

//passFilter();
passFilter_mount_top();
