use <mechanical_rackAndPinion.scad>

module cuvetteHolderTray_half2(){
	//mainBody
	translate([50,0,0]) color([.3,.55,.95]) cube(size=[150,38,2],center=true);
	//roundEnd
	translate([-40,0,0]) color([.3,.55,.95]) cylinder(h=2,r=9.25,center=true);
	//rectangleSupport
	translate([-28,0,0]) color([.3,.55,.95]) cube(size=[20,9.5,2],center=true);
	//rails
	difference(){
		translate([75,20,-3]) color([.3,.55,.95]) cube(size=[100,2,8],center=true);
		translate([25,20,-10]) color([.3,.35,.95]) cube(size=[50,4,10],center=true);
	}
	difference(){
		translate([75,-20,-4]) color([.3,.55,.95]) cube(size=[100,2,10],center=true);
		translate([25,-20,-10]) color([.3,.35,.95]) cube(size=[50,4,10],center=true);
	}
	//crossBar
	translate([120,0,-2.5]) color([.3,.55,.95]) cube(size=[5,40,7],center=true);
	translate([0,3,-2]){
		rotate([90,0,0]){
			rack(4,50,6.25,2);
		}
	}
}

translate([0,0,10]){
	cuvetteHolderTray_half2();
}