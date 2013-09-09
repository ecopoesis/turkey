use<Write/Write.scad>

$fn = 30;
$text="Turkey!";

difference() {
	union() {
		color("SaddleBrown") {
			body();
			head();
			wings();
			text();
			feathers(false);
		}

		color("OrangeRed") {
			beak();
			base();
			feathers(true);
		}

	}

	translate([-200, -100, -100])
	cube([200, 200, 200]);
}

module base() {
	difference() {
		translate([0,-75,-35])
		cube([110, 150, 15]);	

		translate([110,-75,-35])
		rotate(a=-45, v=[0,1,0])
		cube([20, 150, 30]);
	}
}

module text() {
	translate([102,0,-27])
	rotate(a=-45, v=[0,1,0])
	rotate(a=90, v=[1,0,0])
	rotate(a=90, v=[0,1,0])		
	write($text,h=11,t=4,center=true);
}

module wings() {
	wing(); 

	mirror([0,1,0]) {
		wing();
	}

/*	translate([58,-35,0])
	rotate(a=-10, v=[1,0,0])
	rotate(a=12, v=[0,0,1])
	wing();*/
}

module wing() {
	translate([58,28,0])
	rotate(a=10, v=[1,0,0])
	rotate(a=-12, v=[0,0,1])

	rotate(a=-90, v=[1,0,0])
	rotate(a=190, v=[0,0,1])
	resize([50,30,20])
	minkowski() {
		difference() {			
			linear_extrude(1)
			polygon([[2,1], [0,4], [8,6], [8,0]]);

			translate([8,0,0])
			rotate(a=-30, v=[0,1,0])
			cube([10,10,10]);
		}
	
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
		sphere(r=17, $fn=100);

		translate([99, 7, 45])
		sphere(r=3);

		translate([99, -7, 45])
		sphere(r=3);
	}
}

module body() {
	translate([40, 0, 10])
	resize([100, 80, 70])
	sphere(r=40, $fn=100);
}

module feathers(odd) {
	union() {
		difference() {
			feathers_raw(odd);

			if (!odd) {
				feathers_raw(!odd);
			}	
		}
	}
}

module feathers_raw(odd) {
	for(i = [-5 : 5]) {
		if ((i % 2 != 0 && !odd) || (i % 2 == 0 && odd)) {
			rotate(a=20*i, v=[1, 0, 0])  
			feather(75, 30, 7);
		}
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
