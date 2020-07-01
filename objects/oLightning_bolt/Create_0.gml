event_inherited();

range = 80;
target = noone;
has_damaged = false;

var collision_list = ds_list_create();
collision_circle_list(x, y, range, oEntity, false, true, collision_list, true);

for(var i = 0; i < ds_list_size(collision_list); i++) {
	var inst = collision_list[| i];
	var in_list = false;
	for(var j = 0; j < ds_list_size(global.bolted); j++) {
		if(global.bolted[| j][0] == inst) in_list = true;	
	}
	if(!in_list && !inst.pass_through && ds_list_find_index(inst.dont_collide, id) == -1) {
		target = inst;
		break;
	}
}

ds_list_destroy(collision_list);

image_index = irandom_range(0, image_number-1);
life = 15;

draw_function = function draw_self_lightning_bolt() {
	if(target != noone) {
		texture = sprite_get_texture(sprite_index, image_index);
		
		draw_set_color(c_white);
		var ang = point_direction(x, y, target.x, target.y);
		var dist = point_distance(x, y, target.x, target.y);
		
		var x_offset1 = lengthdir_x(sprite_height/2, ang - 90);
		var y_offset1 = lengthdir_y(sprite_height/2, ang - 90);
		var x_offset2 = lengthdir_y(sprite_height/2, ang + 90);
		var y_offset2 = lengthdir_y(sprite_height/2, ang + 90);
		
		var tex_repeat = dist/sprite_width;
		
		gpu_set_tex_repeat(true);
		draw_primitive_begin_texture(pr_trianglestrip, texture);
		// top left
		draw_vertex_texture(x + x_offset1, y + y_offset1, 0, 0);
		// bottom left
		draw_vertex_texture(x + x_offset2, y + y_offset2, 0, 1);
		// top right
		draw_vertex_texture(target.x + x_offset1, target.y + y_offset1, tex_repeat, 0);
		// bottom right
		draw_vertex_texture(target.x + x_offset2, target.y + y_offset2, tex_repeat, 1);
		draw_primitive_end();
		gpu_set_tex_repeat(false);
	}
}