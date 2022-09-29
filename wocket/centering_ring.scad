include <constants.scad>;
use <tubes/tube.scad>;
use <motor_clip.scad>;

module centering_ring(inner_diameter, outer_diameter, height, motor_clip, motor_clip_params) {
    motor_clip_width = motor_clip_params[0];
    motor_clip_thickness = motor_clip_params[1];
    
    if (motor_clip) {
        difference() {
            tube(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height); 
        
            translate([-motor_clip_width/2,inner_diameter/2-0.2,0])
            motor_clip_cutout(
                width=motor_clip_width,
                height=height,
                thickness=motor_clip_thickness
            );  
        }
    } else {
        tube(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height); 
    }
}
