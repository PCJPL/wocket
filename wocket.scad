use <nose_cone.scad>;
use <nose_cone_endcap.scad>;
use <centering_ring.scad>;
use <engine_block.scad>;
use <fin.scad>;
use <tubes/motor_mount_tube.scad>;
use <tubes/coupler_tube.scad>;
use <tubes/tube.scad>;
use <misc.scad>;

use <ejection_charge_baffle.scad>;

// Resolution of OpenSCAD rendering. Increase to 100 or greater for final export.
$fn = 100;

// The amount of gap added to the dimensions of parts that must fit inside one another.
Slop = 0.5;

// Increases additional wall thickness, because 3D printed parts with the same thickness don't always work as well as their cardboard equivalents. 
// If larger than 0, the outer dimeter of parts will increase and no longer be dimensionally interchangable with the parts they are named after.
$Wall_Thickness_Modifier = 0;

// Spacing between parts when rendering and exporting for printing.
Inter_Part_Spacing = 50;

// BODY TUBE CUSTOMIZER
// --------------------

// Type of body tube.
Body_Tube_Inner_Diameter = 24; // [13, 18, 24, 29, 33, 38, 56, 66]
Body_Tube_Slop = 0.80;
Body_Tube_Thickness = 1.25;
Body_Tube = false;
Body_Tube_Height = 207;


body_tube_inner_diameter = Body_Tube_Inner_Diameter + Body_Tube_Slop;
body_tube_outer_diameter = Body_Tube_Inner_Diameter+Body_Tube_Slop + Body_Tube_Thickness;


// NOSE CONE CUSTOMIZER
// --------------------

Nose_Cone = false;
Nose_Cone_Type = "Elliptical"; // [Elliptical, Conical, Tangent Ogive]
Nose_Cone_Wall_Thickness = 1.25;
nose_cone_outer_diameter = body_tube_outer_diameter;
nose_cone_inner_diameter = nose_cone_outer_diameter - Nose_Cone_Wall_Thickness;
Nose_Cone_Height = 100;

nose_cone_resolution = 150;

// NOSE CONE ENDCAP
// ---------------------------

// Render a nose cone endcap?
Nose_Cone_Endcap = false;

// Fitment tolerances for the nose cone endcap.
Nose_Cone_Endcap_Slop = 0.75;

// Height of the nose cone endcap
Nose_Cone_Endcap_Height = 5;

Endcap_Loop = true;
Endcap_Loop_ID = 8;
Endcap_Loop_OD = 15;
Endcap_Loop_Thickness = 4;

endcap_loop_params = [Endcap_Loop_ID, Endcap_Loop_OD, Endcap_Loop_Thickness];
nose_cone_endcap_diameter = nose_cone_inner_diameter - Nose_Cone_Endcap_Slop;


// COUPLER TUBE CUSTOMIZER
// -----------------------

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

// Diameter of the motor to be used. This will inform the diameter of a motor mount.
Motor_Size = 18; // [13, 18, 24, 29]



// MOTOR MOUNT TUBE
// ---------------------------

// Render a motor mount?
Motor_Mount_Tube = false;
Motor_Mount_Tube_Slop = 0.25;
// Wall thickness of the motor mount.
Motor_Mount_Tube_Thickness = 1.25;
// Height of the motor mount. Should be long enough to fit your chosen motor.
Motor_Mount_Tube_Height = 70;
Motor_Mount_Tube_Clip_Height = 10;

motor_mount_tube_outer_diameter = Motor_Size + Motor_Mount_Tube_Thickness+Motor_Mount_Tube_Slop;
motor_mount_tube_inner_diameter = Motor_Size+Motor_Mount_Tube_Slop;


// MOTOR CLIP CUSTOMIZER
// ---------------------

Motor_Clip = true;
Motor_Clip_Width = 3.35;
Motor_Clip_Thickness = 0.70;
Motor_Clip_Slop = 0.3;

motor_clip_width = Motor_Clip_Width + Motor_Clip_Slop;
motor_clip_params = [motor_clip_width, Motor_Clip_Thickness+Motor_Clip_Slop, Motor_Mount_Tube_Clip_Height];


// CENTERING RING CUSTOMIZER
// -------------------------

// Renders a centering ring. The dimensions are determined by the outer diameter of a motor mount and the inner diameter of a body tube.
Centering_Ring = false;
// Fit tolerances for the Centering Ring
Centering_Ring_Slop = 0.85;
// Height of the centering ring.
Centering_Ring_Height = 5;

// Inner diameter for the centering ring, based on the motor mount OD.
centering_ring_inner_diameter = motor_mount_tube_outer_diameter + Centering_Ring_Slop;
centering_ring_outer_diameter = Body_Tube_Inner_Diameter;


// FIN CUSTOMIZER
// --------------

Fins = false;
Fin_Count = 3;
Fin_Cant = 0;
Fin_Thickness = 2;
Fin_Root_Chord_Length = 20;
Fin_Tip_Chord_Length = 5;
Fin_Height = 15;
Fin_Sweep_Length = 0;
Fin_Body_Position  = 0;

// ENGINE BLOCK CUSTOMIZER
// -----------------------

