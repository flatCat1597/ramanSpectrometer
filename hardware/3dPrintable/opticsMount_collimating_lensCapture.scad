use <opticsMount_retainingBracket.scad>

module collimatingLens(){
	intersection(){
		translate([22,0,20]){
			color([0.3,0.4,0.6]) sphere(r=11.5,$fn=50);
		}
		translate([34,0,20]){
			color([0.3,0.4,0.6]) sphere(r=11.5,$fn=50);
		}
	}
}

module collimatingLensHole(){
	intersection(){
		translate([-7.25,0,0]){
			sphere(r=12,$fn=50);
		}
		translate([5.25,0,0]){
			sphere(r=12,$fn=50);
		}
	}
}

module lensCapture(){
	difference(){
		translate([0,0,0]){
			cube(size=[2,21.5,21.5],center=true);
		}
		collimatingLensHole();
	}
	translate([0.5,-12,12]){
		rotate([-45,0,0]){
			difference(){
				cube(size=[1,14,5],center=true);
				translate([0,-3.5,0]){
					rotate([0,90,0]){
						cylinder(r=1.5,h=2,$fn=16,center=true);
					}
				}
			}
		}
	}
	translate([0.5,12,12]){
		rotate([45,0,0]){
			difference(){
				cube(size=[1,14,5],center=true);
				translate([0,3.5,0]){
					rotate([0,90,0]){
						cylinder(r=1.5,h=2,$fn=16,center=true);
					}
				}
			}
		}
	}
	translate([0.5,12,-12]){
		rotate([-45,0,0]){
			difference(){
			cube(size=[1,14,5],center=true);
				translate([0,3.5,0]){
					rotate([0,90,0]){
						cylinder(r=1.5,h=2,$fn=16,center=true);
					}
				}
			}
		}
	}
	translate([0.5,-12,-12]){
		rotate([45,0,0]){
			difference(){
			cube(size=[1,14,5],center=true);
				translate([0,-3.5,0]){
					rotate([0,90,0]){
						cylinder(r=1.5,h=2,$fn=16,center=true);
					}
				}
			}
		}
	}
}

module collimatingLensMount(){
	translate([-1.25,0,20]){
		rotate([0,0,180]){
			retainingBracket();
		}
	}
	
}


module captureAssembly(){
	translate([-2,0,0]){
		rotate([0,0,180]){
			lensCapture();
		}
	}
	translate([-29,0,-20]){
		collimatingLens();
	}
	translate([0,0,-20]){
		collimatingLensMount();
	}
}
lensCapture();
