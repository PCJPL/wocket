use <tubes/tube.scad>;

module engine_block(id, od, thickness) {
    tube(inner_diameter=id, outer_diameter=od, height=thickness);
}