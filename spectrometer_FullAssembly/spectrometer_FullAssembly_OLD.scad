laserLine1_Y = -85; 
laserLine1_Z= 70;
laserLine2_X= 10;
lensInPlaceX= 10;
lensStoredX= -60;
lensMountTopZ= -92.5;
lensMountBottomZ= -47.5;
open= 0;
cuvetteTrayPosition= 100;


//============================================================
pi=3.1415926535897932384626433832795;
$fn=50;
module rack(cp, N, width, thickness){
// cp = circular pitch - for rack = pitch in mm/per tooth
// N = number of teeth
// width = width of rack
// thickness = thickness of support under teeth (0 for no support)

	a = 1.0*cp/pi; // addendum (also known as "module")
	d = 1.1*cp/pi; // dedendum (this is set by a standard)
	height=(d+a);

	// find the tangent of pressure angle once
	tanPA = tan(20);
	// length of bottom and top horizontal segments of tooth profile
	botL = (cp/2 - 2*d*tanPA);
	topL = (cp/2 - 2*a*tanPA);

	slantLng=tanPA*height;
	realBase=2*slantLng+topL;

	offset=topL+botL+2*slantLng;
	length=(realBase+botL)*N;

	supportSize=width;
	translate([botL/2,0,0])
	rotate([90,0,0]){
		translate([0,supportSize/2,0]){
			union(){
				cube(size=[length,width,thickness],center=true);
				for (i = [0:N-1]){
					translate([i*offset-length/2+realBase/2,0,thickness/2]){
						trapezoid([topL,supportSize],[realBase,supportSize],height);
						}
					}
				}
			}
		}
	}

//==========================================================
module pinion (cp, N, width, shaft_diameter, backlash=0){
// cp= circular pitch - for pinion pitch in mm/per as measured along the ptich radius (~1/2 way up tooth)
// N= number of teeth
// width= width of the gear
// shaft_diameter= diameter of hole for shaft
// backlash - I think this is just a bodge for making things fit when printed but I never tested it

	if (cp==false && diametral_pitch==false) 
		echo("MCAD ERROR: pinion module needs either a diametral_pitch or cp");

	//Convert diametrial pitch to our native circular pitch
	cp = (cp!=false?cp:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  N * cp / pi;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", N, " Pitch radius:", pitch_radius);
	// Base Circle
	base_radius = pitch_radius*cos(20);

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = cp/pi;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum*1.1;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;

	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / N - backlash_angle) / 4;

	difference(){
		linear_extrude (height=width, convexity=10, twist=0)
		pinion_shape(N, pitch_radius = pitch_radius, root_radius = root_radius,
			base_radius = base_radius, outer_radius = outer_radius,
			half_thick_angle = half_thick_angle, involute_facets=0);

		translate([0,0,-1]) cylinder(r=shaft_diameter/2,h=2+width);
		}

	echo("Root radius =",root_radius,"\nPitch radius=",pitch_radius,"\n Tip radius=",outer_radius,"\n");
	}

module pinion_shape ( N, pitch_radius, root_radius, base_radius, outer_radius, half_thick_angle, involute_facets) {
	union(){
		rotate (half_thick_angle) circle ($fn=N*2, r=root_radius);
		for (i = [1:N]) {
			rotate ([0,0,i*360/N]) {
				involute_pinion_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
				}
			}
		}
	}

module involute_pinion_tooth ( pitch_radius, root_radius, base_radius, outer_radius, half_thick_angle, involute_facets) {
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union () {
		for (i=[1:res])
		assign ( point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res), point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res)) {
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2))) {
				polygon ( points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1], paths=[[0,1,2,3,4,0]]);
				}
			}
		}
	}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function rotated_involute(rotate,base_radius,involute_angle)=[cos(rotate)*involute(base_radius, involute_angle)[0]+sin(rotate)*involute(base_radius, involute_angle)[1],cos(rotate)*involute(base_radius, involute_angle)[1]-sin(rotate)*involute(base_radius, involute_angle)[0]];

function mirror_point(coord)=[coord[0],-coord[1]];

function rotate_point(rotate,coord)=[cos(rotate)*coord[0]+sin(rotate)*coord[1],cos(rotate)*coord[1]-sin(rotate)*coord[0]];

