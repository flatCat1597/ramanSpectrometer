module trim_tftFacePlate_facia(){
	difference(){
		//mainBox
		translate([0,0,17]){
//			color([0.6,0.8,0.2]) cube(size=[150.56,42.88,2],center=true);
			color([0.6,0.8,0.2]) cube(size=[147.56,46.88,2],center=true);
		}
		//displayHole
		translate([25.5,0,16.75]){
			color([0.2,0.8,0.2]) cube(size=[56,40.5,5],center=true);
		}
		//keyPadHole
		translate([-36,0,16.75]){
			color([0.2,0.8,0.2]) cube(size=[46,36,5],center=true);
		}
	}
	//topAndBottomTrim
	difference(){
		translate([0,-20.35,12]){
			color([.3,.5,.2]) cube(size=[146.1,2,10],center=true);
		}
		translate([25,-17.5,10]){
			color([.3,.1,.2]) cube(size=[74,6,17],center=true);
		}
	}
	difference(){
		translate([0,20.35,12]){
			color([.3,.5,.2]) cube(size=[146.1,2,10],center=true);
		}
		translate([25,17.5,10]){
			color([.3,.1,.2]) cube(size=[74,6,17],center=true);
		}
	}
	//sideTrim
	translate([-72,0,12]){
		color([.3,.5,.2]) cube(size=[2,41.3,10],center=true);
	}	
	translate([72,0,12]){
		color([.3,.5,.2]) cube(size=[2,41.3,10],center=true);
	}	
	difference(){
		//screwBlocks
		translate([-65,12,11]){
			cylinder(r=5,h=12,center=true);
		}
		//screwHoles
		translate([-65,12,11]){
			cylinder(r=1.75,h=15,center=true);
		}
	}
	difference(){
		translate([-65,-12,11]){
			cylinder(r=5,h=12,center=true);
		}
		translate([-65,-12,11]){
			cylinder(r=1.75,h=15,center=true);
		}
	}
	difference(){
		translate([65,10,11]){
			cylinder(r=5,h=12,center=true);
		}
		translate([65,10,11]){
			cylinder(r=1.75,h=15,center=true);
		}
	}
	difference(){
		translate([65,-10,11]){
			cylinder(r=5,h=12,center=true);
		}
		translate([65,-10,11]){
			cylinder(r=1.75,h=15,center=true);
		}
	}
}

trim_tftFacePlate_facia();