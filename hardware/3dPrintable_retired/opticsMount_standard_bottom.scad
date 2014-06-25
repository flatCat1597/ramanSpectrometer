module opticsMount_standard_base(){
	//base
	difference(){
		//baseBlock
		translate([0,0,]) color([.4,.2,.9]) cube(size=[50,50,2],center=true);
		//baseScrewholes
		translate([20,20,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([20,-20,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,20,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,-20,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);

		translate([15.5,0,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-15.5,0,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
	translate([0,0,5]) cylinder(h=9,r=5.75,$fn=100,center=true);		
	rotate([0,0,19]){
		for ( i = [0 : 36] ){
			rotate( i * 360 / 30, [0,0, 90])
				translate([9,19, 1])
				sphere(r = 2,$fn=2);
		}
	}
}

translate([0,0,0]){
	opticsMount_standard_base();
}