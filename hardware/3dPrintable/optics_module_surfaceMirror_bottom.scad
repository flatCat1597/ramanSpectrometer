use <std_mechanical_object_flange3.scad>

module mirror(){
	translate ([1.75,1.75,0]) rotate([0,90,45]) cylinder(r=13,h=5,$fn=100,center=true);
}

module mirrorSphere_bottom(){
	union(){
	difference(){
		//mainBody
		intersection(){
			cube(size=[30,30,30],center=true);
			sphere(r=21,center=true);
		}
		//laserPath
		translate([-10,0,0]) cube(size=[20,20,20],center=true);
		translate([0,-10,0]) cube(size=[20,20,20],center=true);
		//mirrorSlot
		translate ([1.75,1.75,0]) rotate([0,90,45]) cylinder(r=14.5,h=6,$fn=100,center=true);
		//screwHoles
		translate([2,12.5,0]) cylinder(r=1.25,h=10,center=true);
		translate([12.5,2,0]) cylinder(r=1.25,h=10,center=true);
	}
	}
	//cornerScrewHole
	difference(){
		translate([-15,-15,0]) cube(size=[10,10,7],center=true);
		translate([-15,-15,0]) cylinder(r=1.25,h=8,center=true);
	}
			//flange
			rotate([0,180,0]){ 
				translate([7,0,0]){
					difference(){
						flange();
						cube(size=[6,24,24],center=true);
					}
				}
			}
			//flange
			rotate([0,0,270]){
				translate([7,0,0]){
					difference(){
						 flange();
						cube(size=[6,25,24],center=true);
					}
				}
			}
}

module mirror_mount_bottom(){
	difference(){
		mirrorSphere_bottom();
		//topChop
		translate([0,0,11]) cube(size=[50,50,22],center=true);
	}
}

//mirror();
mirror_mount_bottom();
//translate([-3.5,0,0]) cube(size=[35,1,1],center=true);
