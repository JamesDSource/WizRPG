if(creator != noone) {
	x = creator.x;	
	y = creator.y;
	
	if(creator.z > 0) {
		var collision_list = ds_list_create();
		with(creator) instance_place_list(x, y, oEntity, collision_list, false);
		var highest_z = 0;
		for(var i = 0; i < ds_list_size(collision_list); i++) {
			var entity = collision_list[| i];
			var top_z = entity.z + entity.h;
			var overkill = rectangle_in_rectangle(creator.bbox_right, creator.bbox_top, creator.bbox_left, creator.bbox_bottom,
			entity.bbox_right, entity.bbox_top, entity.bbox_left, entity.bbox_bottom);
			if(entity.z < creator.z && top_z > highest_z && overkill == 1) highest_z = top_z;
		}
		z = highest_z;
		ds_list_destroy(collision_list);
	}
}