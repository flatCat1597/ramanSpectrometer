use <mechanical_rackAndPinion.scad>

module cuvetteHolderTray_half1(){
	//mainBody
	difference(){
		translate([-75,0,0]) color([.3,.55,.95]) cube(size=[100,38,2],center=true);
		//roundInset
		translate([-40,0,0]) color([.3,.55,.95]) cylinder(h=4,r=10,center=true);
		//rectangleInset
		translate([-28,0,0]) color([.3,.55,.95]) cube(size=[20,10,4],center=true);
	}
	//rails
	translate([-50,20,-3]) color([.3,.35,.95]) cube(size=[150,2,8],center=true);
	difference(){
		translate([-50,-20,-4]) color([.3,.35,.95]) cube(size=[150,2,10],center=true);
		translate([-50,-20,-4]) cube(size=[8,4,4],center=true);
	}
	difference(){
		//upperExtension
		translate([25,20,-4]) color([.3,.35,.95]) cube(size=[50,2,6],center=true);
		//lowerNotch
		translate([25,20,0]) color([.3,.35,.95]) cube(size=[50,4,10],center=true);
	}
	difference(){
		translate([25,-20,-4]) color([.3,.35,.95]) cube(size=[50,2,10],center=true);	
		translate([25,-20,0]) color([.3,.35,.95]) cube(size=[50,4,10],center=true);
	}
}

translate([0,0,0]){
	cuvetteHolderTray_half1();
}