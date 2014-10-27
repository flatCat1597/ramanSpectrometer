use <std_mechanical_lib_rackAndPinion.scad>

module tray(){
	//mainTray
	color([0.2,0.8,0.9]) cube(size=[28,150,2],center=true);
	color([0.2,0.8,0.9]) translate([0,-74,30]) cube(size=[28,3,69],center=true);
	//cuvetteHolder
	difference(){
		intersection(){
			translate([0,-60,11]) cube(size=[25,25,20],center=true);
			translate([0,-60,11]) sphere(r=15,center=true);
		}
		translate([0,-60,15]) cube(size=[14,14,25],center=true);
	}
	intersection(){
		translate([0,-55,5]) cube(size=[28,35,10],center=true);
		translate([0,-55,11]) sphere(r=20,center=true);
	}
	//rackGear
	translate([7.5,15,3.5]){
		rotate([90,180,90]){
				rack(4,30,6.25,2);
		}
	}
	//rackSupport
	color([1,0.4,0]){
	translate([10.65,17.5,2]){
		cube(size=[6.25,115,3],center=true);
	}
	//opticalSensorBlock
	translate([-10,40,6]){
		cube(size=[2,10,12],center=true);
	}
	}
}

module traySupports(){
	color([1,0.4,0]){
	translate([-4.5,-5,-3]){
		cube(size=[2,130,4],center=true);
	}
	translate([4.5,-5,-3]){
		cube(size=[2,130,4],center=true);
	}
	//lower inside rails
	translate([4.25,-5,-4.75]){
		cube(size=[3.5,130,1.5],center=true);
	}
	translate([-4.25,-5,-4.75]){
		cube(size=[3.5,130,1.5],center=true);
	}

	translate([-12,-5,-3]){
		cube(size=[2,130,7.5],center=true);
	}
	translate([12,-5,-3]){
		cube(size=[2,130,7.5],center=true);
	}
	translate([-8,-5,-2]){
		cube(size=[7,130,5],center=true);
	}
	translate([8,-5,-2]){
		cube(size=[7,130,5],center=true);
	}
	}
}

//cuvetteTrayMovement
translate([0,0,0]){
	tray();
	traySupports();
	//cuvette
//	%translate([0,-60,35]) cube(size=[12,12,45],center=true);
}

