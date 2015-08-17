/*
Heads to be 22.5mm apart, this is the heatsink width
Mount holes 23.9mm apart, embedded under heads
mount uses 3mm screws with 6mm head hole


bottom of j head is 50mm above print head height
bottom of J head must be at level with mount holes
16mm oututer 12mm inner
6mm gap 3.6mm top ring

*/

JOD     =   16;         //J head outer diameter
JID     =   12;         //J head inner diameter
JUR     =   3.95;       //J head upper ring height
JCR     =   6;          //J head center ring height
JSW     =   22.5;       //J head spacing width

MX      =   JSW * 2;    //Total X length for mount
MZ      =   19;         //Total height

module j_head(){
    union(){ //center hole
    translate ([0,0,0]) cylinder(MZ, JID/2, JID/2, center = false, $fn=40);
    translate ([0,0,12]) cylinder(JUR, JOD/2, JOD/2, center = false, $fn=60);
    translate ([0,0,0]) cylinder(JUR + 3, JOD/2, JOD/2, center = false, $fn=60);
    }
}

module screw_hole(){
    rotate([270,0,0]){
        translate([0,0,-8]) cylinder(10,1.5,1.5, $fn = 10);
        translate([0,0,2]) cylinder(18,3.5,3.5, $fn = 14);
    }
}

module j_head_mount(){
    
    difference(){
        cube([MX, JSW, MZ]);
        translate([JSW/2,JSW/2 + 2,0]) j_head();
        translate([JSW/2 + JSW,JSW/2 + 2,0]) j_head();
        translate([(MX - 23.9) / 2,0,3]) screw_hole();
        translate([(MX - 23.9) / 2 + 23.9,0,3]) screw_hole();
        translate([MX/2,JSW/2 + 2,MZ/2]) screw_hole();
    }
}
difference(){
   j_head_mount();
   translate([0,JSW/2 + 2,0]) cube([MX,0.1,MZ]);
}