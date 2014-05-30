use <write.scad>

module collimatingLensMountBottom(){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,12,69],center=true);
		//lensHole
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=8,r=11.5,$fn=100,center=true);
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=14,r=10,$fn=100,center=true);
		//screwHoles
		translate([-18,0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([18,-0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
	difference(){
		//base
		translate([0,0,-34]) color([.6,.2,.9]) cube(size=[70,30,2],center=true);
		//baseScrewholes
		translate([30,10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([30,-10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,-10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
	rotate([90,0,180]){
		translate([0,-11,6]){
			write("Collimating",h=5,t=3,center=true);
		}
	}
	rotate([90,0,180]){
		translate([0,-18,6]){
			write("Lens",h=5,t=3,center=true);
		}
	}
}

translate([0,0,0]){
	collimatingLensMountBottom();
}
