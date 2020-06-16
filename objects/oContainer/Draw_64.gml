if(opened) {
	if(surface_exists(items_surface)) {
		surface_set_target(items_surface);
		draw_set_color(c_black);
		draw_rectangle(0, 0, items_surface_w, items_surface_h, false);
		draw_storage(items, 0, 0);
		surface_reset_target();
		
		draw_surface(items_surface, items_surface_draw_x, items_surface_draw_y);
	}
	else items_surface = surface_create(items_surface_w, items_surface_h);
}