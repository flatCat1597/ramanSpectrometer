use <std_mechanical_object_flange3.scad>
use <std_trim_lib_write.scad>

//  This design is experimental
//  I am using this to work out the correct geometry and the best mounting methods for the optics
//  This design will probably change drastically in the final version from what you see here

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

ES_w = .1;		// entranceSlit width
ES_h = 3;			// entranceSlit height
ES_md = 25;		// entranceSlit Mount Diameter
ES_mt = 1.25;		// entranceSlit Mount Thickness
ES_Xr = 90;		// entranceSlit X rotation
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
DG_2nd = -18.6629;	// 2nd order - based on a 90deg incident, 1200g/mm, 55nm
DG_3rd = 78.5217;	// 3rd order - based on a 90deg incident, 1200g/mm, 55nm
DG_Xr = 0;			// diffractionGrating X rotation
DG_Yr = 0;			// diffractionGratingY rotation
DG_Zr = DG_1st;		// diffractionGrating Z rotation
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
DA_Zr = 20;		// detectorArray Z rotation
DA_Xp = 0;			// detectorArray X position
DA_Yp = 0;			// detectorArray Y position
DA_Zp = 0;			// detectorArray Z position

module entranceSlit(){
	translate([ES_Xp,ES_Yp-(ES_mt/2),ES_Zp]) {
		rotate([ES_Xr,ES_Yr,ES_Zr]){
			difference(){
				color("grey") cylinder(d=ES_md,h=ES_mt,$fn=50,center=true);
				color("white") translate([0,0,.5]) cylinder(r=2,h=1,$fn=50,center=true);
				cube(size=[ES_w,ES_h,5],center=true);
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
			}
		}
	}
//	echo ((CM_Zr*2)-(90+DG_Zr));
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

module detectorArray(){
	translate([DA_Xp,DA_Yp,DA_Zp]){
		rotate([DA_Xr,DA_Yr,DA_Zr]){
			color("brown")  cube(size=[3,41.85,9.7],center=true);
			translate([-1.5,0,0]) color([0,0,0]) cube(size=[1,35,1],center=true);
		}
	}
}

module accessCover(){
	intersection(){
		translate([0,0,20]) sphere(r=29.65,center=true);
		translate([0,0,28]) cube(size=[50,50,5],center=true);
	}
	translate([0,0,27]) color("lightgrey") cylinder(r=29,h=2,center=true);
	translate([0,0,30]) {
		rotate([0,90,0]){
			for ( i = [0 : 7] ){
				intersection(){
					difference(){
					rotate( i * 360 / 8, [1, 0, 0]) translate([0,0,28]) cube(size=[1,10,20],center=true);
					rotate( i * 360 / 8, [1, 0, 0]) translate([0,0,34]) rotate([0,90,0]) cylinder(r=2,h=10,center=true);
					rotate( i * 360 / 8, [1, 0, 0]) translate([0,0,34]) rotate([0,90,0]) translate([0,0,4]) cylinder(r=4,h=10,center=true);
					}
					rotate( i * 360 / 8, [1, 0, 0]) translate([0,0,28]) sphere(r=10,center=true);
				}
			}
		}
	}
	difference(){
		translate([0,0,28.5]) color("lightgrey") cylinder(r=38.5,h=2,center=true);
		translate([0,0,30]) {
			rotate([0,90,0]){
				for ( i = [0 : 7] ){
					rotate( i * 360 / 8, [1, 0, 0]) translate([0,0,34]) rotate([0,90,0]) cylinder(r=2.5,h=10);
				}
			}
		}
	}
		translate([0,2,30]) rotate([0,0,0]) color("red") write("mSci",h=15,t=3,center=true);	
}

module lowerBox(){
	intersection(){
		translate([0,0,25]) cylinder(r=40,h=5,center=true);
		translate([0,0,4]) sphere(r=45,$fn=50,center=true);
	}
	intersection(){
		translate([0,0,-26.5]) color("grey") cylinder(r=55,h=2.5,center=true);
		translate([0,0,0]) color("grey") sphere(r=45,$fn=55,center=true);
	}
	difference(){
		translate([DG_Xp,DG_Yp,DG_Zp-0]) cylinder(r=18,h=40,center=true);
		translate([DG_Xp,DG_Yp,DG_Zp-0]) cylinder(r=16,h=39,center=true);
		translate([DG_Xp-10,DG_Yp+5,DG_Zp-0]) rotate([0,0,-38]) cube(size=[15,33,DG_H],center=true);
	}
	translate([DG_Xp,DG_Yp,DG_Zp-18]) cylinder(r=12,h=4,center=true);


