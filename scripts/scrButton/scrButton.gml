function text_button(left_sprite, middle_sprite, right_sprite, button_text, text_font) constructor {
	spr_left = left_sprite;
	spr_middle = middle_sprite;
	spr_right = right_sprite;
	str = button_text;
	font = text_font;
	
	active = true;
	selected = false;
}

function draw_text_button(button, x_pos, y_pos) {
	var old_font = draw_get_font();
	draw_set_font(button.font);
	var w = string_width(button.str);

	var subimage = 0;
	if(button.active) subimage = 1;

	draw_sprite(button.spr_left, subimage, x_pos, y_pos);
	draw_sprite_ext(button.spr_middle, subimage, x_pos + sprite_get_width(button.spr_left), y_pos, w, 1, 0, c_white, 1);
	draw_sprite(button.spr_right, subimage, x_pos + w + sprite_get_width(button.spr_left), y_pos);
	
	draw_set_font(old_font);
}

function text_button_check(button, x_pos, y_pos) {
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	
	var old_font = draw_get_font();
	draw_set_font(button.font);
	
	var x1 = x_pos;
	var y1 = y_pos;
	var x2 = x_pos + text_button_get_width(button);
	var y2 = y_pos + text_button_get_height(button);
	if(point_in_rectangle(mx, my, x1, y1, x2, y2)) button.active = true;	
	else button.active = false;	
		
	draw_set_font(old_font);
	return button.active;
}

function text_button_get_width(button) {
	var old_font = draw_get_font();
	draw_set_font(button.font);
	var width =  sprite_get_width(button.spr_left) + sprite_get_width(button.spr_right) + string_width(button.str);
	draw_set_font(old_font);
	return width;
}

function text_button_get_height(button) {
	return max(sprite_get_height(button.spr_left), sprite_get_height(button.spr_middle). sprite_get_height(button.spr_right));
}