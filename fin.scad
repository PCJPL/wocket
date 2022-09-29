module trapezoidal_fin(root_chord_length, tip_chord_length, height, sweep_length, thickness) {
        linear_extrude(thickness)
        polygon([
            [0,0],
            [height, sweep_length], 
            [height, sweep_length+tip_chord_length],
            [0, root_chord_length], 
            
        ]);
}

module trapezoidal_fin_sloped(root_chord_length, tip_chord_length, height, sweep_length, thickness, slope) {
    
    hull() {
        trapezoidal_fin_2d(root_chord_length, tip_chord_length, height, sweep_length, 0.1);
    
        translate([0,slope,thickness])
        trapezoidal_fin_2d(root_chord_length-slope, tip_chord_length-slope, height-slope, sweep_length-slope, thickness/2);
    }

}

module trapezoidal_fin_2d(root_chord_length, tip_chord_length, height, sweep_length, thickness) {
        polygon([
            [0,0],
            [height, sweep_length], 
            [height, sweep_length+tip_chord_length],
            [0, root_chord_length], 
            
        ]);
}

module trapezoidal_fins(body_tube_diameter, fin_cant, count, root_chord_length, tip_chord_length, height, sweep_length, thickness, fin_body_position){
    fin_spacing = 360 / count;
    translate([0,0,root_chord_length+fin_body_position])
    
	for(i = [1 : count ]){
		rotate ([0,0,i*fin_spacing])
        translate ([body_tube_diameter/2-0.1, -thickness/2]) 
        rotate ([-90+fin_cant,0,0]) 
        trapezoidal_fin(root_chord_length, tip_chord_length, height, sweep_length, thickness);
	}
}