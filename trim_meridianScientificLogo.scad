use <write.scad>
use <mechanical_rackAndPinion.scad>

module base(){
	translate([0,0,0]) {
		color([0.5,0.9,0.0]) cube(size=[80,30,2],center=true);
		translate([0,0,2]){
			difference(){
				color([0.5,0.9,0.0]) cube(size=[80,30,2],center=true);
				color([0.5,0.9,0.0]) cube(size=[76,26,3],center=true);
			}
		}
	}
}

module meridianScientific(){
	translate([12,5,1]){
		color([0.9,0.5,0.0]) write("Meridian",h=8,t=3,center=true);
	}
	translate([6.5,-5,1]){
		color([0.9,0.5,0.0]) write("Scientific",h=8,t=3,center=true);
	}
}

module gearLogo(){
	translate([-30,10,0]){
		color([.6,.7,.2]) pinion(4,20,6.25,5);
	}
}


base();
meridianScientific();
gearLogo();