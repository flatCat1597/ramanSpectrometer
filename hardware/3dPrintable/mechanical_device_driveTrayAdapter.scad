module mainBox(){
	union(){
	difference(){
		//mainBox
		color([0.2,0.8,0.2]) cube(size=[41.3,170,146.1,],center=true);
		//hollowBox
		translate([6,0,0]) color([0.2,0.2,0.2])cube(size=[49,166,142],center=true);
		//frontDoorHole
		translate([0,-85,-30]) cube(size=[30,7,70],center=true);
		//flangeHoles
		translate([-20,52.5,-20]) cube(size=[5,10,35],center=true);
		translate([-20,-39,-22]) cube(size=[5,10,18],center=true);
		//objectiveMountScrewBodyHole
		translate([0,82,-30]) cube(size=[30,10,50],center=true);
	}
	//wallMounts
	translate([-14,23,-9]) wallMount();
	translate([-14,-27,-5]) wallMount();
	translate([-14,23,-35])  rotate([180,0,0]) wallMount();
	translate([-14,-27,-39]) rotate([180,0,0]) wallMount();
	}
}

module trayGuide(){
	//trayGuide	
	union(){
		color([0.5,0.25,0.75]) translate([0,-4,-68]) cube(size=[30,130,6],center=true);
		translate([0,-4,-62.75]) cube(size=[2,130,5],center=true);
		translate([0,-4,-60]) cube(size=[5,130,2],center=true);
	}
}

module motorMount(){
	difference(){
		translate([17.5,-10,-60]) cube(size=[5,45,25],center=true);
		translate([17.5,-10,-51]) rotate([0,90,0]) cylinder(r=14.25,h=12,center=true);
		translate([15,-10,-50]) cube(size=[3,42.5,9.5],center=true);
		translate([15,-27,-51]) rotate([0,90,0]) cylinder(r=1.5,h=12,center=true);
		translate([15,7,-51]) rotate([0,90,0]) cylinder(r=1.5,h=12,center=true);
		translate([20,-10,-65]) 	cube(size=[11,18,4],center=true);
	}
}

module wallMount(){
	difference(){
		rotate([0,90,180]) screwHoleOuter();
		rotate([0,90,180]) screwHoleInner2();
		translate([4,0,-4]) cube(size=[10,10,3],center=true);
//		translate([-7,0,0]) cube(size=[5,10,10],center=true);
	}
}

module screwHoleOuter(){
	cylinder(r=5,h=13,center=true);
}

module screwHoleInner2(){
	translate([0,0,5]) cylinder(r=1.5,h=25,center=true);
}

union(){
	mainBox();
	trayGuide();
	motorMount();
}