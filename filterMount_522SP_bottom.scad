use <write.scad>
use <filterMount_screwHoles.scad>

module 522SP_filterMountBottom(){
	//522SP Filter Mount Bottom
	difference(){
		//mountBody
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//filterBody
		translate([0,-22.5,0]) cube(size=[40,5,3],center=true);
		//filterHole
		translate([0,-22.5,0]) cube(size=[30,4,20],center=true);
		//screwHoles
		lowerScrewHoles();
	}
	rotate([0,0,180]){
		translate([0,-5,4.5]){
			write("522SP Filter",h=4,t=3,center=true);
		}
	}
}

rotate([-90,0,0]) translate([0,0,0]){
	522SP_filterMountBottom();
}