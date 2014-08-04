module centerHubFront(){
		//centerHubFront
	difference(){
		union(){
			translate([0,2.5,0]) rotate ([90,0,0]) cylinder(r=10,h=5,center=true);
			translate([0,5.5,0]) rotate ([90,0,0]) cylinder(r=3.75,h=13,$fn=50,center=true);
		}
		//screwHoles
		translate([0,4,6.5]) rotate ([90,0,0]) cylinder(r=2,h=3,$fn=50,center=true);
			translate([0,1,6.5]) rotate ([90,0,0]) cylinder(r=1.5,h=4,$fn=50,center=true);
		translate([0,4,-6.5]) rotate ([90,0,0]) cylinder(r=2,h=3,$fn=50,,center=true);
			translate([0,1,-6.5]) rotate ([90,0,0]) cylinder(r=1.5,h=4,$fn=50,center=true);
		translate([-6.5,4,0]) rotate ([90,0,0]) cylinder(r=2,h=3,$fn=50,,center=true);
			translate([-6.5,1,0]) rotate ([90,0,0]) cylinder(r=1.5,h=4,$fn=50,center=true);
		translate([6.5,4,0]) rotate ([90,0,0]) cylinder(r=2,h=3,$fn=50,,center=true);
			translate([6.5,1,0]) rotate ([90,0,0]) cylinder(r=1.5,h=4,$fn=50,center=true);
	}
}

centerHubFront();