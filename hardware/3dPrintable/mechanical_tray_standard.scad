module mainTray(){
	//tray
	color([0.4,0.8,0]) cube(size=[140,102,1.25],center=true);
	//walls
	translate([6.5,-52,5.5]){
		color([0.4,0.8,0]) cube(size=[73,2,10],center=true);
	}
	translate([6.5,52,5.5]){
		color([0.4,0.8,0]) cube(size=[73,2,10],center=true);
	}
	//wallSupports
	translate([30,-50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([30,50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([-20,-50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
	translate([-20,50,3]){
		color([0.4,0.8,0]) cube(size=[20,5,5],center=true);
	}
}

mainTray();