module bearing(){
	difference(){
		rotate([90,0,0]) cylinder(r=11,h=7,$fn=50,center=true);
		color([0.5,0.5,0.5]) rotate([90,0,0]) cylinder(r=9.5,h=8,$fn=50,center=true);		
	}		
	difference(){
		rotate([90,0,0]) cylinder(r=10,h=6.5,$fn=50,center=true);
		color([0.5,0.5,0.5]) rotate([90,0,0]) cylinder(r=3.9,h=8,$fn=50,center=true);
	}
	difference(){
		rotate([90,0,0]) cylinder(r=4.5,h=7,$fn=50,center=true);
		color([0.5,0.5,0.5]) rotate([90,0,0]) cylinder(r=3.9,h=8,$fn=50,center=true);
	}
}

bearing();