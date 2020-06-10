draw_text(20, 20, string(x) + "/" + string(y) + "/" + string(z));

if(surface_exists(inventory_surface)) {
	if(state == states.inventory) {
		surface_set_target(inventory_surface);
		draw_set_color(c_black);
		draw_rectangle(0, 0, inventory_surface_w, inventory_surface_h, false);
		
		// loop through the inventory and draw squares for each
		var draw_x = inventory_square_margin;
		var draw_y = inventory_square_margin;
		for(var r = 0; r < ds_grid_height(global.inventory); r++) {
			for(var c = 0; c < ds_grid_width(global.inventory); c++) {
				if(array_equals(inventory_square_selected, [global.inventory, c, r])) draw_set_color(c_yellow);
				else draw_set_color(c_white);
				
				draw_rectangle(draw_x, draw_y, draw_x + inventory_square_size, draw_y + inventory_square_size, false);
				draw_x += inventory_square_size + inventory_square_margin;
			}
			draw_y += inventory_square_size + inventory_square_margin;
			draw_x = inventory_square_margin;
		}
		
		surface_reset_target();
		draw_surface(inventory_surface, inventory_draw_x, inventory_draw_y);
	}
}
else inventory_surface = surface_create(inventory_surface_w, inventory_surface_h);