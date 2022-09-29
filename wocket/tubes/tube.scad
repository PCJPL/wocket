module tube(height, inner_diameter, outer_diameter) {
    difference() {
        cylinder(h=height, d=outer_diameter);
        cylinder(h=height, d=inner_diameter);
    }
}
