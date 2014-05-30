use <write.scad>

module 532nmPassFilterBottom(){
	difference(){
		//lensHolderBottom
		translate([0,0,0]) color([0.8,1,.6]) cube(size=[7,30,10],center=true);	
		//lensHolderIndentation
		translate([0,0,5]) color([01,1,.6]) cube(size=[1.5,11,11],center=true);	
		//lensHole
		translate([0,0,5]) color([01,1,.6]) cube(size=[20,5,5],center=true);	
		//screwHoles
		translate([0,10,5]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([0,-10,5]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
	//base
	translate([0,0,-9]) color([0.8,1,.6]) cube(size=[8,40,8],center=true);	
	difference(){
		translate([0,0,-14]) color([0.8,1,.6]) cube(size=[20,50,2],center=true);	
		//screwHoles
		translate([7,22,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([7,-22,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-7,22,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-7,-22,-14]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
	rotate([90,0,90]){
		translate([0,-9,4]){
//			write("532nmPassFilter",h=3,t=3,center=true);
		}
	}
}
translate([0,0,0]){
	532nmPassFilterBottom();
}
