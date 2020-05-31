if(instance_exists(interact_entity) && interact_entity.sprite_index != noone) {
	with(interact_entity) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text_color(x, y - sprite_yoffset, name, c_red, c_red, c_white, c_white, 0.8);
	}
}