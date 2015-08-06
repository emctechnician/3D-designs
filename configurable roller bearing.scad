BW  =   10;         //Bearing width Z axis
EW  =   0.3;        //extrusion width
LH  =   0.2;        //layer height
ID  =   8.1;          //inner diameter
OD  =   31;         //outer diameter
//OD - ID must not be less than 20.4
if ((OD - ID) < 20.4){
    echo("OD - ID is less than 20.4");
}

WW  =   round(1 / EW) * EW + EW;     //Wall width XY axis
WT  =   round(1 / LH) * LH + LH;     //wall width Z axis

OR  =   OD / 2;             //Outer radius
IR  =   ID / 2;             //Inner radius
SR  =   (OD + ID) / 4;      //Split radius

NR  =   7;                     //Number of rollers, could auto generate this?
RR  =   EW * 12;                //Roller radius, must be larger than EW * 10
RH  =   BW - WT * 2 - LH * 4;   //Roller height
RPR =   OR - WW - RR - EW;      //Roller position radius


module side_wall(z){
    translate([0,0,z])
    difference(){
        cylinder(WT, OR, OR, $fn = 60);   //main sidewall
        difference(){           //Split ring
            cylinder(WT, RPR + WW/2, RPR + WW/2); 
            cylinder(WT, RPR - WW/2, RPR - WW/2);
        }
        cylinder(WT, IR, IR, $fn = 30);
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


module rollers(){
    for (i = [0:360 / NR:360]){
        rotate([0, 0, i])
        translate([RPR, 0, WT + LH * 2])//offset roller
        difference(){
            cylinder(RH, RR, RR, , $fn = 30);
            translate([0,0,RH / 2 - WT + LH * 2])
            difference(){       //cage cutout on roller
                cylinder(WT + LH * 4, RR, RR, $fn = 30);
                cylinder(WT + LH * 4, EW * 4, EW * 4, $fn = 14);
            }
        }
    }
        
}

module cage(){
    translate([0,0,WT + RH / 2])
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

//end of setup


side_wall(0);
side_wall(BW - WT);
outer_wall();
inner_wall();
rollers();
cage();
