module arrow(){
	//arrowBody
	translate([0,-1,0]) color([0,1,1]) cube(size=[2.5,2,5]);
	//arrowHead
	translate([0,0,-1]) color([0,1,1]) rotate([0,90,0]) cylinder(h=2.5,r=3,$fn=3);
}

arrow();