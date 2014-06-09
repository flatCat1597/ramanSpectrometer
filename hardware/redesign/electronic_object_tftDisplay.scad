use <write.scad>

module screen(){
	//frame
	color([1,1,1]) cube(size=[55.25,39.75,2.75],center=true);
	//front
	translate([0,0,.5]){
		color([.25,.25,.25]) cube(size=[55,39,2],center=true);
	}
	difference(){
		//pcb
		translate([0,0,-2.25]){
			color([1,0,0]) cube(size=[67.59,40,1.75],center=true);
		}
		//mountingHoles
		translate([-31.6,17.6,-2]){
			cylinder(r=1.6,h=2.5,$fn=16,center=true);
		}
		translate([-31.6,-17.6,-2]){
			cylinder(r=1.6,h=2.5,$fn=16,center=true);
		}
		translate([31.6,17.6,-2]){
			cylinder(r=1.6,h=2.5,$fn=16,center=true);
		}
		translate([31.6,-17.6,-2]){
			cylinder(r=1.6,h=2.5,$fn=16,center=true);
		}
	}
	//connector
	translate([32,0,-12]){
		color([.2,.2,.2]) cube(size=[2.7,23,17.5],center=true);
	}
	//sdCard
	translate([-10,-11,-4.75]){
		cube(size=[27.5,17,3.15],center=true);
	}
	rotate([0,0,0]){
		translate([-10,13,.1]){
			write("meridian",h=4,t=3,center=true);
		}
		translate([-4,7,.1]){
			write("Scientific",h=4,t=3,center=true);
		}
	}
}



screen();
