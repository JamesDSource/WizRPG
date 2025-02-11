if(sprite_exists(sprite_index)) {
	// shadow
	if(has_shadow) {
		draw_set_color(c_black);
		draw_set_alpha(0.2);
		if(circle_shadow) draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
		else draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
		draw_set_alpha(1.0);
	}
	
	draw_function();
	
	if(statis.fire > 0 || statis.electric_charged) {
		var x_org = x - sprite_xoffset;
		var y_org = y - sprite_yoffset - z;
		part_emitter_region(particles, particle_emitter, x_org, x_org + sprite_width, y_org, y_org + sprite_height, ps_shape_rectangle, ps_distr_gaussian);	
		
		// fire
		if(statis.fire > 0) part_emitter_burst(particles, particle_emitter, global.elements[ELEMENTTYPE.FIRE].particles, irandom_range(0, 1));
	
		// electricity
		if(statis.electric_charged) part_emitter_burst(particles, particle_emitter, global.elements[ELEMENTTYPE.LIGHTNING].particles, max(irandom_range(-10, 1), 0));
	}
	// particles
	part_system_drawit(particles);
}