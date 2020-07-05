#macro BUTTONLISTPADDING 5

function button_list(button_preset, height, width) constructor {
	h = height;
	w = width;
	preset = button_preset;
	
	buttons = array_create(0);
	offset = 0;
	button_height = max(max(button_preset.spr_left, button_preset.spr_right), button_preset.spr_middle);
	nine_slice_background = sPanel_background;
	surface = -1;
}

function button_list_add_button(list_index, button_name, button_text, press_method) {
	var button = {
		name: button_name,
		txt: button_text,
		on_click: press_method,
		active: true
	}
	
	list_index.buttons[array_length(list_index.buttons)] = button;
}

function button_list_remove_button(list_index, button_name) {
	var move_back = false;
	
	for(var i = 0; i < array_length(list_index.buttons); i++) {
		if(!move_back) {
			var name = list_index.buttons[i].name;	
			if(name == button_name) move_back = true;
		}
		else if(i != 0) {
			list_index.buttons[i - 1] = list_index.buttons[i];
		}
	}
	
	if(move_back) array_resize(list_index.buttons, array_length(list_index.buttons)-1);
}

function draw_button_list(button_list_index, x_pos, y_pos) {
	var prev_surface = surface_get_target();
	var prev_colorwrite = gpu_get_colorwriteenable();
	if(prev_surface != -1) surface_reset_target();
	gpu_set_colorwriteenable(true, true, true, true);
	
	if(!surface_exists(button_list_index.surface)) button_list_index.surface = surface_create(button_list_index.h, button_list_index.w);
	surface_set_target(button_list_index.surface);
	
	// draw buttons
	var button_preset = button_list_index.preset;
	var button_height = max(sprite_get_height(button_preset.spr_left), sprite_get_height(button_preset.spr_right));
	button_height = max(button_height, sprite_get_height(button_preset.spr_middle));
	
	for(var i = 0; i < array_length(button_list_index.buttons); i++) {
		var draw_y = i * (button_height + BUTTONLISTPADDING);
		draw_sprite(button_preset.spr_left, 0, 0, draw_y);
		draw_sprite(button_preset.spr_right, 0, button_list_index.h - sprite_get_width(button_preset.spr_right), draw_y);
		
		var middle_stretch = button_list_index.h - sprite_get_width(button_preset.spr_right) - sprite_get_width(button_preset.spr_left);
		draw_sprite_ext(button_preset.spr_middle, 0, sprite_get_width(button_preset.spr_right), draw_y, middle_stretch, 1, 0, c_white, draw_get_alpha());
	}
	
	gpu_set_colorwriteenable(prev_colorwrite[0], prev_colorwrite[1], prev_colorwrite[2], prev_colorwrite[3]);
	surface_reset_target();
	
	// drawing the surface
	if(prev_surface != -1) surface_set_target(prev_surface);
	draw_surface(button_list_index.surface, x_pos, y_pos);
}