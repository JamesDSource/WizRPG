visible = false;

// moving
hsp = 0;
vsp = 0;
esp = 0;

// interactables
interact_method = noone;
interact_list = ds_list_create();
interact_margin = 15;
interact_entity = noone;

function interact() {
	if(interact_entity != noone && is_method(interact_entity.interact_method)) {
		interact_entity.interact_method(id);
	}
}

// statis effects and damage
enum ELEMENTTYPE {
	PHYSICAL,
	FIRE
}

// for dealing damage with statis effects
random_tick_time = room_speed * 2;
random_tick_timer = random_tick_time;

function offset_hp(offset) {
	hp += offset;
	hp = clamp(hp, 0, hp_max);
}

function inflict(element) {
	switch(element) {
		case ELEMENTTYPE.FIRE:
			if(statis.fire <= 0) statis.fire = material_flammability;
			break;
		
	}
}

statis = {
	fire: 0
}

spread_rad = 8;
fire_time = room_speed/2;
fire_timer = fire_time;

// particles
particles = part_system_create();
particle_emitter = part_emitter_create(particles);
part_system_automatic_draw(particles, false);

// shadow
if(has_shadow) {
	shadow = instance_create_layer(x, y, layer, oEntity_shadow);
	shadow.creator = id;
}