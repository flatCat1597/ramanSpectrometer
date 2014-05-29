use <write.scad>
use <filterMount_screwHoles.scad>

module filterMountRetainingBracket(){
	//leftBlock
	difference(){
		translate([40,0,1]){
			color([.7,.9,.1]) cube(size=[10,50,4],center=true);
		}
		//screwHoles
		translate([0,-22.5,0]){
			upperScrewHoles();
		}
		translate([0,22.5,0]){
			lowerScrewHoles();
		}
	}
	//rightBlock
	difference(){
		translate([-40,0,1]){
			color([.7,.9,.1]) cube(size=[10,50,4],center=true);
		}
		//screwHoles
		translate([0,-22.5,0]){
			upperScrewHoles();
		}
		translate([0,22.5,0]){
			lowerScrewHoles();
		}
	}
	//upperBlock
	translate([0,-40,1]){
		color([.7,.9,.1]) cube(size=[50,10,4],center=true);
	}
	//lowerBlock
	translate([0,40,1]){
		color([.7,.9,.1]) cube(size=[50,10,4],center=true);
	}
	//frame
	difference(){
		//mountBody
		color([.7,.9,.1]) cube(size=[90,90,2],center=true);
		//filterHole
		translate([0,0,0]) cylinder(h=7,r=40,$fn=100,center=true);
		//screwHoles
		translate([0,-22.5,0]){
			upperScrewHoles();
		}
		translate([0,22.5,0]){
			lowerScrewHoles();
		}
	}
	rotate(180,0,0){
		translate([0,40,2]){
			write("Meridian",h=4,t=3,center=true);
		}
		translate([0,-40,2]){
			write("Scientific",h=4,t=3,center=true);
		}
	}
}

//filterMountRetainingBracket
rotate([-90,0,0]) translate([0,0,0]){
	filterMountRetainingBracket();
}