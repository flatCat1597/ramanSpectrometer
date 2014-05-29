use <write.scad>

module lcdDisplay(){
	//screenFace
	color([0,.5,.2]) cube(size=[62,33,1],center=true);
	//frame
	difference(){
		translate([0,0,-2]){
			color([.2,.2,.2]) cube(size=[74.5,45,7],center=true);
		}
		color([0,.5,.2]) cube(size=[62,33,5],center=true);
	}
	//pcb1
	difference(){
		translate([0,0,-6]){
			color([0,.3,.2]) cube(size=[75,52.5,1],center=true);
		}
		//screwHoles
		translate([36,25,-6]){
			cylinder(r=1,h=10,$fn=25,center=true);
		}
		translate([-36,25,-6]){
			cylinder(r=1,h=10,$fn=25,center=true);
		}
	}
	//pcb2
	translate([0,12,-10]){
		color([1,0,0]) cube(size=[51,28,1],center=true);
	}
	//connector
	translate([27,12,-12]){
		color([.2,.2,.2]) cube(size=[20,10,2],center=true);
	}
	rotate([180,180,0]){
		translate([-16.5,13,0]){
			write("Meridian",h=4,t=3,center=true);
		}
		translate([-14,7,0]){
			write("Scientific",h=4,t=3,center=true);
		}
	}
}

lcdDisplay();