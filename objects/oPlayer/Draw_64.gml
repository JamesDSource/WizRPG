draw_text(20, 20, string(x) + "/" + string(y) + "/" + string(z));

if(surface_exists(inventory_surface)) {
	if(state == states.inventory) {
		surface_set_target(inventory_surface);
		draw_set_color(c_black);
		draw_rectangle(0, 0, inventory_surface_w, inventory_surface_h, false);
		
		// drawing storage
		draw_storage(inventory, 0, 0);
		var spells_y = inventory_surface_h - storage_get_height(spells);
		draw_storage(spells, 0, spells_y);
		var toolbar_y = spells_y - storage_get_height(spells);
		draw_storage(toolbar, 0, toolbar_y);
		
		draw_set_align(fa_left, fa_top);
		draw_set_font(fRune);
		draw_text(storage_get_width(toolbar), toolbar_y, "Toolbar");
		draw_text(storage_get_width(spells), spells_y, "Spells");
		
		
		surface_reset_target();
		draw_surface(inventory_surface, inventory_surface_draw_x, inventory_surface_draw_y);
	}
}
else inventory_surface = surface_create(inventory_surface_w, inventory_surface_h);

// drawing a dragged icon on the mouse
if(!array_equals(global.square_moving, [-1, -1, -1])) {
	var moving_grid = global.square_moving[0].grid;
	var moving_item = moving_grid[# global.square_moving[1], global.square_moving[2]];
	
	var icon = moving_item.icon;
	var dragged_icon_x = device_mouse_x_to_gui(0) - sprite_get_width(icon)/2;
	var dragged_icon_y = device_mouse_y_to_gui(0) - sprite_get_height(icon)/2;
	draw_sprite(icon, 0, dragged_icon_x, dragged_icon_y);
}