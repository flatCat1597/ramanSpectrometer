use <mechanical_object_9gServo.scad>
use <mechanical_object_flange_standard.scad>

module mainFrame(){
	difference(){
		translate([0,0,0]) sphere(r=22.75,center=true);
		//topIndentation
		intersection(){
			translate([0,0,12]) cube(size=[25,25,2],center=true);
			translate([0,0,13]) cylinder(r1=20,r2=9,h=40,center=true);
		}
		//bottomIndentation
		intersection(){
			translate([0,0,-12]) cube(size=[25,25,2],center=true);
			translate([0,0,-13]) cylinder(r1=20,r2=9,h=40,center=true);
		}
		//servoNeck
		rotate([90,0,0]) translate([5.5,0,-11]) cylinder(r=6.5, h=5, $fn=20, center=true);
		//deflectionIndicator
		translate([0,0,10]) cylinder(r=5,h=5,center=true);
		//
		translate([0,0,-22]) cube(size=[40,40,20],center=true);
		translate([0,0,22]) cube(size=[40,40,20],center=true);
		translate([0,0,0]) cube(size=[60,18,18],center=true);
		translate([0,0,0]) cube(size=[18,60,18],center=true);
		translate([-20,0,0]) cube(size=[5,18,30],center=true);
		translate([20,0,0]) cube(size=[5,18,30],center=true);
		translate([0,-20,0]) cube(size=[18,5,30],center=true);
		translate([0,20,0]) cube(size=[18,5,30],center=true);
		//servoHole
		translate([0,18,0]) cube(size=[25,10,15],center=true);
	}
	translate([-14.5,16.25,0]) cube(size=[5,5,12],center=true);
	translate([14.5,16.25,0]) cube(size=[5,5,12],center=true);
	//bottomNodule
	translate([0,0,-12]) cylinder(r=5,h=1,center=true);
}

//translate([0,0,20]) cube(size=[48,1,1],center=true);

module laserShutter_Module(){
	union(){
		mainFrame();
		translate([10,0,0]){
			flange();
			flangeFace();
		}
		translate([-10,0,0]){
			rotate([0,180,0]) flange();
			rotate([0,180,0]) flangeFace();
		}
	}
}

//translate([0,25,0]) rotate([90,0,0]) 9g_motor();

module laserShutter_Bottom(){
	difference(){
		laserShutter_Module();
		//topChop
		translate([0,0,25]) cube(size=[50,50,50],center=true);
		//screwHoles
		translate([-12.5,-12.5,-4]) cylinder(r=1.25,h=10,center=true);
		translate([12.5,-12.5,-4]) cylinder(r=1.25,h=10,center=true);
		translate([15.5,12.5,-4]) cylinder(r=1.25,h=10,center=true);
		translate([-15.5,12.5,-4]) cylinder(r=1.25,h=10,center=true);
	}
}

laserShutter_Bottom();