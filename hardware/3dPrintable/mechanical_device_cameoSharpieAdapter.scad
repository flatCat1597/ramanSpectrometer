module body(){
	difference(){
		union(){
			//lowerBody
			cylinder(r=7.25, h= 18, $fn=100, center=true);
			//upperBody
			translate([0,0,25]) cylinder(d=15.5, h= 35, $fn=100, center=true);
			//sideHoleBody
			translate([5,0,15]) rotate([0,90,0]) cylinder(r=4,h=7, $fn=100, center=true);
		}
		//upperInside
		translate([0,0,20]) cylinder(d=12.5, h=50, $fn=100, center=true);
		//baseInside
		translate([0,0,-9]) cylinder(d=8, h=10, $fn=100, center=true);
		//screwHole
		translate([5,0,15]) rotate([0,90,0]) cylinder(r=1.5,h=10, center=true);
	}
}


body();