use <tubes/coupler_tube.scad>;

module ejection_baffle_disc(outer_diameter, hole_count, hole_diameter, disc_thickness) {
    
    difference() {
        cylinder(h=disc_thickness, d=outer_diameter);
    
        for (i = [0:hole_count]) {
            disc_spacing = 360 / hole_count;
            rotate([0,0,disc_spacing*i])
            translate([0,outer_diameter/2 - hole_diameter,0])
            cylinder(h=disc_thickness, d=hole_diameter);
        }
    }
}


// Demonstration of assembled ejection baffle inside a coupler tube with disected cross section
$fn=100;

module baffle_demo() {
    tube_height = 50;
    coupler_tube(inner_diameter=22.75, outer_diameter=24, thickness=2, height=tube_height);

    baffle_od = 22.75;
    baffle_holes = 3;
    baffle_holes_diameter = 4.5;
    baffle_disc_thickness = 3;
    
    angle = 45;
    
    ejection_baffle_disc(baffle_od, baffle_holes, baffle_holes_diameter, baffle_disc_thickness);
    
    for (i = [1:3]) {
        translate([0,0,(tube_height/3)*i - baffle_disc_thickness])
        rotate([0,0,angle*i])
        ejection_baffle_disc(baffle_od, baffle_holes, baffle_holes_diameter, baffle_disc_thickness);
    }
}

baffle_demo();

// Baffle cross-section
translate([0,50,0])
difference() {
    baffle_demo();
    
    translate([0,-12.5,0])
    cube([50,25,50]);

}