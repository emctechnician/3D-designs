/*
This is for generating designs for roller bearings.
Printed with a soluble support material. I used HIPS and ABS.

You must manually state the number of roller (NR), i'd suggest
as many rollers you can fit. This changes depending on the size
of bearing.

Outer diameter less inner diameter must be greater than 20.4
(this is limited by the roller size) 

Instructions to print:
Set the modifiable variables with printer settings, bearing size, number of rollers.
Export soluble support STL with variable set to 1 (yes) and bearing STL with variable set to 0 (no).
Using slic3r load the bearing STL and soluble support STL.
Set the follwing part settings for each STL.
    
    For soluble support:
        -Extruder                       soluble material (HIPS)
        -Top solid layers               1
        -Solid bottom layers            0
        -Perimeters                     0
        -Solid infill threashold area   1mm^2 
    
    For bearing:
        -Extruder                       solid material (ABS)
        -Top solid layers               3
        -Solid bottom layers            3
        -Perimeters                     5
*/

//start of modifiable variables
support =   1;          //Generate soluble support 1 = yes, 0 = no  
BW      =   10;         //Bearing width Z axis
EW      =   0.3;        //extrusion width
LH      =   0.2;        //layer height
ID      =   8.6;        //inner diameter
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
                cylinder(WT + LH * 4, EW * 5, EW * 5, $fn = 14);
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
            cylinder(WT + LH * 4, EW * 5, EW * 5, $fn = 14);
        }
    }
        
}

module cage(){
    translate([0,0,WT + RH / 2 - LH])
    difference(){
        cylinder(WT, RPR + EW * 8, RPR + EW * 8);
        cylinder(WT, RPR - EW * 8, RPR - EW * 8);
        for (i = [0:360 / NR:360]){
            rotate([0, 0, i])
            translate([RPR, 0, 0])
            cylinder(WT, EW * 6, EW * 6, $fn = 14);
        }
    }
    
}

module cage_support(){
    translate([0,0,0])
    difference(){
        cylinder(WT + RH / 2 - LH, RPR + RR - WW, RPR + RR - WW);
        cylinder(WT + RH / 2 - LH, RPR - RR + WW, RPR - RR + WW);
        for (i = [0:360 / NR:360]){
            rotate([0, 0, i])
            translate([RPR, 0, 0])
            cylinder(WT, EW * 6, EW * 6, $fn = 14);
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
            side_wall_support();
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