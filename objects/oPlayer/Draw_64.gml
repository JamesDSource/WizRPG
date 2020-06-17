if(surface_exists(global.gui_surface)) { 
	switch(state) {
		case states.free:
			surface_set_target(global.gui_surface);
			if(toolbar_alpha > 0) {
				var toolbar_draw_x = VIEWWIDTH/2 - storage_get_width(toolbar)/2;
				var toolbar_draw_y = VIEWHEIGHT - storage_get_height(toolbar);
	
				var channel = animcurve_get_channel(acUI, "fade");
				var curve = animcurve_channel_evaluate(channel, toolbar_alpha);
				draw_set_alpha(curve);
				draw_storage(toolbar, toolbar_draw_x, toolbar_draw_y);
				draw_set_alpha(1);
			}
			else if(spells_alpha > 0) {
				var spells_draw_x = VIEWWIDTH/2 - storage_get_width(spells)/2;
				var spells_draw_y = VIEWHEIGHT - storage_get_height(spells);
	
				var channel = animcurve_get_channel(acUI, "fade");
				var curve = animcurve_channel_evaluate(channel, spells_alpha);
				draw_set_alpha(curve);
				draw_storage(spells, spells_draw_x, spells_draw_y);
				draw_set_alpha(1);
			}
			
			surface_reset_target();
			break;
	
		case states.inventory:
			// drawing a dragged icon on the mouse
			if(!array_equals(global.square_moving, [-1, -1, -1])) {
				var moving_grid = global.square_moving[0].grid;
				var moving_item = moving_grid[# global.square_moving[1], global.square_moving[2]];
	
				var icon = moving_item.icon;
				var dragged_icon_x = device_mouse_x_to_gui(0) - sprite_get_width(icon)/2;
				var dragged_icon_y = device_mouse_y_to_gui(0) - sprite_get_height(icon)/2;
				draw_sprite(icon, 0, dragged_icon_x, dragged_icon_y);
			}
			break;
	}
}