function instance_place_list_3d(x_pos, y_pos, z_pos, obj, list, ordered) {
	instance_place_list(x_pos, y_pos, obj, list, ordered);
	
	var keep_list = array_create(0);
	for(var i = 0; i < ds_list_size(list); i++) {
		var inst = list[| i];
		if(rectangle_in_rectangle(0, z_pos, 1, z_pos - h, 0, inst.z, 1, inst.z - inst.h)) {
			var index = array_length(keep_list);
			keep_list[index] = inst;
		}
	}
	
	ds_list_clear(list);
	for(var i = 0; i < array_length(keep_list); i++) ds_list_add(list, keep_list[i]);
	
	return ds_list_size(list);
}

function place_meeting_3d(x_pos, y_pos, z_pos, obj) {
	var result = false;
	var inst = instance_place(x_pos, y_pos, obj);
	if(inst != noone && rectangle_in_rectangle(0, z_pos, 1, z_pos - h, 0, inst.z, 1, inst.z - inst.h)) result = true;
	return result;
}