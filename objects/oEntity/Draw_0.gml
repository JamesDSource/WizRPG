if(sprite_index != noone) {
	// draw self
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_alpha(1);
	
	draw_sprite_ext(sprite_index, image_index, round(x), round(y - z), image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
	
	// fire
	if(statis.fire > 0) {
		var x_org = x - sprite_xoffset;
		var y_org = y - sprite_yoffset;
		part_emitter_region(particles, particle_emitter, x_org, x_org + sprite_width, y_org, y_org + sprite_height, ps_shape_rectangle, ps_distr_gaussian);	
		part_emitter_burst(particles, particle_emitter, global.elements[ELEMENTTYPE.FIRE].particles, 2);
	}
	
	// particles
	part_system_drawit(particles);
}