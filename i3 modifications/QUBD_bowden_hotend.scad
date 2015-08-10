//pnu_head

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

screw_clr     = 5;

fat           = 2 * fan_off;

main = [
    head_x, 
    head_y,
    head_x - head_z,
];
    
rotate([-90,0,0]) difference() {
    cube(main);
    // head holes
    translate ([
        head_off_x,
        head_off_y,
        0
    ]) {
        {
            cylinder ( h = screw_clr, r = head_r );
            translate([0, 0, main[2] - pnu_clr]) cylinder ( h = pnu_clr, r = pnu_r);
            cylinder ( h = main[2], r = 1.25 );
        }
        translate([head_spacing,0,0]) {
            cylinder ( h = screw_clr, r = head_r );
            translate([0, 0, main[2] - pnu_clr]) cylinder ( h = pnu_clr, r = pnu_r);
            cylinder ( h = main[2], r = 1.25 );
        }
    }
    // fan holes
    translate([fan_off, 0, main[2] - fan_off]){
        rotate([-90,0,0]) {
            cylinder(h = main[1], r = fan_r);
            translate([fan_spacing,0,0]) cylinder(h = main[1], r = fan_r);
         }
     }  
     // fat trimming
     cube([fat, main[1], main[2] - 2 * fan_off]);
     translate([main[0]-fat,0,0])cube([fat, main[1], main[2] - 2 * fan_off]);
     cube([main[0], head_off_y - 2 * head_r, main[2] - 2 * fan_off]);
     
}
    
    
    