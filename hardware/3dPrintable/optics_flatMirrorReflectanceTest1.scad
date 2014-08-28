x = 0;
y = 56;
z = 45;
ira = 25;

aoi = y - ira;
rra = y + aoi;

module mirror(){
	translate ([0,-1,-1])rotate([x,y,z]) cylinder(r=10,h=2,center=true);
	rotate([x,y,z]) cylinder(r=.25,h=20,center=true);
}

module incidenceRay(){
	rotate([x,ira,z]) color([0,1,0]) cylinder(r=.25,h=100,$fn=50);
}

module reflectedRay(){
	rotate([x,rra,z]) color([1,1,0]) cylinder(r=.25,h=100,$fn=50);
}

module group(){
	mirror();
	incidenceRay();
	reflectedRay();
}

group();
//function saw(t) = 1 - 2*abs(t-0.5);    
//rotate([0,0,saw($t)*360,0])  group();
