use <optics_module_testStand.scad>

pi = 3.14159265;	// pi to the 8th
CM_D = 20;		// coolimatingMirror Diameter
CM_EFL = 80;		// collimatingMirror Effective Focal Length
CM_R = 160;		// collimatingMirror Radius
CM_ET = 3.31;		// collimatingMirror Edge Thickness
CM_CT = 3;		// collimatingMirror Center Thickness
CM_Xr = 90;		// collimatingMirror X rotation
CM_Yr = 0;			// collimatingMirror Y rotation
CM_Zr = 20;		// collimatingMirror Z rotation
CM_Xp = 0;		// collimatingMirror X position
CM_Yp = CM_EFL/2;	// collimatingMirror Y position
CM_Zp = 0;		// collimatingMirror Z position

ES_w = .25;		// entranceSlit width
ES_h = 15;			// entranceSlit height
ES_Xr = 0;			// entranceSlit X rotation
ES_Yr = 0;			// entranceSlit Y rotation
ES_Zr = 0;			// entranceSlit Z rotation
ES_Xp = 0;			// entranceSlit X position
ES_Yp = -CM_EFL/2;	// entranceSlit Y position
ES_Zp = 0;			// entranceSlit Z position

DG_H = 25;		// diffractionGrating height
DG_W = 25;		// diffractionGrating width
DG_GD = 1200;		// diffractionGrating Groove Density
DG_T = 9.5;		// diffractionGrating Thickness
DG_1st = -12.03;	// 1st order - based on a 90deg incident, 1200g/mm, 55nm
DG_2nd = 18.6629;	// 2nd order - based on a 90deg incident, 1200g/mm, 55nm
DG_3rd = 78.5217;	// 3rd order - based on a 90deg incident, 1200g/mm, 55nm
DG_Xr = 0;			// diffractionGrating X rotation
DG_Yr = 0;			// diffractionGratingY rotation
DG_Zr = DG_1st;;	// diffractionGrating Z rotation
				// diffractionGrating X position calculated from collimatingMirror angle and distance
DG_Xp = CM_Xp + CM_EFL * cos((CM_Zr*2) - 90);		
				// diffractionGratingY position calculated from collimatingMirror angle and distance
DG_Yp = CM_Yp + CM_EFL * sin((CM_Zr*2) - 90);		
DG_Zp = 0;			// diffractionGrating Z position
DG_AN = DG_Zr + 90;

FM_D = 50;		// focusingMirror Diameter
FM_EFL = 100;		// focusingMirror Effective Focal Length
FM_R = 200;		// focusingMirror Radius
FM_ET = 6;			// focusingMirror Edge Thickness
FM_Xr = 90;		// focusingMirror X rotation
FM_Yr = 0;			// focusingMirror Y rotation
FM_Zr = 100;		// focusingMirror Z rotation
				// focusingMirror X position calculated from diffractionGrating angle and distance
//FM_Xp = DG_Xp + FM_EFL * cos((CM_Zr*2 - DG_Zr*2)+90);	
FM_Xp = DG_Xp + FM_EFL * -cos(DG_Zr );	
				// focusingMirror Y position calculated from diffractionGrating angle and distance
//FM_Yp = DG_Yp + FM_EFL * sin((CM_Zr*2 - DG_Zr*2)+90);// - (FM_D/1.5);			
FM_Yp = DG_Xp + FM_EFL * sin(DG_Zr ) - (FM_D/1.2);	
FM_Zp = 0;			// focusingMirror Z position

DA_Xr = 0;			// detectorArray X rotation
DA_Yr = 0;			// detectorArray Y rotation
DA_Zr = 25;		// detectorArray Z rotation
DA_Xp = 60;			// detectorArray X position
DA_Yp = 40;			// detectorArray Y position
DA_Zp = 0;			// detectorArray Z position

module entranceSlit(){
	translate([ES_Xp,ES_Yp,ES_Zp]) {
		rotate([ES_Xr,ES_Yr,ES_Zr]){
			difference(){
				cube(size=[60,2,80],center=true);
				cube(size=[ES_w,3,ES_h],center=true);
			}
			rotate([0,0,65]){
				translate([-22,26,0]) cube(size=[20,2,80],center=true);
			}
			rotate([0,0,-65]){
				translate([22,26,0]) cube(size=[20,2,80],center=true);
			}
		}
	}
}

