use <std_mechanical_object_flange3.scad>

module base(){
	difference(){
		union(){
			cube(size=[50,40,4],center=true);
			translate([0,0,-2]) cylinder(r=22,h=4,$fn=50,center=true);
			translate([0,-20,23]) cube(size=[50,4,50],center=true);
			translate([16,-20,0]) cube(size=[4,15,25]);
			translate([-20,-20,0]) cube(size=[4,15,25]);
		}
		cylinder(r=10.5,h=9,$fn=50,center=true);

		translate([0,-20,8]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
		translate([20,-20,42]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
		translate([-20,-20,42]) rotate([90,0,0]) cylinder(r=3,h=6,$fn=50,center=true);	
	}
}

module collimatingMirrorMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([0,-33,28]) rotate([90,0,0]) color([0.5,0.7,0.2]) cylinder(r=11,h=5,$fn=50,center=true);
	}
}

module FocusingMirrorMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
	}
	translate([0,-40,23]) cube(size=[20,10,20],center=true);
	difference(){
		translate([0,-45,28]) cube(size=[60,10,60],center=true);
		translate([0,-48,28]) rotate([90,0,0]) color([0.5,0.7,0.2]) cylinder(r=26,h=5,$fn=50,center=true);
		translate([0,-45,8]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
		translate([20,-45,42]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
		translate([-20,-45,42]) rotate([90,0,0]) cylinder(r=8,h=12,$fn=50,center=true);	
	}
}

module gratingMount(){
	difference(){
		translate([0,-30,23]) cube(size=[50,10,50],center=true);
		translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
		translate([0,-33,28]) cube(size=[26,5,26],center=true);
	}
}

module detectorMount(){
	union(){
		difference(){
			translate([0,-30,24]) cube(size=[60,10,53],center=true);
			translate([2,-30,45]) cube(size=[20,15,20],center=true);
			translate([0,-30,8]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
			translate([20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
			translate([-20,-30,42]) rotate([90,0,0]) cylinder(r=3,h=12,$fn=50,center=true);	
			translate([0,-36,8]) rotate([90,0,0]) cylinder(r=7.5,h=12,$fn=50,center=true);	
			translate([20,-36,42]) rotate([90,0,0]) cylinder(r=7.5,h=12,$fn=50,center=true);	
			translate([-20,-36,42]) rotate([90,0,0]) cylinder(r=7.5,h=12,$fn=50,center=true);	
		}
		difference(){
			union(){
				translate([-32,-33.5,25]) rotate([90,0,0]) color([0.5,0.7,0.2]) cube(size=[5,50,3],center=true);
				translate([32,-33.5,25]) rotate([90,0,0]) color([0.5,0.7,0.2]) cube(size=[5,50,3],center=true);	
				translate([0,-33.5,-1.5]) rotate([90,0,0]) color([0.5,0.7,0.2]) cube(size=[75,3,17],center=true);	
				translate([-36,-37,24.5]) rotate([90,0,0]) color([0.5,0.7,0.2]) cube(size=[3,53,10],center=true);
				translate([36,-37,24.5]) rotate([90,0,0]) color([0.5,0.7,0.2]) cube(size=[3,53,10],center=true);
			}
			translate([0,-38.5,25]) rotate([90,0,0]) color([1,0.4,0.2]) cube(size=[72,52.3,2.5],center=true);
		}
	}
}

module lightMountRear(){
	difference(){
		union(){
			cube(size=[50,40,4],center=true);
			translate([0,0,-2]) cylinder(r=22,h=4,$fn=50,center=true);
			difference(){
				translate([0,-20,10.5]) cube(size=[50,10,25],center=true);
				translate([0,-20,22.5]) rotate([90,0,0]) cylinder(r=11.5,h=12,$fn=50,center=true);
				translate([18,-20,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
		}
		cylinder(r=10.5,h=9,$fn=50,center=true);
	}
	translate([-18,-20,24.5]) cube(size=[5,5,5],center=true);
}

module lightMountFront(){
	difference(){
		translate([0,19,20]) cube(size=[50,2,40],center=true);
		translate([0,19,20]) cube(size=[5,3,30],center=true);
		translate([9.25,20,19.5]) rotate([90,0,0]) cylinder(r=1.5,h=5,$fn=50,center=true);
		translate([-9.25,20,19.5]) rotate([90,0,0]) cylinder(r=1.5,h=5,$fn=50,center=true);
	}
	translate([20,12,12]) cube(size=[4,15,25],center=true);
	translate([-20,12,12]) cube(size=[4,15,25],center=true);
	difference(){
		union(){
			cube(size=[50,40,4],center=true);
			difference(){
				translate([0,0,-2]) cylinder(r=22,h=4,$fn=50,center=true);
				translate([0,22,-2]) cube(size=[20,4,5],center=true);
			}
			difference(){
				translate([0,-20,10.5]) cube(size=[50,10,25],center=true);
				translate([0,-20,22.5]) rotate([90,0,0]) cylinder(r=11.5,h=12,$fn=50,center=true);
				translate([18,-20,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
		}
		cylinder(r=10.5,h=9,$fn=50,center=true);
	}
	translate([-18,-20,24.5]) cube(size=[5,5,5],center=true);
}

module lightMountFrontWithLens(){
	difference(){
		translate([0,50,25]) cube(size=[50,2,50],center=true);
		translate([0,50,25]) cube(size=[5,3,30],center=true);
		translate([9.25,50,25]) rotate([90,0,0]) cylinder(r=1.5,h=5,$fn=50,center=true);
		translate([-9.25,50,25]) rotate([90,0,0]) cylinder(r=1.5,h=5,$fn=50,center=true);
	}
	translate([20,42,12]) cube(size=[4,15,25],center=true);
	translate([-20,42,12]) cube(size=[4,15,25],center=true);
	difference(){
		union(){
			translate([0,0,0]) cube(size=[50,102,4],center=true);
			difference(){
				translate([0,0,-2]) cylinder(r=22,h=4,$fn=50,center=true);
				translate([0,22,-2]) cube(size=[20,4,5],center=true);
			}
			difference(){
				translate([0,-50,10.5]) cube(size=[50,10,25],center=true);
				translate([0,-50,22.5]) rotate([90,0,0]) cylinder(r=11.5,h=12,$fn=50,center=true);
				translate([18,-50,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
		}
		cylinder(r=10.5,h=9,$fn=50,center=true);
	}
	translate([-18,-50,24.5]) cube(size=[5,5,5],center=true);
	translate([-18,-0,24.5]) cube(size=[5,5,5],center=true);
			difference(){
				translate([0,0,10.5]) cube(size=[50,10,25],center=true);
		cylinder(r=10.5,h=9,$fn=50,center=true);
				union(){
					translate([0,0,22.5]) rotate([90,0,0]) cylinder(r=11,h=12,$fn=50,center=true);
					translate([0,0,22.5]) rotate([90,0,0]) cylinder(r=13,h=4,$fn=50,center=true);
				}
				translate([18,0,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
}

module lightMountTop(){
		translate([0,-20,0]){
			difference(){
				translate([0,-20,10.5]) cube(size=[50,10,25],center=true);
				translate([0,-20,22.5]) rotate([90,0,0]) cylinder(r=11.5,h=12,$fn=50,center=true);
				translate([18,-20,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
			translate([-18,-20,24.5]) cube(size=[5,5,5],center=true);
		}
}

module lightMountTopLens(){
		translate([0,0,0]){
			difference(){
				translate([0,0,10.5]) cube(size=[50,10,25],center=true);
				union(){
					translate([0,0,22.5]) rotate([90,0,0]) cylinder(r=11,h=12,$fn=50,center=true);
					translate([0,0,22.5]) rotate([90,0,0]) cylinder(r=13,h=4,$fn=50,center=true);
				}
				translate([18,0,21.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
			translate([-18,0,24.5]) cube(size=[5,5,5],center=true);
		}
}

module rotator(){
	translate([0,0,-10]) cube(size=[80,10,4],center=true);
	translate([-5,-10,-10]) rotate([0,0,50]) cube(size=[110,10,4],center=true);
	translate([5,-10,-10]) rotate([0,0,-50]) cube(size=[110,10,4],center=true);
	translate([0,0,-5]) cylinder(r=10,h=12,$fn=50,center=true);
	translate([0,0,-10]) cylinder(r=30,h=4,$fn=50,center=true);
}

module laserStand(){
	translate([0,50,25]) rotate([0,0,90]) flange();
	difference(){
		translate([0,50,25]) cube(size=[50,2,50],center=true);
		translate([0,50,25]) cube(size=[15,3,15],center=true);
translate([5.5,50,39]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([-5.5,50,39]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([5.5,50,12]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([-5.5,50,12]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([14,50,19.5]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([14,50,31]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([-14,50,19.5]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);
translate([-14,50,31]) rotate([90,0,0]) cylinder(r=4,h=5,center=true);

	}
	difference(){
		union(){
			translate([23,42,12]) cube(size=[4,15,25],center=true);
			translate([-23,42,12]) cube(size=[4,15,25],center=true);
		}
		translate([0,44.8,28]) rotate([90,0,0]) cylinder(d=57,h=9,center=true);
	}
	difference(){
		union(){
			translate([0,-2,0]) cube(size=[50,106,2],center=true);
			translate([0,-30,-2]) cylinder(r=22,h=4,$fn=50,center=true);
			translate([0,27,-2]) cylinder(r=22,h=4,$fn=50,center=true);
			translate([0,27,-3]) cube(size=[80,10,2],center=true);
			translate([0,-30,-3]) cube(size=[80,10,2],center=true);
			difference(){
				translate([0,-50,12.5]) cube(size=[50,10,25],center=true);
				translate([0,-50,24.5]) rotate([90,0,0]) cylinder(r=12,h=12,$fn=50,center=true);
				translate([18,-50,22.5]) cube(size=[5.5,5.5,5.5],center=true);
			}
		}
	}
	translate([-18,-50,24.5]) cube(size=[5,5,5],center=true);
	translate([-18,-0,24.5]) cube(size=[5,5,5],center=true);
		difference(){
			translate([0,0,12.5]) cube(size=[50,10,25],center=true);		
			translate([0,0,24.5]) rotate([90,0,0]) cylinder(r=12,h=12,$fn=50,center=true);
			translate([18,0,22.5]) cube(size=[5.5,5.5,5.5],center=true);
		}	
	difference(){
		translate([0,31,16]) cube(size=[20,20,40],center=true);
		translate([0,31,30]) rotate([0,0,90]) cylinder(r=8,h=30,center=true);
		translate([0,31,25]) rotate([0,90,90]) cylinder(r=3,h=30,$fn=100,center=true);

	}
}

laserStand();
//base();
//rotator();
//lightMountFront();
//lightMountFrontWithLens();
//lightMountRear();
//translate([0,20,60]) rotate([180,0,180]) lightMountTop();
//translate([0,0,60]) rotate([180,0,180]) lightMountTopLens();
//collimatingMirrorMount();
//FocusingMirrorMount();
//gratingMount();
//detectorMount();