	difference(){
		translate([-15.5,39.5,-4]) rotate([90,0,022]) cylinder(r=4,h=3,center=true);
		translate([-15.5,39.5,-4]) rotate([90,0,022]) cylinder(r=1.5,h=4,center=true);
	}
	difference(){
		translate([18,50.5,-4]) rotate([90,0,0]) cylinder(r=4,h=3,center=true);
		translate([18,50.5,-4]) rotate([90,0,022]) cylinder(r=1.5,h=4,center=true);
	}
	difference(){
		translate([0.5,44,-19]) rotate([70,0,022]) cylinder(r=4,h=5,center=true);
		translate([0.5,42,-18]) rotate([70,0,022]) cylinder(r=1.5,h=5,center=true);
	}

	difference(){
		translate([-33,-34,-22]) rotate([-30,0,0]) cylinder(r=5,h=5,center=true);
		translate([-33,-34,-22]) rotate([-30,0,0]) cylinder(r=2,h=6,center=true);
	}
	difference(){
		translate([-50,21,-18]) rotate([6,52,0]) cylinder(r=5,h=7,center=true);
		translate([-50,21,-18]) rotate([6,52,0]) cylinder(r=2,h=8,center=true);
	}

//	translate([CM_Xp-14,CM_Yp-16,CM_Zp-13]) rotate([0,0,CM_Zr]) cube(size=[10,5,25],center=true);

