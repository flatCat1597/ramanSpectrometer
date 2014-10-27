//base
difference(){
	translate([0,0,-12.5]) cube(size=[60,60,2],center=true);
	translate([-26,-25,-12]) cylinder(r=2, h=5, center=true);
	translate([26,-25,-12]) cylinder(r=2, h=5, center=true);
	translate([-26,25,-12]) cylinder(r=2, h=5, center=true);
	translate([26,25,-12]) cylinder(r=2, h=5, center=true);
}
//box
difference(){
	cube(size=[44,56,27],center=true);
	translate([0,0,3]) cube(size=[40,52,26],center=true);
	translate([0,27,-4]) cube(size=[30,4,7],center=true);
}

