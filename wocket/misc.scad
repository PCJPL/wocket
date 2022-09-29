module fail(message) {
    assert(false, message);
}

module half_disc(d, h) {
    difference() { 
        cylinder(h=h, d=d);
        translate([-d/2,-d/2,0])
        cube([d,d/2,h]);
    }
}