/*
This is for generating designs for roller bearings.
You must manually state the number of roller (NR), i'd suggest
as many rollers you can fit. This changes depending on the size
of bearing.

The outer diameter minus the inner diameter must not be less
than 20.4, this can be smaller if you drop the roller size, 
however results may vary.
*/

//start of modifiable variables
support =   1;          //Generate soluble support 1 = yes, 0 = no  
BW      =   10;         //Bearing width Z axis
EW      =   0.3;        //extrusion width
LH      =   0.2;        //layer height
ID      =   8.1;        //inner diameter
OD      =   31;         //outer diameter
NR      =   7;          //Number of rollers


//end of modifiable variables

{
if ((OD - ID) < 20.4){
    echo("ERROR: OD - ID is less than 20.4");
}

WW  =   round(1 / EW) * EW + EW;     //Wall width XY axis
WT  =   round(1 / LH) * LH + LH;     //wall width Z axis

OR  =   OD / 2;             //Outer radius
IR  =   ID / 2;             //Inner radius
SR  =   (OD + ID) / 4;      //Split radius

RR  =   EW * 12;                //Roller radius, must be larger than EW * 10
RH  =   BW - WT * 2 - LH * 4;   //Roller height
RPR =   OR - WW - RR - EW;      //Roller position radius
}

module side_wall(z){
    translate([0,0,z])
    difference(){
        cylinder(WT, OR, OR, $fn = 60);   //main sidewall
        difference(){           //Split ring
            cylinder(WT, RPR + RR - WW, RPR + RR - WW); 
            cylinder(WT, RPR - RR + WW, RPR - RR + WW);
        }
        cylinder(WT, IR, IR, $fn = 30);
    }
}

module side_wall_support(){
    difference(){
        cylinder(BW - WT, OR, OR, $fn = 60);   //main sidewall
        difference(){           //Split ring
            cylinder(BW - WT, RPR + RR - WW, RPR + RR - WW); 
            cylinder(BW - WT, RPR - RR + WW, RPR - RR + WW);
        }
        cylinder(BW - WT, IR, IR, $fn = 30);
    }
}

module outer_wall(){
    difference(){
        cylinder(BW, OR, OR, $fn = 60);
        cylinder(BW, OR - WW, OR - WW, $fn = 60);
    }
}

module inner_wall(){
    difference(){
        cylinder(BW, RPR - RR - EW, RPR - RR - EW, $fn = 50);
        cylinder(BW, IR, IR, $fn = 30);
    }
}


module roller(){
    for (i = [0:360 / NR:360]){
        rotate([0, 0, i])
        translate([RPR, 0, WT + LH * 2])//offset roller
        difference(){
            cylinder(RH, RR, RR, , $fn = 30);
            translate([0,0,RH / 2 - WT + LH])
            difference(){       //cage cutout on roller
                cylinder(WT + LH * 4, RR, RR, $fn = 30);
                cylinder(WT + LH * 4, EW * 4, EW * 4, $fn = 14);
            }
        }
    }
        
}

module roller_support(){
    for (i = [0:360 / NR:360]){
        rotate([0, 0, i])
        translate([RPR, 0, 0])//offset roller
        cylinder(WT + LH * 2, RR, RR, , $fn = 30);
        rotate([0, 0, i])
        translate([RPR,0,RH / 2 + LH * 3])
        difference(){       //cage cutout on roller
            cylinder(WT + LH * 4, RR, RR, $fn = 30);
            cylinder(WT + LH * 4, EW * 4, EW * 4, $fn = 14);
        }
    }
        
}

module cage(){
    translate([0,0,WT + RH / 2 - LH])
    difference(){
        cylinder(WT, RPR + EW * 7, RPR + EW * 7);
        cylinder(WT, RPR - EW * 7, RPR - EW * 7);
        for (i = [0:360 / NR:360]){
            rotate([0, 0, i])
            translate([RPR, 0, 0])
            cylinder(WT, EW * 5, EW * 5, $fn = 14);
        }
    }
    
}

module cage_support(){
    translate([0,0,0])
    difference(){
        cylinder(WT + RH / 2 - LH, RPR + EW * 7, RPR + EW * 7);
        cylinder(WT + RH / 2 - LH, RPR - EW * 7, RPR - EW * 7);
        for (i = [0:360 / NR:360]){
            rotate([0, 0, i])
            translate([RPR, 0, 0])
            cylinder(WT, EW * 5, EW * 5, $fn = 14);
        }
    }
    
}

//end of setup

if (support == 0){
    side_wall(0);
    side_wall(BW - WT);
    outer_wall();
    inner_wall();
    roller();
    cage();
} else {
    difference(){
        union(){
            //side_wall_support();
            roller_support();
            cage_support();
        }
            side_wall(0);
        side_wall(BW - WT);
        outer_wall();
        inner_wall();
        roller();
        cage();
    }
}

/*
TODO:
Auto generate number of rollers
*/