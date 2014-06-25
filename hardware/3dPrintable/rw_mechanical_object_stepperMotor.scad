module mechanical_StepperMotor(){
	//mainBody
	translate([0,0,]) rotate([0,90,90]) cylinder(r=14,h=19.28,$fn=50,center=true);
	//shaftCollar
	translate([0,10,8]) rotate([0,90,90]) cylinder(r=5,h=2,$fn=50,center=true);
	//shaft
	translate([0,12,8]) rotate([0,90,90]) color([.9,.8,.0]) cylinder(r=2.5,h=9,$fn=50,center=true);
	//wireBlock
	translate([0,0,-14]) color([.0,.5,.9]) cube(size=[15,17,3],center=true);
	//mountingBracket
	difference(){
		//bracketTabs
		translate([0,9.125,0]) cube(size=[42,1,7],center=true);
		//screwHoles
		translate([17,10,0]) rotate([0,90,90]) cylinder(r=1.9,h=4,$fn=50,center=true);
		translate([-17,10,0]) rotate([0,90,90]) cylinder(r=1.9,h=4,$fn=50,center=true);
	}
}

translate([0,0,0]){
	mechanical_StepperMotor();
}