var surfaces_draw = array_create(0);
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

for(var i = 0; i < ds_list_size(global.panels_names); i++) {
	var panel_name = global.panels_names[| i];
	var current_panel = global.panels[? panel_name];
	
	var panel_spd = 0.05;
	if(current_panel.active) {
		if(current_panel.scale < 1.0) current_panel.scale = approach(current_panel.scale, 1.0, panel_spd);
		else current_panel.elements_opacity = approach(current_panel.elements_opacity, 1.0, panel_spd);
	}
	else {
		if(current_panel.elements_opacity > 0.0) current_panel.elements_opacity = approach(current_panel.elements_opacity, 0.0, panel_spd);	
		else current_panel.scale = approach(current_panel.scale, 0.0, panel_spd);
	}
	
	if(!surface_exists(current_panel.surface)) current_panel.surface = surface_create(current_panel.width, current_panel.height);
	else if(current_panel.scale > 0.01) {
		var channel = animcurve_get_channel(acUI, "overshoot");
		var curve_scale = animcurve_channel_evaluate(channel, current_panel.scale);
		surface_resize(current_panel.surface, current_panel.width, current_panel.height * curve_scale);
		
		surface_set_target(current_panel.surface);	
		if(sprite_exists(current_panel.background)) nine_slice(current_panel.background, PANELEDGE, PANELEDGE, current_panel.width - PANELEDGE*2, current_panel.height * curve_scale - PANELEDGE*2);
		
		channel = animcurve_get_channel(acUI, "fade");
		var curve_alpha = animcurve_channel_evaluate(channel, current_panel.elements_opacity);
		draw_set_alpha(curve_alpha);
		gpu_set_colorwriteenable(true, true, true, false);
		
		for(var j = 0; j < ds_list_size(current_panel.elements_names); j++) {
				var current_element = current_panel.elements[? current_panel.elements_names[| j]];
				switch(current_element[0]) {
					case MENUELEMENT.STORAGE:
						draw_storage(current_element[1], current_element[2], current_element[3], global.square_selected);
						break;
					
					case MENUELEMENT.TEXT:
						var txt = current_element[1];
						draw_set_font(txt.font);
						draw_set_halign(txt.halign);
						draw_set_valign(txt.valign);
						draw_set_color(c_black);
						if(txt.shadow) draw_text(current_element[2]-1, current_element[3]+1, txt.str);
						draw_set_color(txt.color);
						draw_text(current_element[2], current_element[3], txt.str);
						break;
					
					case MENUELEMENT.TEXTBUTTON:
						draw_text_button(current_element[1], current_element[2], current_element[3]);
						break;
					
					case MENUELEMENT.IMAGE:
						draw_image(current_element[1], current_element[2], current_element[3]);
						break;
					
					case MENUELEMENT.BUTTONLIST:
						draw_button_list(current_element[1], current_element[2], current_element[3]);
						break;
				}
		}
		gpu_set_colorwriteenable(true, true, true, true);
		draw_set_alpha(1);
		surface_reset_target();
		
		surfaces_draw[array_length(surfaces_draw)] = [current_panel.surface, current_panel.x, current_panel.y + (current_panel.height*(1 - curve_scale))/2, current_panel.run_on_pause];
	}
}

var surface_target = global.gui_surface;
if(global.paused) surface_target = global.pause_overlay;
if(surface_exists(surface_target)) {
	surface_set_target(surface_target);
	for(var i = 0; i < array_length(surfaces_draw); i++) {
		var surf = surfaces_draw[i];
		if(!global.paused || surf[3]) draw_surface(surf[0], surf[1], surf[2]);
	}


	// mouse text
	if(mouse_text != -1) {	
		draw_set_align(fa_left, fa_bottom);
		draw_set_font(fRune);
		draw_set_color(c_black);
		var draw_mouse_text_x = mx + 2;
		var draw_mouse_text_y = my + 2;
	
		var text_padding = 5;
		if(draw_mouse_text_x + string_width(mouse_text) + text_padding > VIEWWIDTH) {
			draw_mouse_text_x -= draw_mouse_text_x + string_width(mouse_text) - VIEWWIDTH + text_padding;
		}
	
		draw_text(draw_mouse_text_x + 1, draw_mouse_text_y + 1, mouse_text);
		draw_set_color(c_white);
		draw_text(draw_mouse_text_x, draw_mouse_text_y, mouse_text);
	}

	// drawing a dragged icon on the mouse
	if(!array_equals(global.square_moving, [-1, -1, -1])) {
		var moving_grid = global.square_moving[0].grid;
		var moving_item = moving_grid[# global.square_moving[1], global.square_moving[2]];

		var icon = moving_item.icon;
		var dragged_icon_x = mx - sprite_get_width(icon)/2;
		var dragged_icon_y = my - sprite_get_height(icon)/2;
		draw_sprite(icon, 0, dragged_icon_x, dragged_icon_y);
	}
	surface_reset_target();
}