module collimatingMirror(){
	translate([CM_Xp,CM_Yp,CM_Zp]){
		rotate([CM_Xr,CM_Yr,CM_Zr]){
			difference(){
				cylinder(d=CM_D,h=CM_ET,$fn=50,center=true);
				translate([0,0,CM_Zp+(CM_R)]) rotate([90,0,90]) color([0,1,1]) sphere(r=CM_R,$fn=100,center=true);
			}
rotate([-90,0,0]){
	translate([0,35,-28]){
		base();
		collimatingMirrorMount();

		cylinder(r=10,h=10,center=true);
		translate([0,0,-8]) cylinder(r=20,h=7,center=true);

	}
}
		}
	}
}

module diffractionGrating(){
	union(){
		translate([DG_Xp,DG_Yp,DG_Zp]){
			rotate([DG_Xr,DG_Yr,(CM_Zr*2)-(90+DG_Zr)]){
				cube(size=[DG_T,DG_W,DG_H],center=true);
				translate([-DG_T/2+.5,10,0]) color([1,0,0]) cube(size=[1.1,5.1,25.1],center=true);
				translate([-DG_T/2+.5,5,0]) color([1,.5,0]) cube(size=[1.1,5,25.1],center=true);
				translate([-DG_T/2+.5,0,0]) color([1,1,0]) cube(size=[1.1,5,25.1],center=true);
				translate([-DG_T/2+.5,-5,0]) color([0,1,0]) cube(size=[1.1,5,25.1],center=true);
				translate([-DG_T/2+.5,-10,0]) color([0,0,1]) cube(size=[1.1,5.1,25.1],center=true);
				rotate([0,0,-90]) translate([0,35,-28]){
					gratingMount();
					base();
					cylinder(r=10,h=10,center=true);
					difference(){
					translate([0,0,-8]) cylinder(r=20,h=7,center=true);
					translate([-12,24,-8]) rotate([0,0,10]) cube(size=[40,20,10],center=true);
}
				}
			}
		}
	}
	echo ((CM_Zr*2)-(90+DG_Zr));
}

module focusingMirror(){
	translate([FM_Xp,FM_Yp,FM_Zp]){
		rotate([FM_Xr,FM_Yr,FM_Zr]){
			difference(){
				cylinder(d=FM_D,h=FM_ET,$fn=50,center=true);
				translate([0,0,FM_Zp+(FM_R)]) rotate([90,0,0]) color([0,1,1]) sphere(r=FM_R,$fn=100,center=true);
			}
			rotate([270,0,0]) translate([0,49,-28]){
				FocusingMirrorMount();
				base();
				cylinder(r=10,h=10,center=true);
				difference(){
				translate([0,0,-8]) cylinder(r=20,h=7,center=true);
					translate([-14,28,-8]) rotate([0,0,49]) cube(size=[40,20,10],center=true);
					translate([23,15,-8]) rotate([0,0,-41]) cube(size=[40,20,10],center=true);
}
			}
		}
	}
}

module detectorArray(){
	translate([DA_Xp,DA_Yp,DA_Zp]){
		rotate([DA_Xr,DA_Yr,DA_Zr]){
			cube(size=[3,41.85,9.7],center=true);
			translate([-1.5,0,0]) color([0,0,0]) cube(size=[1,35,1],center=true);
			rotate([0,0,270]) translate([0,45,-28]){
				detectorMount();
				base();
					cylinder(r=10,h=10,center=true);
					difference(){
					translate([0,0,-8]) cylinder(r=20,h=7,center=true);
					translate([-14,22,-8]) rotate([0,0,35]) cube(size=[40,20,10],center=true);
					}
			}
		}
	}
}


module testStand(){
	difference(){
		translate([20,11,0]) rotate([0,0,-28.5]) {
			difference(){
			cube(size=[200,200,2],center=true);
				translate([0,104,0]) cube (size=[210,10,10],center=true);
				translate([0,-104,0]) cube (size=[210,10,10],center=true);
				translate([104,0,0]) cube (size=[10,210,10],center=true);
				translate([-104,0,0]) cube (size=[10,210,10],center=true);
			}
		}
		translate([0,0,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([17,10,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-17,10,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-0,19,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-0,39,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-17,-9,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([17,-9,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-0,109,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-17,29,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([17,49,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([51,-9,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([85,-9,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([68,-18,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([102,-18,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([34,-18,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([17,-29,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-47,10,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([-34,39,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([51,10,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([85,10,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([68,19,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([34,19,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([51,29,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([51,48,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([34,39,0]) cylinder(r=10,h=4,$fn=6,center=true);
		translate([34,58,0]) cylinder(r=10,h=4,$fn=6,center=true);
	}
}

module spectrometer(){
	entranceSlit();
	collimatingMirror();
	diffractionGrating();
	focusingMirror();
	detectorArray();
}

spectrometer();
translate([-5,0,-40]) testStand();