function involute (base_radius, involute_angle)=[base_radius*(cos(involute_angle)+involute_angle*pi/180*sin(involute_angle)),base_radius*(sin(involute_angle)-involute_angle*pi/180*cos(involute_angle))];

module trapezoid(top,base,height){
	//echo ("test",base[0]);
	basePT1=[ -base[0]/2, base[1]/2, 0];
	basePT2=[ base[0]/2, base[1]/2, 0];
	basePT3=[ base[0]/2, -base[1]/2, 0];
	basePT4=[ -base[0]/2, -base[1]/2, 0];
	topPT1=[ -top[0]/2, top[1]/2, height];
	topPT2=[ top[0]/2, top[1]/2, height];
	topPT3=[ top[0]/2, -top[1]/2, height];
	topPT4=[ -top[0]/2, -top[1]/2, height];
	polyhedron(points=[ basePT1, basePT2, basePT3, basePT4, topPT1, topPT2, topPT3, topPT4],triangles=[[0,1,2], [0,2,3],[3,7,0], [7,4,0],[1,6,2], [1,5,6],[2,6,3], [3,6,7],[5,1,0],[4,5,0],[7,5,4],[5,7,6]]);
	}
//==========================================================

module outerCasing(){
	color([0.7,0.7,0.7]) cube(size=[280,230,2],center=true);
	translate([0,-114,59]) color([0.7,0.7,0.7]) cube(size=[280,2,120],center=true);
	translate([0,114,59]) color([0.7,0.7,0.7]) cube(size=[280,2,120],center=true);
	translate([139,0,59]) color([0.7,0.7,0.7]) cube(size=[2,230,120],center=true);
	translate([-139,0,59]) color([0.7,0.7,0.7]) cube(size=[2,230,120],center=true);
}

module laserEmitter(){
	color([0.1,0.1,0.1]) cube(size=[85,40,40],center=true);	
}

module laserPowerSupply(){
}

module laserBeam(length){
	rotate([0,90,0]) color([0,1,0]) cylinder(h=length,r=.5,$fn=50,center=true);	
}