	difference(){
		difference(){
		hull($fn=152){
			//rearFocusingMirrorSpacer
			intersection(){
				translate([FM_Xp,FM_Yp,FM_Zp]) rotate([FM_Xr,FM_Yr,FM_Zr])cylinder(r=28,h=10,$fn=50,center=true);
				translate([FM_Xp,FM_Yp,FM_Zp]) rotate([FM_Xr,FM_Yr,FM_Zr-90]) cube(size=[10,55,40],center=true);
			}
			//outerSphericalRounding
			intersection(){
				color("lightgrey") translate([5,5.5,0]) cube(size=[130,92,50],center=true);
				color("lightgrey") resize(newsize=[160,140,58]) sphere(r=20,$fn=152);  
			}
//			FM_Mount();
			translate([DG_Xp,DG_Yp,DG_Zp-0]) cylinder(r=18,h=40,center=true);
		}
			color("lightgrey"){


			translate([71,23,0]) rotate([DA_Xr,DA_Yr,DA_Zr]) cube(size=[25,80,50],center=true);
//			translate([65,-40,0]) rotate([DG_Xr,DG_Yr,DG_Zr-25]) cube(size=[20,50,50],center=true);
			translate([71,-40,0]) rotate([DG_Xr,DG_Yr,DG_Zr-25]) cube(size=[20,50,50],center=true);
			translate([-64,-14,0]) rotate([FM_Xr+90,FM_Yr,FM_Zr]) cube(size=[70,20,70],center=true);
			translate([-28,52,0]) rotate([CM_Xr+90,CM_Yr,CM_Zr]) cube(size=[80,30,50],center=true);
//			translate([0,0,2]) FM_Mount();
	translate([DG_Xp,DG_Yp,DG_Zp-0]) cylinder(r=16,h=40,center=true);
			}

			translate([-15.5,39.5,-4]) rotate([90,0,022]) cylinder(r=1.5,h=4,center=true);
			translate([18,50.5,-4]) rotate([90,0,022]) cylinder(r=1.5,h=4,center=true);
			translate([0.5,42,-18]) rotate([70,0,022]) cylinder(r=1.5,h=12,center=true);

			translate([-33,-34,-22]) rotate([-30,0,0]) cylinder(r=2,h=6,center=true);
			translate([-50,21,-18]) rotate([6,52,0]) cylinder(r=2,h=8,center=true);
			translate([DA_Xp+15,DA_Yp-15,DA_Zp]) {
					rotate([0,0,DA_Zr]) translate([52,21,0]) cube (size=[5,50,15],center=true);
			}
		}

			//CCDmountPointScrewHoles
			translate([67,-5,-10]) rotate([0,90,20]) cylinder(r=2,h=10,center=true);
			translate([67,-5,10]) rotate([0,90,20]) cylinder(r=2,h=10,center=true);
			translate([47,49.5,-10]) rotate([0,90,20]) cylinder(r=2,h=15,center=true);
			translate([47,49.5,10]) rotate([0,90,20]) cylinder(r=2,h=15,center=true);

			//flangeFaceScrewHoles
			translate([-14,-40,-5.5]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([14,-40,-5.5]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([-6,-40,-14]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([6,-40,-14]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);

			translate([-14,-40,5.5]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([14,-40,5.5]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([-6,-40,14]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
			translate([6,-40,14]) rotate([90,0,0]) color("blue") cylinder(r=2.5,h=10,center=true);
		difference(){
		color("grey")hull($fn=152){
			intersection(){
				translate([FM_Xp+2,FM_Yp,FM_Zp]) rotate([FM_Xr,FM_Yr,FM_Zr-90]) cube(size=[8,53,38],center=true);
				translate([FM_Xp,FM_Yp,FM_Zp]) rotate([FM_Xr,FM_Yr,FM_Zr])cylinder(r=26,h=8,center=true);
			}
			intersection(){
				translate([5,5.5,-2]) color ([0.4,0.4,0.4]) cube(size=[128,88,48],center=true);		
				resize(newsize=[158,138,50]) sphere(r=20,$fn=152);  
			}
		}
			//detectorArray_BackWall
			translate([68,25,0]) rotate([DA_Xr,DA_Yr,DA_Zr]) cube(size=[25,80,50],center=true);
			//diffractionGrating_BackWallDetail
			translate([63,-39,0]) rotate([DG_Xr,DG_Yr,DG_Zr-25]) cube(size=[20,50,50],center=true);
			//FocusingMirrorWall
			translate([-62,-13,0]) rotate([FM_Xr+90,FM_Yr,FM_Zr]) cube(size=[650,20,50],center=true);
			//collimatingMirror_detail
			translate([-26,51,0]) rotate([CM_Xr+90,CM_Yr,CM_Zr]) cube(size=[80,30,50],center=true);
			//lightBaffles
			translate([52,-1.5,0]) rotate([0,0,40]) cube(size=[1,6,45],center=true);
			translate([57,-1.5,0]) rotate([0,0,40]) cube(size=[1,10,45],center=true);

			translate([42,43,0]) rotate([0,0,00]) cube(size=[1,13,45],center=true);
			translate([37,42.75,0]) rotate([0,0,00]) cube(size=[1,14.5,45],center=true);
			translate([32,42.5,0]) rotate([0,0,00]) cube(size=[1,16,45],center=true);
			translate([27,42,0]) rotate([0,0,00]) cube(size=[1,17,45],center=true);
			translate([22,42,0]) rotate([0,0,00]) cube(size=[1,19,45],center=true);

			translate([-22,30.5,0]) rotate([0,0,00]) cube(size=[1,15,45],center=true);
			translate([-27,29,0]) rotate([0,0,00]) cube(size=[1,12,45],center=true);
			translate([-32,28,0]) rotate([0,0,00]) cube(size=[1,10.5,45],center=true);

			translate([-20,-37,0]) rotate([0,0,30]) cube(size=[10,1,45],center=true);

			translate([-4,-37,0]) rotate([0,0,30]) cube(size=[5,1,45],center=true);
			translate([-2.75,-37.5,0]) rotate([0,0,-27]) cube(size=[1,3,45],center=true);

			translate([4,-37,0]) rotate([0,0,-30]) cube(size=[5,1,45],center=true);
			translate([2.75,-37.5,0]) rotate([0,0,27]) cube(size=[1,3,45],center=true);

translate([30,11,-18]) rotate([0,0,20]) cube(size=[1,46,11],center=true);
translate([34.5,14,-16]) rotate([0,0,20]) cube(size=[1,43,9],center=true);
translate([39.5,15.5,-18]) rotate([0,0,20]) cube(size=[1,42,15],center=true);

translate([30,11,18]) rotate([0,0,20]) cube(size=[1,46,11],center=true);
translate([34.5,14,16]) rotate([0,0,20]) cube(size=[1,43,9],center=true);
translate([39.5,15.5,18]) rotate([0,0,20]) cube(size=[1,42,15],center=true);
		}
	}	
}

module screwPost(ext){
	difference(){
		cylinder(r=5,h=20+ext,$fn=50,center=true);
		translate([0,0,5])cylinder(r=1.5,h=32+ext,center=true);
		translate([0,0,23])color("red") cylinder(r=3,h=32+ext,center=true);
	}		
}

module CM_Mount(){
	color("green"){
	difference(){
		translate([0,1,0]) rotate([90,0,CM_Zr]) cylinder(r=CM_D/2+2,h=3,center=true);
		rotate([90,0,CM_Zr]) cylinder(d=CM_D+1,h=CM_ET,$fn=50,center=true);
	}
	difference(){
		hull(){
			translate([-14,-5,-4]) rotate([90,0,CM_Zr]) cylinder(r=4,h=3,center=true);
			translate([-11,-3,0]) rotate([0,0,CM_Zr]) cube(size=[2,2,5],center=true);
		}
		translate([-14,-5,-4]) rotate([90,0,CM_Zr]) cylinder(r=1.5,h=15,center=true);
	}

	difference(){
		hull(){
			translate([18,5,-4]) rotate([90,0,CM_Zr-22]) cylinder(r=4,h=3,center=true);
			translate([11,5,0]) rotate([0,0,CM_Zr]) cube(size=[2,2,5],center=true);
		}
		translate([18,5,-4]) rotate([90,0,CM_Zr]) cylinder(r=1.5,h=15,center=true);
	}
	difference(){
		hull(){
			translate([2,-2,-16]) rotate([60,0,CM_Zr]) cylinder(r=4,h=3,center=true);
			translate([1,0,-12]) rotate([0,0,CM_Zr]) cube(size=[5,2,2],center=true);
		}
		translate([2,-2,-16]) rotate([60,0,CM_Zr]) cylinder(r=1.5,h=6,center=true);
	}
}}

module FM_Mount(){
	color("lightBlue"){
		difference(){
			translate([0,0,0]) rotate([90,0,FM_Zr]) cylinder(r=FM_D/2+3,h=5,center=true);
			translate([1,0,0]) rotate([90,0,FM_Zr]) cylinder(r=FM_D/2+1,h=5,center=true);
			translate([0,0,-30]) cube(size=[15,70,20],center=true);
			translate([0,0,30]) cube(size=[15,70,20],center=true);
		}
		difference(){
			hull(){
				translate([2,32,-15]) rotate([50,0,FM_Zr-20]) cylinder(r=5,h=3,center=true);
				translate([-4,26,-10]) cube(size=[5,2,5],center=true);
			}
			translate([2,32,-15]) rotate([50,0,FM_Zr-20]) cylinder(r=2,h=10,center=true);
		}
		difference(){
			hull(){
				translate([2,32,12]) rotate([80,0,FM_Zr-20]) cylinder(r=5,h=3,center=true);
				translate([-4,26,10]) cube(size=[5,2,5],center=true);
			}
			translate([2,32,12]) rotate([80,0,FM_Zr-20]) cylinder(r=2,h=10,center=true);
		}
		difference(){
			hull(){
				translate([15,-20,-17]) rotate([30,0,FM_Zr+70]) cylinder(r=5,h=3,center=true);
				translate([4,-23,-15]) rotate([40,0,10]) cube(size=[5,2,5],center=true);
			}
			translate([15,-20,-17]) rotate([30,0,FM_Zr+70]) cylinder(r=2,h=10,center=true);
		}
	}
}

module DG_Mount(){
	difference(){
		translate([0,0,12]) color("grey") cylinder(r=16,h=30,$fn=50,center=true);
		translate([0,0,-2]) cylinder(r=12,h=5,center=true);
		rotate([0,0,-38]) translate([-9,0,15]) cube(size=[DG_T*3,DG_W+1,DG_H],center=true);
		rotate([0,0,-38]) translate([-7,0,15]) cube(size=[6,32,DG_H],center=true);
	}
}

module spectrometer(){
	difference(){
		union(){
			color("darkGrey") lowerBox();
			translate ([0,-54,0]) rotate([90,0,90]) color("red") flangeFace();
		}
		translate ([0,0,25]) color("red") cylinder(r=30,h=8,center=true);
	translate([ES_Xp,ES_Yp-(ES_mt/2),ES_Zp]) rotate([ES_Xr,ES_Yr,ES_Zr]) cylinder(d=ES_md+1.5,h=ES_mt+1,center=true);
	translate([ES_Xp,ES_Yp-(ES_mt/2),ES_Zp]) rotate([ES_Xr,ES_Yr,ES_Zr]) cylinder(r=3,h=5,$fn=50,center=true);
		translate([0,0,30]) {
			rotate([0,90,0]){
				for ( i = [0 : 7] ){
					rotate( i * 360 / 8, [1, 0, 0])
					translate([0,0,34]) rotate([0,90,0]) cylinder(r=2.45,h=10);
				}
			}
		}
	}
	translate([37,53,0]) screwPost(0);
	translate([-45,32,0]) screwPost(0);
	translate([29,-43,0]) screwPost(0);
	translate([-29,-43,0]) screwPost(0);
	//CCDmountingPoints
	translate([67,-5,-10]) rotate([0,90,20]) screwPost(-15);
	translate([67,-5,10]) rotate([0,90,20]) screwPost(-15);
	translate([47,49.5,-10]) rotate([0,90,20]) screwPost(-15);
	translate([47,49.5,10]) rotate([0,90,20]) screwPost(-15);
	//brandingThankYouVeryMuch
//	translate([47,-18,23]) rotate([0,3,30]) color([0,1,0]) write("meridian",h=6,t=3,center=true);	
//	translate([48,-26,22]) rotate([0,3,30]) color([0,1,0]) write("Scientific",h=6,t=3,center=true);	
//	translate([-55,-10,10]) rotate([90,0,-80]) color("grey") write("spectrometer_V1.0",h=4,t=3,center=true);	
//	translate([-55,-10,15]) rotate([90,0,-80]) color("grey") write("fl@c@",h=4,t=3,center=true);	
//	translate([-55,-10,5]) rotate([90,0,-80]) color("grey") write("hackaday.io/project/1279",h=3,t=3,center=true);	
}

module optics(){
	entranceSlit();
	collimatingMirror();
		translate([CM_Xp,CM_Yp,CM_Zp]) CM_Mount();
	diffractionGrating();
		translate([DG_Xp,DG_Yp,DG_Zp-16]) DG_Mount();
	focusingMirror();
		translate([FM_Xp-2,FM_Yp,FM_Zp]) FM_Mount(); 
	translate([52,21,0]){
		rotate([DA_Xr,DA_Yr,DA_Zr-20]){
			detectorArray();
		}
	}
}

module split(){
	difference(){
		spectrometer();
		translate([0,0,15]) cube(size=[150,120,30],center=true);
	}
}
split();
optics();
//accessCover();

//animate
function saw(t) = 1 - 2*abs(t-0.5);    
//rotate([0,0,saw($t)*360,0])  split();
//rotate([0,0,saw($t)*360,0])  optics();

