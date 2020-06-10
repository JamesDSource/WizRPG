draw_text(20, 20, string(x) + "/" + string(y) + "/" + string(z));

if(surface_exists(inventory_surface)) {
	if(state == states.inventory) {
		surface_set_target(inventory_surface);
		draw_set_color(c_black);
		draw_rectangle(0, 0, inventory_surface_w, inventory_surface_h, false);
		
		draw_storage(inventory, STORAGESQUAREMARGIN, STORAGESQUAREMARGIN);
		
		surface_reset_target();
		draw_surface(inventory_surface, inventory_draw_x, inventory_draw_y);
	}
}
else inventory_surface = surface_create(inventory_surface_w, inventory_surface_h);