use <write.scad>
use <filterMount_screwHoles.scad>

module 550LP_filterMountBottom(){
	//550LP Filter Mount Bottom
	difference(){
		//mountBody
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//filterBody
		translate([0,-22.5,0]) cylinder(h=3.5,r=4,center=true);
		//filterHole
		translate([0,-22.5,0]) cylinder(h=30,r=3,center=true);
		//screwHoles
		lowerScrewHoles();
	}
	rotate(180,0,0){
		translate([0,-5,5]){
			write("550LP Filter",h=4,t=3,center=true);
		}
	}
}

rotate([-90,0,0]) {
	translate([0,0,0]){
		550LP_filterMountBottom();
	}
}