include <fin.scad>;


// BODY TUBE CUSTOMIZER
// --------------------

// Type of body tube.
Body_Tube_Inner_Diameter = 24; // [13, 18, 24, 29, 33, 38, 56, 66]
Body_Tube_Slop = 0.90;
Body_Tube_Thickness = 1.25;
Body_Tube = false;
Body_Tube_Height = 207;


body_tube_inner_diameter = Body_Tube_Inner_Diameter + Body_Tube_Slop;
body_tube_outer_diameter = Body_Tube_Inner_Diameter+Body_Tube_Slop + Body_Tube_Thickness;


// FIN CUSTOMIZER
// --------------

Fins = false;
Fin_Count = 1;
Fin_Cant = 0;
Fin_Thickness = 2.5;
Fin_Root_Chord_Length = 170;
Fin_Tip_Chord_Length = 43;
Fin_Height = 69;
Fin_Sweep_Length = 127;
Fin_Body_Position  = 0;
Fin_Slope = 1;

Aileron_X_Position = 10;
Aileron_Width = 50;
Aileron_Height = 10;

difference() {

trapezoidal_fin_sloped(root_chord_length=Fin_Root_Chord_Length, tip_chord_length=Fin_Tip_Chord_Length, height=Fin_Height, sweep_length=Fin_Sweep_Length, thickness=Fin_Thickness, slope=Fin_Slope);

translate([Aileron_X_Position,Fin_Root_Chord_Length-Aileron_Height,0])
cube([Aileron_Width, Aileron_Height, Fin_Thickness]);    

}