CM_X = 0;			// collimatingMirror X rotation
CM_Y = 0;			// collimatingMirror Y rotation
CM_Z = 20;		// collimatingMirror Z rotation
ES_w = .25;		// entranceSlit width
DG_X = 0;			// diffractionGrating X rotation
DG_Y = 0;			// diffractionGratingY rotation
DG_Z = -50;		// diffractionGrating Z rotation
FM_X= 0;			// focusingMirror X rotation
FM_Y= 0;			// focusingMirror Y rotation
FM_Z= 102;		// focusingMirror Z rotation
DA_X= 0;			// detectorArray X rotation
DA_Y= 0;			// detectorArray Y rotation
DA_Z= 20;			// detectorArray Z rotation

module entranceSlit(){
	difference(){
		translate([0,-40,0]) cube(size=[40,2,40],center=true);
		translate([0,-40,0]) cube(size=[ES_w,3,23],center=true);
	}
}
module beam(){
	translate([0,-52,0]) rotate([90,0,0]) color([0,1,0]) cylinder(r=.5,h=25,$fn=50,center=true);
	translate([0,0,0]) color([0,1,0]) cube(size=[.25,80,2],center=true);
	translate([0,40,0]) color([0,1,0]) rotate([0,0,(CM_Z + CM_Z) + 180]) cube(size=[.25,80,2]);
	translate([51.5,-21.5,0]) color([1,1,0]) rotate([0,0,(DG_Z + DG_Z) + 180]) cube(size=[.25,100,2]);
	translate([-47,-4,0]) color([1,1,0]) rotate([0,0,(FM_Z + FM_Z) +90]) cube(size=[.25,100,2]);
}

module collimatingMirror(){
	difference(){
		rotate([90,0,0]) cylinder(r=10,h=5,$fn=100,center=true);
		translate([0,-40,0]) color([0,1,1]) sphere(r=40,$fn=100,center=true);
	}
}

module diffractionGrating(){
		cube(size=[5,25,25],center=true);
		translate([-2.1,10,0]) color([1,0,0]) cube(size=[1,5,25],center=true);
		translate([-2.1,5,0]) color([1,.5,0]) cube(size=[1,5,25],center=true);
		translate([-2.1,0,0]) color([1,1,0]) cube(size=[1,5,25],center=true);
		translate([-2.1,-5,0]) color([0,1,0]) cube(size=[1,5,25],center=true);
		translate([-2.1,-10,0]) color([0,0,1]) cube(size=[1,5,25],center=true);
}

module focusingMirror(){
	difference(){
		rotate([90,0,0]) cylinder(r=25,h=6,$fn=100,center=true);
		translate([0,-100,0]) color([0,1,1]) sphere(r=100,$fn=100,center=true);
	}
}

module detectorArray(){
	cube(size=[3,41.85,9.7],center=true);
	translate([-1.5,0,0]) color([0,0,0]) cube(size=[1,35,1],center=true);
}

module spectrometer(){
	beam();
	entranceSlit();
	translate([0,40,0]) {
		rotate([CM_X,CM_Y,CM_Z]) {
			collimatingMirror();
		}
	}
	translate([53,-23,0]){
		rotate([DG_X,DG_Y,DG_Z]){
			diffractionGrating();
		}
	}
	translate([-47,-10,0]){				// center would be 4...ofset to correct and spead linear spectra
		rotate([FM_X,FM_Y,FM_Z]){
			focusingMirror();
		}
	}
	translate([52,21,0]){
		rotate([DA_X,DA_Y,DA_Z]){
			detectorArray();
		}
	}
}

spectrometer();