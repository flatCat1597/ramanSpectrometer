module slideStepper(driveBlockPos){
	driveBlockPos= driveBlockPos - 25;
	rotate([0,90,0]){
		translate([0,0,-32]){
			//motor
			color([0.7,0.7,0.9]) cylinder(r=7.5,h=10,$fn=50,center=true);
		}
		translate([0,0,10]){
			//shaft
			color([0.6,0.6,0.9]) cylinder(r=1.5,h=74,$fn=50,center=true);
		}
	}
	//basePlate
	translate([9,4,-5]){
		cube(size=[78,8,1],center=true);
	}
	translate([-22,0,-5]){
		cube(size=[15,15,1],center=true);
	}
	translate([driveBlockPos,0,0]){
		//driveBlock
		color([0.9,0.9,0.7]) cube(size=[12,16,5],center=true);
		//driveBlockScrews
		translate([-3,5,0]){
			cylinder(r=1.5,h=10,center=true);
		}
		translate([3,5,0]){
			cylinder(r=1.5,h=10,center=true);
		}
		translate([0,-5,0]){
			rotate([90,0,0]){
				cylinder(r=1.5,h=10,center=true);
			}
		}
	}	
}

slideStepper(20);