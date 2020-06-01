if(instance_exists(interact_entity) && interact_entity.sprite_index != noone) {
	with(interact_entity) {
		draw_set_color(c_white);
		var x_org = x - sprite_xoffset;
		var y_org = y - sprite_yoffset;
		draw_rectangle(x_org, y_org, x_org + sprite_width, y_org + sprite_height, true);
	}
}

draw_text(20, 20, hp);