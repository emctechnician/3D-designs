difference(){
difference(){
    cube([6,34,19]);
    for (i = [7.25:19.75:7.25+19.75]){
        translate([0,i,0])
        cylinder(19,4.2,4.2, $fn=20);
    }
}
translate([0,16.65,9.5]) rotate([0,90,0]) cylinder(8,1.8,1.8, $fn=20);
}