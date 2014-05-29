use <write.scad>

module opticsMount_standard_top(text1,text2){
	rotate([0,0,angle]){
		difference(){
			//mainBody
			difference(){
				translate([0,0,0]) color([.4,.2,.9]) cube(size=[5,40,96],center=true);
				//baseMountShaft
				translate([0,0,-45]) cylinder(h=10,r=6,$fn=100,center=true);		
			}
			//lensHole
//			translate([-2,0,20]) cube(size=[6,25,25],center=true);
			//screwHoles
			rotate([0,90,0]){
				translate([-5.5,14.5,0]) cylinder(h=15,r=1.5,$fn=8,center=true);			
				translate([-5.5,-14.5,0]) cylinder(h=15,r=1.5,$fn=8,center=true);			
				translate([-34.5,14.5,0]) cylinder(h=15,r=1.5,$fn=8,center=true);			
				translate([-34.5,-14.5,0]) cylinder(h=15,r=1.5,$fn=8,center=true);		
			}
		}
	}
	//adjuster
	difference(){
		translate([0,0,-47]) {
			//baseSphereWithShaft
			difference(){
				color([.4,.2,.9]) sphere(r=12.5,$fn=100);
				translate([0,0,-12.5]) cube(size=[30,30,25],center=true);
			}
			//baseRingWithSlots
			difference(){
				//baseRing
				translate([0,0,0]) color([.4,.2,.9]) cylinder(h=2,r=20,$fn=100,center=true);
				//slots
				difference(){
					translate([0,0,0]) cylinder(h=4,r=17,$fn=100,center=true);
					translate([0,0,0]) cylinder(h=5,r=14,$fn=100,center=true);
					translate([0,0,0]) cube(size=[15,40,4],center=true);
				}
			}
		}
		//centerShaft
		translate([0,0,-45]) cylinder(h=10,r=6,$fn=100,center=true);		
	}
	//indexTabs
	translate([20,0,-46]) color([.4,.2,.9]) sphere(r =2,$fn=3);
	translate([-20,0,-46]) color([.4,.2,.9]) rotate([0,0,60]) sphere(r =2,$fn=3);
	//text
	rotate([90,0,-90]){
		translate([0,-11,2]){
			color([.9,.2,.3]) write(text1,h=5,t=3,center=true);
		}
	}
	rotate([90,0,-90]){
		translate([0,-18,2]){
			color([.9,.2,.3]) write(text2,h=5,t=3,center=true);
		}
	}
}

translate([0,0,0]){
	opticsMount_standard_top("Standard","Mount");
}
