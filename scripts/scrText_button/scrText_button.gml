function text_button(button_text, button_preset, press_method) constructor {
	str = button_text;
	preset = button_preset;
	on_click = press_method;
	
	active = true;
	selected = false;
}

function text_button_preset(left_sprite, middle_sprite, right_sprite, text_font, text_color, push_down) constructor {
	spr_left = left_sprite;
	spr_middle = middle_sprite;
	spr_right = right_sprite;
	font = text_font;
	color = text_color;
	push = push_down;
}

global.button_presets = {
	spell_book: new text_button_preset (
		sSpell_table_button_left,
		sSpell_table_button_middle,
		sSpell_table_button_right,
		fRune,
		c_black,
		2
	),
	
}

function draw_text_button(button, x_pos, y_pos) {
	var old_font = draw_get_font();
	draw_set_font(button.preset.font);
	draw_set_align(fa_left, fa_middle);
	var w = string_width(button.str);

	var offset_y_text = 0;
	var subimage = 0;
	if(button.selected) {
		subimage = 1;
		offset_y_text = button.preset.push;	
	}
	
	if(!button.active) shader_set(shGray);
	
	draw_sprite(button.preset.spr_left, subimage, x_pos, y_pos);
	draw_sprite_ext(button.preset.spr_middle, subimage, x_pos + sprite_get_width(button.preset.spr_left), y_pos, w, 1, 0, c_white, draw_get_alpha());
	draw_sprite(button.preset.spr_right, subimage, x_pos + w + sprite_get_width(button.preset.spr_left), y_pos);
	draw_set_color(button.preset.color);
	draw_text(x_pos + sprite_get_width(button.preset.spr_right), y_pos + sprite_get_height(button.preset.spr_middle)/2 + offset_y_text, button.str);
	
	shader_reset();
	draw_set_font(old_font);
}

function text_button_check(button, x_pos, y_pos) {
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	
	var x1 = x_pos;
	var y1 = y_pos;
	var x2 = x_pos + text_button_get_width(button);
	var y2 = y_pos + text_button_get_height(button);
	if(point_in_rectangle(mx, my, x1, y1, x2, y2) && button.active && mouse_check_button(mb_left)) {
		button.selected = true;
		if(mouse_check_button_pressed(mb_left) && is_method(button.on_click)) button.on_click(); 
	}
	else button.selected = false;	
		
	return button.selected;
}

function text_button_get_width(button) {
	var old_font = draw_get_font();
	draw_set_font(button.preset.font);
	var width =  sprite_get_width(button.preset.spr_left) + sprite_get_width(button.preset.spr_right) + string_width(button.str);
	draw_set_font(old_font);
	return width;
}

function text_button_get_height(button) {
	var h1 = sprite_get_height(button.preset.spr_left);
	var h2 = sprite_get_height(button.preset.spr_middle);
	var h3 = sprite_get_height(button.preset.spr_right);
	var highest = max(max(h1, h3), h2);
	return highest;
}