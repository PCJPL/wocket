include <../constants.scad>;

use <../engine_block.scad>;
use <tube.scad>;
use <../motor_clip.scad>;


module motor_mount_tube(inner_diameter, outer_diameter, height, motor_clip, motor_clip_params, engine_block_params) {
    
    // motor_clip_params = [Width, Thickness, Height]
    motor_clip_width = motor_clip_params[0];
    motor_clip_thickness = motor_clip_params[1];
    motor_clip_z = motor_clip_params[2];
    
    // engine_block_params = [Engine Block Inner Diameter, Engine Block Thickness];
    engine_block_id = engine_block_params[0];
    engine_block_thickness = engine_block_params[1];
    

    translate([0,0,height-motor_clip_z-engine_block_thickness])
    engine_block(
        id=engine_block_id, 
        od=outer_diameter,
        thickness=engine_block_thickness
    );
    
    if (motor_clip) {
    
        difference() {
            tube(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height);
        
            translate([-motor_clip_width/2,inner_diameter/2-0.2, height-motor_clip_z])
            motor_clip_cutout(motor_clip_width, motor_clip_thickness, outer_diameter-inner_diameter);
        }
    } else {
        tube(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height);  
    }
}