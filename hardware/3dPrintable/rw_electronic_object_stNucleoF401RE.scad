module st_nucleo_F401RE(){
	difference(){
		cube(size=[79.46,70,1.5],center=true);
		translate([-5,24.13,0]){
			cylinder(r=1.5,h=5,$fn=10,center=true);
		}
		translate([-5,-24.13,0]){
			cylinder(r=1.5,h=5,$fn=10,center=true);
		}
		translate([40,8.89,0]){
			cylinder(r=1.5,h=5,$fn=10,center=true);
		}
	}
	difference(){
		translate([41,-2.425,0]){
			cube(size=[3.04,33,1.5],center=true);
		}
		translate([40,8.89,0]){
			cylinder(r=1.5,h=5,$fn=10,center=true);
		}
	}
	
}

st_nucleo_F401RE();