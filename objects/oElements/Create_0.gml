// element object
function element(e_name, e_particles) constructor {
	name = e_name;
	particles = e_particles;
}

global.elements = array_create(0);

// fire
fire_particles = part_type_create();
part_type_shape(fire_particles, pt_shape_pixel);
part_type_size(fire_particles, 1, 2, 0.2, 0);
part_type_gravity(fire_particles, 0.05, 90);
part_type_color3(fire_particles, c_yellow, c_orange, c_dkgray);
part_type_alpha2(fire_particles, 0.7, 0.0);
part_type_life(fire_particles, 10, 60);

global.elements[ELEMENTTYPE.FIRE] = new element("Fire", fire_particles);