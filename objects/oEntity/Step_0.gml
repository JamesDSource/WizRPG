var delta = get_delta();

#region movement
	if(!static_object) {
		// gravity
		esp -= GRAVITY;
	
		// movement with acceleration
		hsp = approach(hsp, lengthdir_x(target_speed, dir) * delta, acceleration * delta);
		vsp = approach(vsp, lengthdir_y(target_speed, dir) * delta, acceleration * delta);
		
		// collision code
		if(hsp != 0 || vsp != 0 || esp != 0) {
			var collision_list = ds_list_create();
			
			// horizontal collision checking
			instance_place_list_3d(x + hsp, y, z, oEntity, collision_list, true);
			for(var i = 0; i < ds_list_size(collision_list); i++) {
				var inst = collision_list[| i];
				if(!inst.pass_through) {
					repeat(floor(hsp)) {
						if(!place_meeting_3d(x + sign(hsp), y, z, inst)) x += sign(hsp);
						else break;
					}
					hsp = 0;
					break;
				}
			}
			ds_list_clear(collision_list);
			
			// verticle collision code
			instance_place_list_3d(x, y + vsp, z, oEntity, collision_list, true);
			for(var i = 0; i < ds_list_size(collision_list); i++) {
				var inst = collision_list[| i];
				if(!inst.pass_through) {
					repeat(floor(vsp)) {
						if(!place_meeting_3d(x, y + sign(vsp), z, inst)) y += sign(vsp);
						else break;
					}
					vsp = 0;
					break;
				}
			}
			ds_list_clear(collision_list);
			
			// elevation collision code
			instance_place_list_3d(x, y, z + esp, oEntity, collision_list, true);
			for(var i = 0; i < ds_list_size(collision_list); i++) {
				var inst = collision_list[| i];
				if(!inst.pass_through) {
					repeat(floor(esp)) {
						if(!place_meeting_3d(x, y, z + sign(esp), inst)) z += sign(esp);
						else break;
					}
					esp = 0;
					break;
				}
			}
			ds_list_destroy(collision_list);
		
		x += hsp;
		y += vsp;
		z += esp;
		z = max(z, 0);
		}
	}
#endregion
#region Interactables
	ds_list_clear(interact_list);
	collision_rectangle_list_3d(bbox_left - interact_rad, bbox_top - interact_rad, z - interact_rad, bbox_right + interact_rad, bbox_bottom + interact_rad, z + h + interact_rad, oEntity, interact_list, true);

	// adds any entity's index that does not have an interact function
	// to a seperate array to be deleted
	var delete_indexs = array_create(0);
	for(var i = 0; i < ds_list_size(interact_list); i++) {
		var inst = interact_list[| i];	
		if(!is_method(inst.interact_method)) delete_indexs[array_length(delete_indexs)] = i;
	}

	// deletes the un-interactable entities from the list
	for(var i = 0; i < array_length(delete_indexs); i++) {
		var entity_index = delete_indexs[i];
		ds_list_delete(interact_list, entity_index);
	}
	
	// setting interact_entity to the closest available interactable
	if(ds_list_size(interact_list) > 0) interact_entity = interact_list[| 0];
	else interact_entity = noone;
#endregion
#region statis effects
	// random tick
	if(random_tick_timer <= 0) {
		// fire
		if(statis.fire > 0) {
			var fire_damage	= -1;
			offset_hp(fire_damage);
			statis.fire--;
		}
		
		random_tick_timer = random_tick_time;
	}
	else random_tick_timer -= get_delta();
	
	// spreading fire
	var spread_to_list = ds_list_create();
	collision_rectangle_list_3d(bbox_left - spread_rad, bbox_top - spread_rad, z - spread_rad, bbox_right + spread_rad, bbox_bottom + spread_rad, z + h + spread_rad, oEntity, spread_to_list, false);
	for(var i = 0; i < ds_list_size(spread_to_list); i++) { 
		var entity = spread_to_list[| i];
		// spread fire
		if(statis.fire > 0) entity.fire_timer -= get_delta();
	}
	ds_list_destroy(spread_to_list);
	
	// catching on fire
	if(fire_timer <= 0) {
		inflict(ELEMENTTYPE.FIRE);
		fire_timer = fire_time;	
	}
	else fire_timer = clamp(fire_timer + get_delta()/4, 0, fire_time);
#endregion