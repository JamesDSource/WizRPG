#macro GRAVITY 0.2

visible = false;
draw_function = function drawing_self() {
	draw_sprite_ext(sprite_index, image_index, round(x), round(y - z), image_xscale, image_yscale, image_angle, image_blend, image_alpha);		
}

// moving
hsp = 0;
vsp = 0;
esp = 0;

// interactables
interact_method = noone;
interact_list = ds_list_create();
interact_rad = 10;
interact_entity = noone;

function interact() {
	if(interact_entity != noone && is_method(interact_entity.interact_method)) {
		interact_entity.interact_method(id);
	}
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
		case ELEMENTTYPE.LIGHTNING:
			if(superconductive) statis.electric_charged = true;
			break;
	}
}

function elemental_damage(damage, element) {
	offset_hp(-damage);
	inflict(element);
	
	// look for different elements for effects
	// when taking damage with them
	switch(element) {
		case ELEMENTTYPE.LIGHTNING:
			// if there is still damage remaining
			// create a bolt that chains to other entities
			ds_list_add(global.bolted, id);
			if(floor(damage) > 0) {
				with(instance_create_layer(x, y, "Instances", oLightning_bolt)) {
					lightning_damage = damage/1.5;
					creator = id;
				}
			}
			break;
		
	}
}

statis = {
	fire: 0,
	electric_charged: false
}

spread_rad = 15;
fire_time = room_speed/2;
fire_timer = fire_time;

// particles
particles = part_system_create();
particle_emitter = part_emitter_create(particles);
part_system_automatic_draw(particles, false);

// collisions
dont_collide = ds_list_create();
collided_with = noone;

// push out
function push_out() {
	function check_all(list, x_pos, y_pos) {
		var is_colliding = false;
		for(var i = 0; i < ds_list_size(list); i++) {
			var inst = list[| i];
			if(place_meeting(x_pos, y_pos, inst)) is_colliding = true;
		}
		
		return is_colliding;
	}
	
	var push_list = ds_list_create();
	instance_place_list(x, y, oEntity, push_list, false);
	
	// checking if this object shouldn't be collided with
	var remove_array = array_create(0);
	for(var i = 0; i < ds_list_size(push_list); i++) {
		var inst_id_result = ds_list_find_index(dont_collide, push_list[| i]);
		var inst_obj_result = ds_list_find_index(dont_collide, push_list[| i].object_index);
		
		if(push_list[| i].pass_through || inst_id_result != -1 || inst_obj_result != -1) remove_array[array_length(remove_array)] = i;
		else {
			// if the first result didn't return true
			// check to see if the other instance doesn't 
			// include this instance in it's list
			inst_id_result = ds_list_find_index(push_list[| i].dont_collide, id);	
			inst_obj_result = ds_list_find_index(push_list[| i].dont_collide, object_index);
			if(inst_id_result != -1 || inst_obj_result != -1) remove_array[array_length(remove_array)] = i;
		}
	}
	
	for(var i = array_length(remove_array)-1; i >= 0; i--) {
		var index = remove_array[i];
		ds_list_delete(push_list, index);
	}
	
	
	if(ds_list_size(push_list) > 0) {
		for(var i = 0; i < 100; i++) {
			// right
			if(!check_all(push_list, x + i, y)) {
				x += i;
				break;
			}
			// left
			if(!check_all(push_list, x - i, y)) {
				x -= i;
				break;
			}
			// top
			if(!check_all(push_list, x, y - i)) {
				y -= i;
				break;
			}
			// down
			if(!check_all(push_list, x, y + i)) {
				y += i;
				break;
			}
			// top left
			if(!check_all(push_list, x - i, y - i)) {
				x -= i;
				y -= i;
				break;
			}
				// top right
			if(!check_all(push_list, x + i, y - i)) {
				x += i;
				y -= i;
				break;
			}
			// down left
			if(!check_all(push_list, x - i, y + i)) {
				x -= i;
				y += i;
				break;
			}
			// down right
			if(!check_all(push_list, x + i, y + i)) {
				x += i;
				y += i;
				break; 
			}		
		}
	}
	ds_list_destroy(push_list);
}

