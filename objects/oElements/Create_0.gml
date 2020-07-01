// statis effects and damage
enum ELEMENTTYPE {
	PHYSICAL,
	FIRE,
	LIGHTNING
}

// element object
function element(e_name, e_particles, e_color) constructor {
	name = e_name;
	particles = e_particles;
	color = e_color;
}

global.elements = array_create(0);

// Physical
global.elements[ELEMENTTYPE.PHYSICAL] = new element("Physical", -1, c_dkgray);

// fire
fire_particles = part_type_create();
part_type_sprite(fire_particles, sFlame_particle, true, true, false);
part_type_size(fire_particles, 0.2, 1, 0.0, 0.0);
part_type_speed(fire_particles, 1, 2, -0.05, 0);
part_type_direction(fire_particles, 90, 90, 0.0, 0.0);
part_type_alpha2(fire_particles, 1, 0.0);
part_type_life(fire_particles, 10, 60);

global.elements[ELEMENTTYPE.FIRE] = new element("Fire", fire_particles, merge_color(c_orange, c_red, 0.1));

// lightning
lightning_particles = part_type_create();
part_type_sprite(lightning_particles, sLightning_particle, true, true, false);
part_type_size(lightning_particles, 0.1, 1, 0.0, 0.0);
part_type_orientation(lightning_particles,0, 360, 0.0, 0.0, 0.0);
part_type_life(lightning_particles, 10, 20);

global.bolted = ds_list_create();

global.elements[ELEMENTTYPE.LIGHTNING] = new element("Lightning", lightning_particles, c_yellow);