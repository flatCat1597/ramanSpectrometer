use <../opticsMount_verticalAperture_top.scad>
use <../opticsMount_standard_bottom.scad>
use <../opticsMount_retainingBracket.scad>
use <../opticsMount_verticalAperture_bracket_05.scad>
use <../opticsMount_collimating_lensCapture.scad>

translate([0,0,0]){
	opticsMount_verticalAperture_top(.25);
}
translate([0,0,-49]){
	opticsMount_standard_base();
}

translate([-3,0,20]){
	retainingBracket();
}

translate([3,0,20]){
	rotate([0,0,180]){
		retainingBracket();
		aperture();
	}
}

translate([-27,0,20]){
	rotate([0,0,0]){
		lensCapture();
	}
}
translate([-29,0,20]){
	rotate([0,0,180]){
		lensCapture();
	}
}
translate([-28,0,20]){
	rotate([0,0,0]){
		retainingBracket();
	}
}


	//captureAssemblyMountScrews(doesn't look like it makes sense unless I show these)
	translate([-12,14.5,35]){
		rotate([0,90,0]){
			cylinder(r=1.5,h=45,center=true);
		}
	}
	translate([-12,-14.5,35]){
		rotate([0,90,0]){
			cylinder(r=1.5,h=45,center=true);
		}
	}
	translate([-12,14.5,5.5]){
		rotate([0,90,0]){
			cylinder(r=1.5,h=45,center=true);
		}
	}
	translate([-12,-14.5,5.5]){
		rotate([0,90,0]){
			cylinder(r=1.5,h=45,center=true);
		}
	}

translate([-56,0,0]){
	collimatingLens();
}
collimatingLensMount();