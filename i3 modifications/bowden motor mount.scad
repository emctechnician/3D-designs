/*

		A B	  C  D
	| a|b|	c |d |
	 __________ 		_		_E
	|		     |		e		
	|--	 _	-- __|		_-- EM	_
	|	| |	  |			f		 F
	|__	| |	  |			_		_	
		  |	  |			g		 G	
		  |	__|			_		_
								 H

*/

LH = 	0.248;		//layer height
EW = 	0.4;		//extrusion width
a  = 	8 * EW;	 
b	=	7;			//chassis width
c  = 	a;			
d	=	42;
e	=	13;
f	=	10;
g	=	20;
MW  =   42;         //width of mount

	A = a;
	B = a + b;
	C = a + b + c;	
	D = a + b + c + d;

	E = e + f + g;
	F = f + g;
	G = g;
	H = 0;

module x_axis(a,b,c,d,e,f,g){
	A = a;
	B = a + b;
	C = a + b + c;	
	D = a + b + c + d;

	E = e + f + g;
	F = f + g;
	G = g;
	H = 0;

	

	polygon([
		[0,E],
		[D,E],
		[D,F],
		[C,F],
		[C,H],
		[B,H],
		[B,F],
		[A,F],
		[A,G],
		[0,G],
	]);
}

difference(){
	linear_extrude(height=MW) 	x_axis(a,b,c,d,e,f,g); //main body
    
	for (i = [[C+5.5,F,(MW-31)/2],
              [C+5.5,F,(MW-31)/2 + 31],
              [C+5.5+31,F,(MW-31)/2]]){ 
                  
		translate(i) rotate([270,0,0]) 
                  cylinder(e,1.5,1.5, $fn = 12);//motor mount holes
	}
	
    
    translate([C + 5.5 + 31/2, F, MW/2])rotate([270,0,0])
    union(){
        cylinder(3,11.5,11.5, $fn=30); //motor flange
        cylinder(e,6,6, $fn=20);  //hobbed gear
        translate([0,-28,0]) cube(22,18,e); //tensioner arm
        translate([0,-16,0]) cylinder(e,13,13); //tension bearing
        translate([0,-3.5,9]) rotate([0,90,0]) cylinder(100,1,1, center = true, $fn=10); //filament guide
    }
    translate([0,F+9,MW/2 + 3.5]) rotate([0,90,0]) cylinder(4,1.9,1.9, $fn=12);//bowden socket
}
translate([D,F + e/2,14]) rotate([0,90,0]) cylinder(3,3.7,3.7,$fn=20); //spring holder