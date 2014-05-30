use <arrow.scad>
use <filterMount_screwHoles.scad>

module interferenceFilterMountTop(){
	//arrow
	translate([44,5,0]){
		rotate([0,0,0]){
			resize(newsize=[4,15,20]){
				arrow();
			}
		}
	}
	//laserLine
	translate([45,-10,-11]) color([0,1,1]) cube(size=[.5,.5,23]);
	//laserBall
	translate([45,-9.75,-7]) color([0,1,1]) sphere(r=1.5,$fs=.5);
	//laserEffect
	translate([45,-13.25,-10.75]) rotate([45,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);
	translate([45,-13.25,-3.75]) rotate([-45,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);
	translate([45,-14.75,-7]) rotate([0,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);

	//Interference Filter Mount Top
	difference(){
		//mountBody
		color([.6,.1,.6]) cube(size=[90,45,25],center=true);
		//filterBody
		translate([0,22.25,-2.5]) cylinder(h=16,r=32.5,$fn=100,center=true);
		//filterScrewMount
		translate([0,22.5,6.5]) cylinder(h=6,r=26.5,$fn=100,center=true);
		//filterHole
		translate([0,22.5,0]) cylinder(h=30,r=20,$fn=100,center=true);
		//screwHoles
		upperScrewHoles();
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,$fn=50,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,$fn=50,center=true);
	}
}

//interferenceMountTop
rotate([90,0,0]) translate([0,0,0]){
	interferenceFilterMountTop();
}
