module photoInterrupter(){
	difference(){
		color([.2,.2,.2]) cube(size=[15.2,18.6,4],center=true);
		translate([-3,0,0]) cube(size=[15.2,10,5],center=true);
	}
	//pins
	translate([9.5,-7.6,-1.27])  rotate([0,90,0]) color([.8,.7,.2]) cylinder(r=0.45,h=4,center=true);
	translate([9.5,-7.6,1.27])  rotate([0,90,0]) color([.8,.7,.2]) cylinder(r=0.45,h=4,center=true);

	translate([9.5,7.6,-1.27])  rotate([0,90,0]) color([.8,.7,.2]) cylinder(r=0.45,h=4,center=true);
	translate([9.5,7.6,1.27])  rotate([0,90,0]) color([.8,.7,.2]) cylinder(r=0.45,h=4,center=true);
	//centerPost
	translate([8,0,0]) rotate([0,90,0]) cylinder(r=0.3,h-0.7,center=true);
}


photoInterrupter();