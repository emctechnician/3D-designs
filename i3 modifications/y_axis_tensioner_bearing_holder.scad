LH      =   0.248;  //layer height
EW      =   0.4;    //extrusion width
NW      =   6.3;    //nut width
NH      =   3;    //nut height
BCW     =   11;     //bearing cutout width y
BSR     =   2.7;     //bearing shaft radius
BCL     =   13.5;     //bearing cutout length X
height  =   BSR * 2 + 8 * LH;     //z
width   =   BCW + 8 * EW;     //y
length  =   22;     //x

echo ("total height = ",  height, "mm width = ", width,"mm"); 

difference(){
    cube([length,width,height]);
    
    union(){
        translate([0,width/2,height/2]) 
        rotate([0,90,0])
        cylinder(26,1.8,1.8, $fn=20); //tensioner hole
        
        translate([EW*3,(width-NW)/2,0])
        cube([NH,NW,height]); //captive nut hole
        
        translate([length-BCL,(width-BCW)/2,0])
        cube([BCL,BCW,height]); //bearing cutout
        
        translate([length-BCL+9.1,0,height/2])
        rotate([270,0,0])
        cylinder(width,BSR,BSR, $fn=20); //bearing shaft
    }
    
}