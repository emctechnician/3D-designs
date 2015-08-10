/*
Heads to be 22.5mm apart, this is the heatsink width
Mount holes 23.9mm apart, embedded under heads
mount uses 3mm screws with 6mm head hole
*/

module j_head_mount(){
    union(){ //center hole
    translate ([0,7,0]) cylinder(13, 6.2, 6.2, center = false, $fn=40);
    translate ([-6,0,0]) cube([12,7,13], center = false);
    translate ([0,7,3]) cylinder(4.2, 8.8, 8.8, center = false, $fn=60);
    translate ([-8.5,0,3]) cube([17,7,4.2], center = false);
    }
}


difference(){
    
translate([0,-20,0]) cube([42,20,25]);
    
for (i=[9.75,32.25]){
    translate([i,0,13])
    rotate([180,0,0])
    j_head_mount();
}

translate([0,-18,13]) cube([42,18,13]);

for (i=[9.05,32.95]){
     translate([i,-20,20]) rotate([270,0,0]) cylinder(2,1.5,1.5, $fn=12);
}

}