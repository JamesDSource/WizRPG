#region movement
	var delta = get_delta();

	hsp = approach(hsp, lengthdir_x(target_speed, dir) * delta, acceleration * delta);
	vsp = approach(vsp, lengthdir_y(target_speed, dir) * delta, acceleration * delta);

	// TODO insert collision code here

	x += hsp;
	y += vsp;
#endregion

#region Interactables
	ds_list_clear(interact_list);
	collision_circle_list(x, y, interact_radius, oEntity, false, true, interact_list, true);

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