module 532nmPassFilterTop(){
	difference(){
		//lensHolderTop
		translate([0,0,15]) color([0.8,1,.6]) cube(size=[7,30,10],center=true);	
		//lensHolderIndentation
		translate([0,0,10]) color([01,1,.6]) cube(size=[1.5,10.5,10.5],center=true);	
		//lensHole
		translate([0,0,10]) color([01,1,.6]) cube(size=[20,5,5],center=true);
		//screwHoles
		translate([0,10,15]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([0,-10,15]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
}
module 532nmPassFilterBottom(){
	difference(){
		//lensHolderBottom
		translate([0,0,-15]) color([0.8,1,.6]) cube(size=[7,30,10],center=true);	
		//lensHolderIndentation
		translate([0,0,-10]) color([01,1,.6]) cube(size=[1.5,10.5,10.5],center=true);	
		//lensHole
		translate([0,0,-10]) color([01,1,.6]) cube(size=[20,5,5],center=true);	
		//screwHoles
		translate([0,10,-10]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([0,-10,-10]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
	//base
	translate([0,0,-24]) color([0.8,1,.6]) cube(size=[8,40,8],center=true);	
	difference(){
	translate([0,0,-29]) color([0.8,1,.6]) cube(size=[20,50,2],center=true);	
	//screwHoles
	translate([7,22,-29]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	translate([7,-22,-29]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	translate([-7,22,-29]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	translate([-7,-22,-29]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}

module beamSplitterMountTop(){
	difference(){
		translate([0,0,0]) color([.95,.95,.95]) cube(size=[25,25,2],center=true);
		//topScrewholes
		translate([9,9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([9,-9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-9,-9,0]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
module beamSplitterMountBottom(){
	difference(){
		//mainBody
		translate([0,0,3.25]) color([.95,.95,.95]) cube(size=[25,25,23],center=true);
		//centerCube
		translate([0,0,8.25]) color([.25,.95,.95]) cube(size=[13,13,13],center=true);
		//laserPath
		translate([0,0,10]) color([0,.95,0]) cube(size=[30,10,10],center=true);
		translate([0,0,10]) color([.1,.15,.95]) cube(size=[10,30,10],center=true);
		//topScrewholes
		translate([9,9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,-9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,-9,10]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
	}
	difference(){
		//base
		translate([0,0,-9]) color([.95,.95,.95]) cube(size=[40,40,2],center=true);
		//baseScrewholes
		translate([16,16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([16,-16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,-16,-9]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//-------------------------------------------------------------------------------
module 522SP_lensMountTop(){
	//arrowBody
	translate([45,2,-1]) color([0,1,1]) cube(size=[2.5,2,5]);
	//arrowHead
	translate([45,3,-1]) color([0,1,1]) rotate([0,90,0]) cylinder(h=2.5,r=3,$fn=3);
	//522SP Lens Mount Top
	difference(){
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//lensBody
		translate([-20,20,-1.5]) cube(size=[40,5,3]);
		//lensHole
		translate([-15,20,-10]) cube(size=[30,4,20]);
		//screwHoles
		translate([35,-12,0]) cylinder(h=30,r=2,center=true);
		translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,center=true);
	}
}
module 522SP_lensMountBottom(){
	//522SP Lens Mount Bottom
	rotate([180,0,0]){
		difference(){
			color([.2,.1,.6]) cube(size=[90,45,10],center=true);
			//lensBody
			translate([-20,20,-1.5]) cube(size=[40,5,3]);
			//lensHole
			translate([-15,20,-10]) cube(size=[30,4,20]);
			//screwHoles
			translate([35,-12,0]) cylinder(h=30,r=2,center=true);
			translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
			522SP_LensTextLabel();
		}
	}
}
//----------------------------------------------------------------------------
module 550LP_lensMountTop(){
	//arrowBody
	translate([45,2,-1]) color([0,1,1]) cube(size=[2.5,2,5]);
	//arrowHead
	translate([45,3,-1]) color([0,1,1]) rotate([0,90,0]) cylinder(h=2.5,r=3,$fn=3);
	//550LP Lens Mount Top
	difference(){
		color([.2,.1,.6]) cube(size=[90,45,10],center=true);
		//lensBody
		translate([0,22.5,0]) cylinder(h=3.5,r=4,center=true);
		//lensHole
		translate([0,22.5,0]) cylinder(h=30,r=3,center=true);
		//screwHoles
		translate([35,-12,0]) cylinder(h=30,r=2,center=true);
		translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,center=true);
	}
}
module 550LP_lensMountBottom(){
	//550LP Lens Mount Bottom
	rotate([180,0,0]){
		difference(){
			color([.2,.1,.6]) cube(size=[90,45,10],center=true);
			//lensBody
		translate([0,22.5,0]) cylinder(h=3.5,r=4,center=true);
			//lensHole
			translate([0,22.5,0]) cylinder(h=30,r=3,center=true);
			//screwHoles
			translate([35,-12,0]) cylinder(h=30,r=2,center=true);
			translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
			550LP_LensTextLabel();
		}
	}
}
//----------------------------------------------------------------------------
module interferenceLensMountTop(){
	//arrowBody
	translate([45,0,0]) color([0,1,1]) cube(size=[2.5,6,12]);
	//arrowHead
	translate([45,3,0]) color([0,1,1]) rotate([0,90,0]) cylinder(h=2.5,r=7,$fn=3);
	//laserLine
	translate([45,-10,-11]) color([0,1,1]) cube(size=[.5,.5,23]);
	//laserBall
	translate([45,-9.75,-7]) color([0,1,1]) sphere(r=1.5,$fs=.5);
	//laserEffect
	translate([45,-13.25,-10.75]) rotate([45,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);
	translate([45,-13.25,-3.75]) rotate([-45,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);
	translate([45,-14.75,-7]) rotate([0,0,0]) color([0,1,1]) cube(size=[.5,10,.25]);

	//Interference Lens Mount Top
	difference(){
		color([.6,.1,.6]) cube(size=[90,45,25],center=true);
		//lensBody
		translate([0,22.25,-2.5]) cylinder(h=14,r=30.5,center=true);
		//lensScrewMount
		translate([0,22.5,6.5]) cylinder(h=4,r=24.5,center=true);
		//lensHole
		translate([0,22.5,0]) cylinder(h=30,r=20,center=true);
		//screwHoles
		translate([35,-12,0]) cylinder(h=30,r=2,center=true);
		translate([-35,-12,0]) cylinder(h=30,r=2,center=true);
		//cornerNotch
		translate([45,22.5,0]) cylinder(h=30,r=2,center=true);
		translate([-45,22.5,0]) cylinder(h=30,r=2,center=true);
	}
}
module interferenceLensMountBottom(){
	//Interference Lens Mount Top
	difference(){
		color([.6,.1,.6]) cube(size=[90,45,25],center=true);
		//lensBody
		translate([0,-22.25,-2.5]) cylinder(h=14,r=30.5,center=true);
		//lensScrewMount
		translate([0,-22.5,6.5]) cylinder(h=4,r=24.5,center=true);
		//lensHole
		translate([0,-22.5,0]) cylinder(h=30,r=20,center=true);
		//screwHoles
		translate([35,12,0]) cylinder(h=30,r=2,center=true);
		translate([-35,12,0]) cylinder(h=30,r=2,center=true);
		interferenceLensTextLabel();
	}
}
//------------------------------------------------------------------------
module objectiveLensMountTop(){
	difference(){
		//mainBody
		translate([0,0,2]) color([0,.6,.5]) cube(size=[28,45,16],center=true);
		//lensHole
		translate([9,0,-6]) rotate([0,90,0]) cylinder(h=13,r=12,center=true);
		translate([-6,0,-6]) rotate([0,90,0]) cylinder(h=18,r=10,center=true);
		//screwHoles
		translate([-9,17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([9,17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([-9,-17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
		translate([9,-17,2]) color([1,0,0]) cylinder(h=18,r=1.5,$fn=8,center=true);
	}
}
module objectiveLensMountBottom(){
	difference(){
		//mainBody
		translate([0,0,1]) color([0,.6,.5]) cube(size=[28,45,18],center=true);
		//lensHole
		translate([9,0,10]) rotate([0,90,0]) cylinder(h=13,r=12,center=true);
		translate([-6,0,10]) rotate([0,90,0]) cylinder(h=18,r=10,center=true);
		//screwHoles
		translate([-9,17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([-9,-17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
		translate([9,-17,6]) color([1,0,0]) cylinder(h=10,r=1.5,$fn=8,center=true);
	}
	difference(){
		translate([0,0,-9]) color([0,.6,.5]) cube(size=[45,45,2],center=true);
		//screwHoles
		translate([-18,17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([18,17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([-18,-17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
		translate([18,-17,-9]) color([1,0,0]) cylinder(h=4,r=1.5,$fn=8,center=true);
	}
}
//--------------------------------------------------------------------------
module cuvetteHolderBottom(){
	difference(){
		//mainBody
		translate([0,0,0]) color([.5,.95,.95]) cube(size=[25,25,35],center=true);
		//centerCube
		translate([0,0,8.25]) color([.6,.9,.9]) cube(size=[11,11,25],center=true);
		//laserPath
		translate([10,0,10]) color([0,.95,0]) cube(size=[10,10,10],center=true);
	}
	difference(){
		//base
		translate([0,0,-17]) color([.5,.95,.95]) cube(size=[40,40,2],center=true);
		//baseScrewholes
		translate([16,16,-17]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([16,-16,-17]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,16,-17]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-16,-16,-17]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//--------------------------------------------------------------------------
module cuvetteHolderTray(){
	//mainBody
	translate([0,0,0]) color([.3,.55,.95]) cube(size=[250,40,2],center=true);
	//rails
	translate([0,20,0]) color([.3,.55,.95]) cube(size=[250,2,10],center=true);
	translate([0,-20,0]) color([.3,.55,.95]) cube(size=[250,2,10],center=true);
	translate([120,0,-2.5]) color([.3,.55,.95]) cube(size=[5,40,5],center=true);
}
//--------------------------------------------------------------------------
module collimatingLensMountTop(){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,12,29],center=true);
		//lensHole
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=8,r=11.5,center=true);
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=14,r=10,center=true);
		//screwHoles
		translate([-18,0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
		translate([18,-0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
	}
}
module collimatingLensMountBottom(){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,12,69],center=true);
		//lensHole
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=8,r=11.5,center=true);
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=14,r=10,center=true);
		//screwHoles
		translate([-18,0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([18,-0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
	difference(){
		//base
		translate([0,0,-34]) color([.6,.2,.9]) cube(size=[70,30,2],center=true);
		//baseScrewholes
		translate([30,10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([30,-10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,-10,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//------------------------------------------------------------------------------
module adjustableSlit(){
	difference(){
		//mainBody
		translate([0,0,15]) color([.4,.2,.9]) cube(size=[12,40,97],center=true);
		//lensHole
		translate([0,0,35]) cube(size=[15,1,30],center=true);
		translate([1,0,35]) cube(size=[12,30,40],center=true);
	}
	difference(){
		//base
		translate([0,0,-34]) color([.4,.2,.9]) cube(size=[30,60,2],center=true);
		//baseScrewholes
		translate([10,25,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([10,-25,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-10,25,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-10,-25,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//------------------------------------------------------------------------------
module mirror(angle){
	rotate([0,0,angle]){
		difference(){
		//mainBody
			translate([0,0,15]) color([.4,.2,.9]) cube(size=[5,40,97],center=true);
			//lensHole
			translate([-2,0,35]) cube(size=[6,25,25],center=true);
		}
	}
	difference(){
		//base
		translate([0,0,-34]) color([.4,.2,.9]) cube(size=[50,40,2],center=true);
		//baseScrewholes
		translate([20,15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([20,-15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,-15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//-----------------------------------------------------------------------------
module diffractionGrating(angle){
	rotate([0,0,angle]){
		difference(){
		//mainBody
			translate([0,0,15]) color([.4,.7,.9]) cube(size=[5,40,97],center=true);
			//lensHole
			translate([-2,0,35]) cube(size=[6,25,25],center=true);
		}
	}
	difference(){
		//base
		translate([0,0,-34]) color([.4,.7,.9]) cube(size=[50,40,2],center=true);
		//baseScrewholes
		translate([20,15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([20,-15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-20,-15,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//-----------------------------------------------------------------------------
module cameraMountTop(angle){
	rotate([0,0,angle]){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,25,29],center=true);
		//lensHole
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=15,r=11.5,center=true);
		translate([0,0,-14.5]) rotate([90,0,0]) cylinder(h=30,r=10,center=true);
		//screwHoles
		translate([-18,0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
		translate([18,-0,0]) color([1,0,0]) cylinder(h=32,r=1.5,$fn=8,center=true);
	}
	}
}
module cameraMountBottom(angle){
	rotate([0,0,angle]){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[50,25,69],center=true);
		//lensHole
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=8,r=12,center=true);
		translate([0,0,35]) rotate([90,0,0]) cylinder(h=30,r=10,center=true);
		//screwHoles
		translate([-18,0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
		translate([18,-0,28]) color([1,0,0]) cylinder(h=15,r=1.5,$fn=8,center=true);
	}
	}
	difference(){
		//base
		translate([0,0,-34]) color([.6,.2,.9]) cube(size=[70,50,2],center=true);
		//baseScrewholes
		translate([30,20,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([30,-20,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,20,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
		translate([-30,-20,-34]) color([1,0,0]) cylinder(h=5,r=1.5,$fn=8,center=true);
	}
}
//------------------------------------------------------------------------------
module cuvetteTraySlideRail(){
	difference(){
		//mainBody
		color([.6,.2,.9]) cube(size=[70,60,20],center=true);
			//trayHole
		translate([0,0,3]) color([.73,.75,.95]) cube(size=[75,40,4],center=true);
		//railHoles
		translate([0,20,3]) color([.73,.75,.95]) cube(size=[75,4,12],center=true);
		translate([0,-20,3]) color([.73,.75,.95]) cube(size=[75,4,12],center=true);
		//rackHole
		translate([0,0,0]) color([.73,.75,.95]) cube(size=[75,15,10],center=true);
	}

}
//---------------------------------------------------------------------------
module cuvetteTrayMotorAndGearMount(){
	difference(){
		//base
		translate([17,0,0])color([.8,.7,.2]) cube(size=[50,60,2],center=true);
		//screwHoles
		translate([-4,25,0]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
		translate([-4,-25,0]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
		translate([38.5,25,0]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
		translate([38.5,-25,0]) color([1,0,0]) cylinder(h=8,r=1.5,$fn=8,center=true);
	}

	difference(){
		//baseBlock
		translate([17.5,0,7]) color([.8,.7,.2]) cube(size=[35,60,12],center=true);
		//motorBlock
		translate([19,20,12]) color([.8,.7,.2]) cube(size=[14,30,12],center=true);
		//gearBlock
		translate([19,1.5,20]) color([.8,.7,.2]) cube(size=[25,10,30],center=true);
	}
	difference(){
		//gearTower
		translate([17.5,0,23]) color([.8,.7,.2]) cube(size=[35,20,20],center=true);
		//gearTowerHole
		translate([19,1.5,20]) color([.8,.7,.2]) cube(size=[25,10,30],center=true);
		//shaftHole
		rotate([0,90,0]) translate([0,0,20]) cylinder(h=25,r=2,center=true);
		rotate([90,0,0]) translate([19,26,0]) cylinder(h=25,r=2.6,center=true);
	}
		//shaft
		rotate([90,0,0]) translate([19,26,0]) cylinder(h=25,r=2.5,center=true);
}












color([0.7,0.7,0.7]) cube(size=[280,230,2],center=true);
translate([27.5,-85,49]) color([0,0.7,0.7]) cube(size=[225,60,2],center=true);
//%outerCasing();
translate([30,laserLine1_Y,60 + open]){
	532nmPassFilterTop();
}
translate([30,laserLine1_Y,80]){
	532nmPassFilterBottom();
}
translate([95,-85,laserLine1_Z]) {
	laserEmitter();
}
translate([0,laserLine1_Y,laserLine1_Z]) {
	laserBeam(200);
}
rotate([0,0,90]){
	translate([-2.5,laserLine2_X,laserLine1_Z]) {
		laserBeam(165);
	}
}
translate([-60,80,laserLine1_Z]) {
	laserBeam(100);
}

translate([-10,laserLine1_Y,75 + open]){
	beamSplitterMountTop();
}
translate([-10,laserLine1_Y,60]){
	beamSplitterMountBottom();
}
//------------------------------------------------lensMounts
rotate([90,180,0]){
	translate([lensInPlaceX,lensMountTopZ - open,45]){
		522SP_lensMountTop();
	}
	translate([lensInPlaceX,lensMountBottomZ,45]){
		522SP_lensMountBottom();
	}
}
rotate([90,180,0]){
	//550LP_lensMount
	translate([lensStoredX,lensMountTopZ - open,25]){
		550LP_lensMountTop();
	}
	translate([lensStoredX,lensMountBottomZ,25]){
		550LP_lensMountBottom();
	}
}
rotate([90,180,0]){
	//interferenceMount
	translate([lensStoredX,lensMountTopZ -open,-5]){
		interferenceLensMountTop();
	}
	translate([lensStoredX,lensMountBottomZ,-5]){
		interferenceLensMountBottom();
	}
}
translate([-60,laserLine1_Y,76 + open]){
	objectiveLensMountTop();
}
translate([-60,laserLine1_Y,60]){
	objectiveLensMountBottom();
}
translate([-cuvetteTrayPosition,laserLine1_Y,60]){
	cuvetteHolderBottom();
	translate([105,0,-19]){
		cuvetteHolderTray();
	}
	rotate([90,0,0]){
		translate([100,-20,- 4.5]){
			rack(4,50,6.25,2);
		}
	}
}
translate([-15,laserLine1_Y,38]){
	cuvetteTraySlideRail();
}
translate([-lensInPlaceX,45,84.5 + open]){
	collimatingLensMountTop();
}
translate([-lensInPlaceX,45,35.5]){
	collimatingLensMountBottom();
}
translate([-65,80,35.5]){
	adjustableSlit();
}
translate([-lensInPlaceX,82.5,35.5]){
	mirror(45);
}
translate([-110,80,35.5]){
	diffractionGrating(120);
}
translate([-90,0,84.5 + open]){
	cameraMountTop(15);
}
translate([-90,0,35.5]){
	cameraMountBottom(15);
}

translate([-110,laserLine1_Y,2]){
	cuvetteTrayMotorAndGearMount();
}
rotate([90,0,0]){
	//rackPinion
	translate([-91,28,-laserLine1_Y - 4.5]){
		pinion(4,15,6.25,5);
	}
	//motorPinion
	translate([-91,14,-laserLine1_Y - 4.5]){
		rotate([0,0,26]){
			pinion(4,7,6.25,3);
		}
	}
}