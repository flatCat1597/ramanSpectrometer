module upperScrewHoles(){
	//upperMiddleHalf
	translate([40,12,0]) cylinder(h=30,r=2,center=true);
	translate([-40,12,0]) cylinder(h=30,r=2,center=true);
	//upperHalf
	translate([35,-12,0]) cylinder(h=30,r=2,center=true);
	translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
}

module lowerScrewHoles(){
	//lowerMiddleHalf
	translate([40,-12,0]) cylinder(h=30,r=2,center=true);
	translate([-40,-12,0]) cylinder(h=30,r=2,center=true);
	//bottomwHalf
	translate([35,12,0]) cylinder(h=30,r=2,center=true);
	translate([-35,12,0]) cylinder(h=30,r=2,center=true);
}

upperScrewHoles();
lowerScrewHoles();