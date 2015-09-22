$fn     =   30;
L       =   12;

difference(){
union(){
translate([0,0,22]) rotate([0,90,0]) cylinder(L,6,6);
translate([0,-6,0]) cube([L,12,22]);
translate([0,6,0]) rotate([90,0,90]) linear_extrude(L) polygon([[0,0], [10,0], [-0.1,23]]);
translate([L,-6,0]) rotate([90,0,-90]) linear_extrude(L) polygon([[0,0], [10,0], [-0.1,23]]);
}
union(){
translate([0,0,20]) rotate([0,90,0]) cylinder(L,4,4);
translate([0,-4,0]) cube([L,8,20]);
translate([L/2,11,0]) cylinder(4,2.5,2.5);
translate([L/2,-11,0]) cylinder(4,2.5,2.5);
translate([L/2,-11,4]) cylinder(20,4.5,4.5);
translate([L/2,11,4]) cylinder(20,4.5,4.5);
translate([L/2-4.5,11,4]) cube(9,5,20);
translate([L/2-4.5,-11-9,4]) cube(9,5,20);
}
}
