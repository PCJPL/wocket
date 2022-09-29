use <tubes/coupler_tube.scad>;
use <misc.scad>;

module ejection_charge_baffle(type, outer_diameter, hole_count, hole_diameter, disc_thickness) {
    if (type=="Hole") {
        difference() {
            cylinder(h=disc_thickness, d=outer_diameter);
    
            for (i = [0:hole_count]) {
                disc_spacing = 360 / hole_count;
                rotate([0,0,disc_spacing*i])
                translate([0,outer_diameter/2 - hole_diameter,0])
                cylinder(h=disc_thickness, d=hole_diameter);
            }
        }
    } else if (type=="Half Disc") {
        half_disc(h=disc_thickness, d=outer_diameter);
    }
}

// Type of body tube.
Body_Tube_Inner_Diameter = 24; // [13, 18, 24, 29, 33, 38, 56, 66]
Body_Tube_Slop = 0.75;
Body_Tube_Thickness = 1.25;
Body_Tube = false;
Body_Tube_Height = 207;


body_tube_inner_diameter = Body_Tube_Inner_Diameter + Body_Tube_Slop;
body_tube_outer_diameter = Body_Tube_Inner_Diameter+Body_Tube_Slop + Body_Tube_Thickness;


// Include a coupler tube?
Coupler_Tube = false;
Coupler_Tube_Thickness = 1.75;
Coupler_Tube_Height = 20;
Coupler_Tube_Slop = 0.5;

coupler_tube_outer_diameter = body_tube_inner_diameter - Coupler_Tube_Slop;
coupler_tube_inner_diameter = coupler_tube_outer_diameter - Coupler_Tube_Thickness;

// Include an ejection baffle disc (to be placed inside the coupler tube)?
Ejection_Charge_Baffle = true;
Ejection_Charge_Baffle_Type = "Half Disc"; // ["Hole", "Half Disc"]
Ejection_Baffle_Hole_Count = 4;
Ejection_Baffle_Hole_Diameter = 4.5;
Ejection_Baffle_Disc_Thickness = 2;
Ejection_Baffle_Disc_Slop = 0.5;

ejection_baffle_disc_outer_diameter = coupler_tube_inner_diameter - Ejection_Baffle_Disc_Slop;

ejection_charge_baffle(Ejection_Charge_Baffle_Type, ejection_baffle_disc_outer_diameter, Ejection_Baffle_Hole_Count, Ejection_Baffle_Hole_Diameter, Ejection_Baffle_Disc_Thickness);