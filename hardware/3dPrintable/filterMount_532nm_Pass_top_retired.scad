module 532nmPassFilterTop(){
	difference(){
		//filterHolderTop
		translate([0,0,0]) color([0.8,1,.6]) cube(size=[7,30,10],center=true);	
		//filterHolderIndentation
		translate([0,0,-5]) color([01,1,.6]) cube(size=[1.5,11,11],center=true);	
		//filterHole
		translate([0,0,-5]) color([01,1,.6]) cube(size=[20,5,5],center=true);
		//screwHoles
		translate([0,10,0]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([0,-10,0]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
}
translate([0,0,0]){
	532nmPassFilterTop();
}
