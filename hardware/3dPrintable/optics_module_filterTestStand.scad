module base(){
	difference(){
		union(){
			cube(size=[50,40,4],center=true);
			translate([0,0,-2]) cylinder(r=22,h=4,$fn=50,center=true);
			translate([0,-20,23]) cube(size=[50,4,50],center=true);
			translate([16,-20,0]) cube(size=[4,15,25]);
			translate([-20,-20,0]) cube(size=[4,15,25]);
		}
		cylinder(r=10.5,h=9,$fn=50,center=true);

		translate([0,-20,8]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
		translate([20,-20,42]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
		translate([-20,-20,42]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
	}
}

module collimatingMirrorMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([0,-33,28]) rotate([90,0,0]) color([0.5,0.7,0.2]) cylinder(r=11,h=5,$fn=50,center=true);
	}
}

module FocusingMirrorMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
	}
	translate([0,-40,23]) cube(size=[20,10,20],center=true);
	difference(){
		translate([0,-45,28]) cube(size=[60,10,60],center=true);
		translate([0,-48,28]) rotate([90,0,0]) color([0.5,0.7,0.2]) cylinder(r=26,h=5,$fn=50,center=true);
		translate([0,-45,8]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
		translate([20,-45,42]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
		translate([-20,-45,42]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
	}
}

module gratingMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-34,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([0,-33,28]) cube(size=[26,5,26],center=true);
	}
}

module detectorMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([0,-33,28]) rotate([90,0,0]) color([0.5,0.7,0.2]) cylinder(r=11,h=5,$fn=50,center=true);
	}
}

module rotator(){
	translate([0,0,-10]) cube(size=[80,10,4],center=true);
	translate([-5,-10,-10]) rotate([0,0,50]) cube(size=[110,10,4],center=true);
	translate([5,-10,-10]) rotate([0,0,-50]) cube(size=[110,10,4],center=true);
	translate([0,0,-5]) cylinder(r=10,h=12,$fn=50,center=true);
	translate([0,0,-10]) cylinder(r=30,h=4,$fn=50,center=true);
}

base();
rotator();
//collimatingMirrorMount();
FocusingMirrorMount();
//gratingMount();
//detectorMount();