//  Just to note.. This is completely a scratchpad.. There are a TON of errors in calculations here...
//  This is just to test ideas on moving the objects using their position and angle.. I'll adapt this to a
//  design that actually calculates the ray paths when I get better with openSCAD

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
DA_Zr = 15;		// detectorArray Z rotation
DA_Xp = 0;			// detectorArray X position
DA_Yp = 0;			// detectorArray Y position
DA_Zp = 0;			// detectorArray Z position

// This module does not work because apparently openSCAD does not allow variables to be reassigned...
module plotRay(xA, yA, xB, yB){
	dx = xB - xA;
	dy = yB - yA;
	D = (2 * dy) - dx;
	translate([xA, yA, 0]) color([0.1,0.5,0.9]) sphere(r=2);
	y = yA;
	for(x = [xA+1:xB]){
		if (D+(2*dy-2*dx) > 0) {
//			y = y + 1
			translate([x, xB-x, 0]) color([0.1,0.5,0.9]) sphere(r=2);
//			D = D + (2 * dy - 2 * dx)
		} else {
			translate([x, y, 0]) color([0.1,0.5,0.9]) sphere(r=2);
//			D = D + (2 * dy);
		}
	}
}

module entranceSlit(){
	translate([ES_Xp,ES_Yp,ES_Zp]) {
		rotate([ES_Xr,ES_Yr,ES_Zr]){
			difference(){
				cube(size=[20,2,20],center=true);
				cube(size=[ES_w,3,ES_h],center=true);
			}
		}
	}
}

module entranceBeam(){
	//beamEnters
	translate([ES_Xp,ES_Yp - 12,ES_Zp]){
		 rotate([ES_Xr +90,ES_Yr,ES_Zr]) {
			color([0,1,0]) cylinder(r=2,h=25,$fn=50,center=true);	
		}
	}
	//beamExits
	translate([0,0,0]){
		rotate([ES_Xr,ES_Yr,ES_Zr]){
			color([0,1,0]) cube(size=[ES_w,CM_EFL,2],center=true);
		}
	}
}

module eBeam(){
	for (i=[0:CM_EFL]){
		translate([ES_Xp,ES_Yp + i,ES_Zp]){
			color([0.1,0.5,0.9]) sphere(r=.25);
		}
	}
//	plotRay(ES_Xp, ES_Yp, CM_Xp, CM_Yp);
}
//eBeam();

module collimatingMirror(){
	translate([CM_Xp,CM_Yp,CM_Zp]){
		rotate([CM_Xr,CM_Yr,CM_Zr]){
			difference(){
				cylinder(d=CM_D,h=CM_ET,$fn=50,center=true);
				translate([0,0,CM_Zp+(CM_R)]) rotate([90,0,90]) color([0,1,1]) sphere(r=CM_R,$fn=100,center=true);
			}
		}
	}
}

module cm2dg_Beam(){
	translate([CM_Xp,CM_Yp,CM_Zp]){
		//mirrorNormal
		rotate([CM_Xr-90,CM_Yr,CM_Zr]){
			 translate([0,-CM_Yp/2,0]) color([0,.5,.5]) cube(size=[.25,CM_EFL,.25],center=true);
		}
/*		//mirrorFocalPoint
		
		rotate([0,0,(CM_Zr*2) - 180]) {
			 translate([0,CM_Yp,0]) color([0,1,0]) cube(size=[ES_w,CM_EFL,2],center=true);
		}
		rotate([0,0,(CM_Zr*2) - 180]) {
			 translate([10,CM_Yp,0]) color([0,1,0]) cube(size=[ES_w,CM_EFL,2],center=true);
		}
		rotate([0,0,(CM_Zr*2) - 180]) {
			 translate([-10,CM_Yp,0]) color([0,1,0]) cube(size=[ES_w,CM_EFL,2],center=true);
		}
*/	}
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
			}
		}
	}
	echo ((CM_Zr*2)-(90+DG_Zr));
}

module dg2fm_Beam(){
	translate([DG_Xp,DG_Yp,DG_Zp]){
		//normal
		rotate([0,0,CM_Zr*2-DG_Zr]){
			translate([0,0,0]) color([0,.5,.5]) cube(size=[.25,FM_EFL,.25]);
		}
/*		//beta
		rotate([0,0,CM_Zr*2-DG_Zr*2]){
//			translate([0,0,-1]) color([0,1,0]) cube(size=[.5,FM_EFL,2]);
		}
		//1st order
		rotate([0,0,DG_Zr+90]){
			translate([0,0,-1]){
				color([0,1,0]) cube(size=[ES_w,FM_EFL,2]);
			}
		}
		//1st order
		rotate([0,0,DG_Zr+90]){
			translate([-10,0,0]){
				color([0,0,1]) cube(size=[ES_w,FM_EFL,2]);
			}
		}
		//1st order
		rotate([0,0,DG_Zr+90]){
			translate([12,0,0]){
				color([1,0,0]) cube(size=[ES_w,FM_EFL,2]);
			}
		}
*/	}
}

module focusingMirror(){
	translate([FM_Xp,FM_Yp,FM_Zp]){
		rotate([FM_Xr,FM_Yr,FM_Zr]){
			difference(){
				cylinder(d=FM_D,h=FM_ET,$fn=50,center=true);
				translate([0,0,FM_Zp+(FM_R)]) rotate([90,0,0]) color([0,1,1]) sphere(r=FM_R,$fn=100,center=true);
			}
		}
	}
}

module fm2da_Beam(){
	translate([FM_Xp,FM_Yp,FM_Zp]){
		rotate([0,0,(FM_Zr + FM_Zr) +90]){
			color([0,0,1]) cube(size=[ES_w,FM_EFL,2]);
			translate([-10,0,0]) color([0,1,0]) cube(size=[ES_w,FM_EFL,2]);
			translate([-22,0,0]) color([1,0,0]) cube(size=[ES_w,FM_EFL,2]);
		}
	}
}

module detectorArray(){
	translate([DA_Xp,DA_Yp,DA_Zp]){
		rotate([DA_Xr,DA_Yr,DA_Zr]){
			cube(size=[3,41.85,9.7],center=true);
			translate([-1.5,0,0]) color([0,0,0]) cube(size=[1,35,1],center=true);
		}
	}
}

module spectrometer(){
	entranceSlit();
	//entranceBeam();
	collimatingMirror();
	cm2dg_Beam();
	diffractionGrating();
	dg2fm_Beam();
	focusingMirror();
	//fm2da_Beam();
	//detectorArray();
}

deltaY = DG_Yp - CM_Yp;
deltaX = DG_Xp - CM_Xp;
angleInDegrees = atan2(deltaY, deltaX) * 180 / pi;
echo(angleInDegrees);

//animate
function saw(t) = 1 - 2*abs(t-0.5);    
rotate([0,0,saw($t)*360,0])  spectrometer();
//spectrometer();