engine_block_inner_diameter = 0.75 * motor_mount_tube_outer_diameter;
// Height of the engine block. Also the amount that the motor will hang out the back of the mount.
Engine_Block_Thickness = 2;

engine_block_params = [engine_block_inner_diameter, Engine_Block_Thickness];


echo ("Slop");
echo("-------");

echo ("Body Tube to Centering Ring", body_tube_inner_diameter-centering_ring_outer_diameter);
echo ("Centering Ring to Motor Mount Tube", centering_ring_inner_diameter-motor_mount_tube_outer_diameter);




// PART RENDERING
// --------------

// Nose Cone
if (Nose_Cone) {
    difference() {
    
    nose_cone(type=Nose_Cone_Type, wall_thickness=Nose_Cone_Wall_Thickness, diameter=nose_cone_outer_diameter, height=Nose_Cone_Height, s = nose_cone_resolution);
    translate([-25,-25,10])
        cube([50,50,100]);
        }
    echo("Nose Cone OD", nose_cone_outer_diameter);
    echo("Nose Cone ID", nose_cone_inner_diameter);
}

// Nose Cone Endcap
if (Nose_Cone_Endcap) {
    
    translate([Inter_Part_Spacing, 0, 0])
    nose_cone_endcap(nose_cone_endcap_diameter, Nose_Cone_Endcap_Height, Endcap_Loop, endcap_loop_params);
    echo("Nose Cone Endcap Diameter", nose_cone_endcap_diameter);
}

// Motor Mount Tube
if (Motor_Mount_Tube) {
    echo("Motor Mount ID", Motor_Size);
    echo("Motor Mount OD", motor_mount_tube_outer_diameter);
    
    translate([Inter_Part_Spacing, Inter_Part_Spacing, 0])
    motor_mount_tube(
        inner_diameter=motor_mount_tube_inner_diameter, 
        outer_diameter=motor_mount_tube_outer_diameter, 
        height=Motor_Mount_Tube_Height, 
        motor_clip=Motor_Clip,
        motor_clip_params=motor_clip_params,
        engine_block_params=engine_block_params
    );
}

// Centering Ring
if (Centering_Ring) {
    
    echo("Centering Ring ID", centering_ring_inner_diameter);
    echo("Centering Ring OD", centering_ring_outer_diameter);
    
    translate([Inter_Part_Spacing*2, 0,0])
    centering_ring(
        inner_diameter=centering_ring_inner_diameter, 
        outer_diameter=centering_ring_outer_diameter, 
        height=Centering_Ring_Height,
        motor_clip=Motor_Clip,
        motor_clip_params=motor_clip_params
    );
}

   

// Body tube
if (Body_Tube) {
    echo("Body Tube ID", body_tube_inner_diameter);
    echo("Body Tube OD", body_tube_outer_diameter);
    
    assert(motor_mount_tube_outer_diameter < body_tube_inner_diameter, "Motor mount will not fit inside the body tube.");
    
    translate([0, Inter_Part_Spacing, 0])
    tube(inner_diameter=body_tube_inner_diameter, outer_diameter=body_tube_outer_diameter, height=Body_Tube_Height);
}


// Coupler tube
if (Coupler_Tube) {
    
    echo("Coupler Tube ID", coupler_tube_inner_diameter);
    echo("Coupler Tube OD", coupler_tube_outer_diameter);
 
    translate([Inter_Part_Spacing*2, Inter_Part_Spacing, 0])
    coupler_tube(coupler_tube_inner_diameter, coupler_tube_outer_diameter, Coupler_Tube_Thickness, Coupler_Tube_Height);
}

// Fins
if (Fins) {
    translate([0, Inter_Part_Spacing, 0])
    trapezoidal_fins(body_tube_diameter=body_tube_outer_diameter, fin_cant=Fin_Cant, count=Fin_Count, root_chord_length=Fin_Root_Chord_Length, tip_chord_length=Fin_Tip_Chord_Length, height=Fin_Height, sweep_length=Fin_Sweep_Length, thickness=Fin_Thickness, fin_body_position=Fin_Body_Position);

} 

// Ejection Charge Baffle
if (Ejection_Charge_Baffle) {
    translate([0, Inter_Part_Spacing*2,0])
    ejection_charge_baffle(Ejection_Charge_Baffle_Type, ejection_baffle_disc_outer_diameter, Ejection_Baffle_Hole_Count, Ejection_Baffle_Hole_Diameter, Ejection_Baffle_Disc_Thickness);
}


if (Body_Tube==true && Centering_Ring==true) {
    assert(centering_ring_outer_diameter < body_tube_inner_diameter, "Centering ring will not fit inside the body tube.");
}

if (Body_Tube && Nose_Cone_Endcap) {
    assert(nose_cone_endcap_diameter < body_tube_inner_diameter, "Nose cone endcap will not fit into the body tube!");
}

if (Body_Tube && Nose_Cone) {
    assert(body_tube_outer_diameter == nose_cone_outer_diameter, "Nose cone and body tube have different diameters!");
}

if (Body_Tube && Coupler_Tube) {
    assert(coupler_tube_outer_diameter < body_tube_inner_diameter, "Coupler tube will not fit in body tube!");
}