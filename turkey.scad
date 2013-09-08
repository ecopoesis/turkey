use<Write/Write.scad>

$fn = 10;
$text="Turkey!";

difference() {
	union() {
		feathers();
		body();
		head();
		beak();
		wings();
		base();
	}

	translate([-200, -100, -100])
	cube([200, 200, 200]);
}

module base() {
	union() {
		translate([102,0,-27])
		rotate(a=-45, v=[0,1,0])
		rotate(a=90, v=[1,0,0])
		rotate(a=90, v=[0,1,0])		
		write($text,h=11,t=4,center=true);
		
		difference() {
			translate([0,-75,-35])
			cube([110, 150, 15]);	

			translate([110,-75,-35])
			rotate(a=-45, v=[0,1,0])
			cube([20, 150, 30]);
		}
	}	
}

module wings() {
	translate([58,28,0])
	rotate(a=10, v=[1,0,0])
	rotate(a=-12, v=[0,0,1])
	wing();

	translate([58,-35,0])
	rotate(a=-10, v=[1,0,0])
	rotate(a=12, v=[0,0,1])
	wing();
}

module wing() {
	rotate(a=-90, v=[1,0,0])
	rotate(a=190, v=[0,0,1])
	resize([50,30,20])
	minkowski() {
		linear_extrude(1)
		polygon([[2,1], [0,4], [8,6], [8,0]]);

		sphere(r=1);
	}	
}

module beak() {
	translate([110, 0, 38])
	rotate(a=-90, v=[0, 1, 0])
	resize([12, 16, 15])
	cylinder(h=15, r1=0, r2=8);	
}

module head() {
	difference() {
		translate([85, 0, 35])
		resize([34,34,40])
		sphere(r=17);

		translate([99, 7, 45])
		sphere(r=3);

		translate([99, -7, 45])
		sphere(r=3);
	}
}

module body() {
	translate([40, 0, 10])
	resize([100, 80, 70])
	sphere(r=40);
}

module feathers() {
	for(i = [-10 : 10]) {
		rotate(a=10*i, v=[1, 0, 0])  
		feather(75, 15, 5);
	}
}

module feather(h, w, d) {
	resize([d, w, h])
	union() { 
		cylinder(h=h, r1=0, r2=w);

		translate([0, 0, h])
		sphere(r=w);
	}
}