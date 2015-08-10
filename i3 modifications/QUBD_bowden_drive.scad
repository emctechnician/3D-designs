fan_off       = 4.5;
fan_spacing   = 31;
fan_r         = 2;

head_x        = 41.93;
head_y        = 15.02;
head_z        = 9.45;
head_off_x    = 14.5;
head_off_y    = 10.5;
head_spacing  = 12.0;
head_r        = 3.1;

pnu_r         = 2.5;
pnu_clr       = 4;

plate_x       = head_x;
plate_y       = head_x + head_y;
plate_z       = 7;  

//find these
screw_off     = fan_off;
screw_r       = 2;
screw_depth   = 2.37;
screw_r2      = 3.2;

stm_clr       = 3;

difference() {
    union(){
        difference(){
            cube([plate_x, plate_y, plate_z]);
            union(){
                translate([0, head_y * 2, 0]) {
                    cube([fan_off * 2, plate_y, plate_z]);
                    translate([plate_x - fan_off * 2, 0, 0]) cube([fan_off * 2, plate_y, plate_z]);
                }
            }
        }
        translate([0,0,plate_z]) difference(){
            {
                cube([head_x, head_y, head_z]);
            }
            translate([fan_off, 0, head_z - fan_off]){
                rotate([-90,0,0]) {
                    cylinder(h = head_y, r = fan_r);
                    translate([fan_spacing,0,0]) cylinder(h = head_y, r = fan_r);
                }
            }
        }
    }  
    // filament holes
    translate ([
        head_off_x,
        head_off_y,
        0
    ]) {
        {
            cylinder ( h = head_z + plate_z, r = 1.25 );
            cylinder ( h = pnu_clr, r = pnu_r);
        }
        translate([head_spacing,0,0]) {
            cylinder ( h = head_z + plate_z, r = 1.25 );
            cylinder ( h = pnu_clr, r = pnu_r);
        }
    };
    
    // stm clearance
    translate ([ 0, head_y, plate_z - stm_clr]) cube([plate_x, plate_y, plate_z]);
    
    //screw holes
    translate ([ screw_off, head_y + screw_off, 0 ]){
        {
            cylinder( h = plate_z, r = screw_r, $fn=6 );
            translate([0,0,plate_z - stm_clr - screw_depth]) cylidner( h = plate_z, r = screw_r2, $fn=6 );
        }
        translate([plate_x - screw_off * 2, 0, 0]){
            cylinder( h = plate_z, r = screw_r, $fn=6 );
            translate([0,0,plate_z - stm_clr-1]) cylidner( h = plate_z, r = screw_r2, $fn=6 );
        }
    }
}