module laserEmitter(){
	difference(){
		//mainFrame
		color ([0.2,0.2,0.2]) cube(size=[95,40,40],center=true);
		//laserOpening
		translate([45,0,0]){
			rotate([0,90,0]){
				color([0.2,0.4,0.2]) cylinder(r=11.5,h=10,$fn=24,center=true);
			}
		}
		//fanCutout
		translate([-50,0,0]){
			rotate([0,90,0]){
				color([0.3,0.3,0.3]) cylinder(r=19,h=10,$fn=24,center=true);
			}
		}
	}
	//fanCenter
	translate([-45,0,0]){
		rotate([0,90,0]){
			color([0.2,0.2,0.2]) cylinder(r=11.5,h=5,$fn=24,center=true);
		}
	}
	//lens
	translate([38,0,0]){
		rotate([0,90,0]){
			color([0,1,0]) cylinder(r=2.875,h=5,$fn=24,center=true);
		}
	}
	//powerCable
	translate([-27.5,0,20]){
		rotate([0,0,0]){
			color ([0.2,0.2,0.2]) cylinder(r=3,h=20,$fn=16,center=true);
		}
	}
}

laserEmitter();