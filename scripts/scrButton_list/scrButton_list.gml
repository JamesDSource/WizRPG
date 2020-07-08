#macro BUTTONLISTPADDING 5

function button_list(button_preset, width, height) constructor {
	w = width;
	h = height;
	preset = button_preset;
	
	buttons = array_create(0);
	surface = -1;
	pressed_index = -1;
	offset = 0;
	
	button_height = max(sprite_get_height(preset.spr_left), sprite_get_height(preset.spr_right));
	button_height = max(button_height, sprite_get_height(preset.spr_middle));
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

function button_list_clear(list_index) {
	for(var i = 0; i < array_length(list_index.buttons); i++) {
		delete list_index.buttons[i];	
	}
	array_resize(list_index.buttons, 0);	
}

function draw_button_list(button_list_index, x_pos, y_pos) {
	var prev_surface = surface_get_target();
	var prev_colorwrite = gpu_get_colorwriteenable();
	if(prev_surface != -1) surface_reset_target();
	gpu_set_colorwriteenable(true, true, true, true);
	
	if(!surface_exists(button_list_index.surface)) button_list_index.surface = surface_create(button_list_index.w, button_list_index.h);
	surface_set_target(button_list_index.surface);
	
	draw_clear_alpha(c_white, 0);
	
	// draw buttons
	var button_preset = button_list_index.preset;
	
	for(var i = 0; i < array_length(button_list_index.buttons); i++) {
		var draw_y = i*(button_list_index.button_height + BUTTONLISTPADDING) + button_list_index.offset;
		
		// subimage and push down
		var subimage = 0;
		var txt_push = 0;
		if(i == button_list_index.pressed_index) {
			subimage = 1;
			txt_push = button_preset.push;	
		}
		
		draw_sprite(button_preset.spr_left, subimage, 0, draw_y);
		draw_sprite(button_preset.spr_right, subimage, button_list_index.w - sprite_get_width(button_preset.spr_right), draw_y);
		
		var middle_stretch = button_list_index.w - sprite_get_width(button_preset.spr_right) - sprite_get_width(button_preset.spr_left);
		draw_sprite_ext(button_preset.spr_middle, subimage, sprite_get_width(button_preset.spr_right), draw_y, middle_stretch, 1, 0, c_white, draw_get_alpha());
		
		var prev_font = draw_get_font();
		
		draw_set_font(button_preset.font);
		draw_set_align(fa_center, fa_middle);
		
		if(button_preset.color != c_black) draw_text_color(button_list_index.w/2 - 1, draw_y + button_list_index.button_height/2 + txt_push + 1, button_list_index.buttons[i].txt, c_black, c_black, c_black, c_black, draw_get_alpha());
		draw_text_color(button_list_index.w/2, draw_y + button_list_index.button_height/2 + txt_push, button_list_index.buttons[i].txt, button_preset.color, button_preset.color, button_preset.color, button_preset.color, draw_get_alpha());
		
		draw_set_font(prev_font);
	}
	
	gpu_set_colorwriteenable(prev_colorwrite[0], prev_colorwrite[1], prev_colorwrite[2], prev_colorwrite[3]);
	surface_reset_target();
	
	// drawing the surface
	if(prev_surface != -1) surface_set_target(prev_surface);
	draw_surface(button_list_index.surface, x_pos, y_pos);
}

function button_list_check(button_list_index, x_pos, y_pos) {
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	
	var buttons_amount = array_length(button_list_index.buttons);
	var buttons_length = buttons_amount*(button_list_index.button_height + BUTTONLISTPADDING);
	if(buttons_amount > 0 && point_in_rectangle(mx, my, x_pos, y_pos, x_pos + button_list_index.w, y_pos + buttons_length) && point_in_rectangle(mx, my, x_pos, y_pos, x_pos + button_list_index.w, y_pos + button_list_index.h)) {
		var mouse_y_offset = my - y_pos - button_list_index.offset;
		var selected_index = clamp(mouse_y_offset div (button_list_index.button_height + BUTTONLISTPADDING), 0, buttons_amount-1);
		
		// hover sound
		
		if(mouse_check_button_pressed(mb_left)) {
			button_list_index.pressed_index = selected_index;
			audio_play_sound(sdButton_hover, AUDIOPRIORITY.MENUS, false);
		}
		else if(mouse_check_button_released(mb_left)) {
			button_list_index.pressed_index = -1;
			if(is_method(button_list_index.buttons[selected_index].on_click)) button_list_index.buttons[selected_index].on_click(button_list_index);
			audio_play_sound(sdButton_click, AUDIOPRIORITY.MENUS, false);
		}
		
		if(mouse_wheel_down()) button_list_index.offset -= 10;
		else if(mouse_wheel_up()) button_list_index.offset += 10;
		button_list_index.offset = clamp(button_list_index.offset, -buttons_length + button_list_index.h, 0);
	}
	else {
		button_list_index.pressed_index = -1;
	}
}