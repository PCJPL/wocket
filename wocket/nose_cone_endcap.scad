use <tubes/tube.scad>;

$fn=100;
module nose_cone_endcap(diameter, height, loop, loop_params) {
    
    loop_inner_diameter = loop_params[0];
    loop_outer_diameter = loop_params[1];
    loop_thickness      = loop_params[2];
    

    cylinder(d=diameter, h=height);

    difference() {    
        
        translate([-loop_thickness/2,0,height]) {
        rotate([0,90,0])
        tube(height=loop_thickness, inner_diameter=loop_inner_diameter, outer_diameter=loop_outer_diameter);
            
    }
    translate([0,0,-loop_outer_diameter])
    cylinder(d=diameter, h=loop_outer_diameter);
    }
}

nose_cone_endcap(diameter=40, height=5, loop=true, loop_params=[10,15,2.5]);