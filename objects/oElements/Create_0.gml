// statis effects and damage
enum ELEMENTTYPE {
	PHYSICAL,
	FIRE
}

// element object
function element(e_name, e_particles) constructor {
	name = e_name;
	particles = e_particles;
}

global.elements = array_create(0);

fire_particles = part_type_create();
part_type_sprite(fire_particles, sFlame_particle, true, true, false);
part_type_size(fire_particles, 0.2, 1, 0.0, 0.0);
part_type_speed(fire_particles, 1, 2, -0.05, 0);
part_type_direction(fire_particles, 90, 90, 0.0, 0.0);
part_type_alpha2(fire_particles, 1, 0.0);
part_type_life(fire_particles, 10, 60);

global.elements[ELEMENTTYPE.FIRE] = new element("Fire", fire_particles);