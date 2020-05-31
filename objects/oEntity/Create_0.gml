visible = false;

// moving
hsp = 0;
vsp = 0;

// interactables
interact_method = noone;
interact_list = ds_list_create();
interact_radius = 20;
interact_entity = noone;

function interact() {
	if(interact_entity != noone) {
		interact_entity.interact_method(id);
	}
}

// statis effects and damage
enum ELEMENTTYPE {
	PHYSICAL,
	FIRE
}

// for dealing damage with statis effects
function offset_hp(offset) {
	hp += offset;
	hp = clamp(hp, 0, hp_max);
}

function inflict(element) {
	switch(element) {
		case ELEMENTTYPE.FIRE:
			if(material_flammable) statis.on_fire = room_speed * 2;
			break;
		
	}
}

statis = {
	on_fire: 0
}