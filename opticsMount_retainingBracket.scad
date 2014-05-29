use <write.scad>

module retainingBracket(){
	difference(){	
		translate([0,0,0]) color([.7,.9,.2]) cube(size=[2,38,38],center=true);
		translate([0,0,0]) cube(size=[6,22,22],center=true);
		rotate([0,90,0]){
			translate([14.5,14.5,0]) cylinder(h=5,r=1.5,$fn=8,center=true);			
			translate([14.5,-14.5,0]) cylinder(h=5,r=1.5,$fn=8,center=true);			
			translate([-14.5,14.5,0]) cylinder(h=5,r=1.5,$fn=8,center=true);			
			translate([-14.5,-14.5,0]) cylinder(h=5,r=1.5,$fn=8,center=true);		
		}
	}
	rotate([90,0,-90]){
		translate([0,15,1]){
			write("Meridian",h=3,t=2,center=true);
		}
	}
	rotate([90,0,-90]){
		translate([0,-15,1]){
			write("Scientific",h=3,t=2,center=true);
		}
	}
	difference(){
		translate([-1,0,0]) cube(size=[2,30,.5],center=true);	
		translate([0,0,0]) cube(size=[6,22,22],center=true);
	}
	difference(){
		translate([-1,0,0]) cube(size=[2,.5,25],center=true);	
		translate([0,0,0]) cube(size=[6,22,22],center=true);
	}
}

retainingBracket();