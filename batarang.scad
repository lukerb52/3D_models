T = 0.5; // Thickness

N = 50; // Polygon Count

CR = 2; // Center Radius
WR = 7; // wing radius
WCX = -WR/1.3; // Wing Coordinate x
WCY = -WR/1.7;
DK = 0.75*WR; // idk
RR=WR/3;
IRX = WR*1.3; // outermost
IIRX = IRX-RR; // middle
IIIRX = WR/2; // innermost
WRR = WR*1.3; // Wing removal radius

module copy_mirror(vec=[1,0,0])
{
    children();
    mirror(vec) children();
}

cylinder(T,CR,CR,center=true,$fn=N);

// EARS
copy_mirror([1,0,0])
    linear_extrude(T,center=true)
        polygon(points=[[-0.2,1.5],[-1.2,1.5],[-1.2,3]]);

copy_mirror([1,0,0]) difference(){
    // LARGER CIRCLE WING
    union(){
        translate([WCX,WCY,0])
            cylinder(T,WR,WR,center=true,$fn=N);
        
    }

    // BLADED EDGE
    translate([WCX,WCY,0])
    rotate_extrude(convexity = N,$fn=N)
    translate([WR+.1, 0, 0])
        rotate([0,0,-90])
        union(){
            translate([-1,0,0])rotate([0,0,-17])square(2,center=true);
            translate([1,0,0])rotate([0,0,17])square(2,center=true);
    //}
}
    // WING REMOVAL
    translate([-DK,-2*DK,0])
        cylinder(T*2,WRR,WRR,center=true,$fn=N);
        
    // FINS
    translate([-IRX*1.2,-WRR/1.5,0])
        cylinder(T*2,RR,RR,center=true,$fn=N);
    translate([-IRX,-WRR/2.2,0])
        cylinder(T*2,RR,RR,center=true,$fn=N);
    translate([-IIRX,-WRR/3,0])
        cylinder(T*2,RR,RR,center=true,$fn=N);
    translate([-IIIRX,-WRR/3,0])
        cylinder(T*2,RR,RR,center=true,$fn=N);
}



//rotate_extrude(convexity = N,$fn=N)
//translate([WR, 0, 0])
//    rotate([0,0,-90])union(){
    //translate([-1,0,0])rotate([0,0,-22.5])square(2,center=true);
    //translate([1,0,0])rotate([0,0,22.5])square(2,center=true);
//}

//rotate_extrude(convexity = 10, $fn = 100)
//translate([2, 0, 0])
//square(1);

//probe(volume=true) {
//   batarang(); // the thing to measure
//    echo("volume=",volume," centroid=",centroid);
//    %thing();
//    color("red") translate(centroid) sphere(r=1,$fn=32);
//} 