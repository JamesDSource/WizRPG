event_inherited();

range = 80;
target = noone;

var collision_list = ds_list_create();
collision_circle_list(x, y, range, oEntity, false, true, collision_list, true);

for(var i = 0; i < ds_list_size(collision_list); i++) {
	var inst = collision_list[| i];
	if(ds_list_find_index(global.bolted, inst) == -1 && !inst.pass_through && ds_list_find_index(inst.dont_collide, id) == -1) {
		target = inst;
		break;
	}
}

ds_list_destroy(collision_list);
