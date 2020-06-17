function text(text_string, text_font, text_color, text_halign, text_valign) constructor {
	str	= text_string;
	font = text_font;
	color = text_color;
	halign = text_halign;
	valign = text_valign;
}

function text_get_width(text) {
	var last_font = draw_get_font();
	draw_set_font(text.font);
	var w = string_width(text.str);
	draw_set_font(last_font);
	
	return w;
}

function text_get_height(text) {
	var last_font = draw_get_font();
	draw_set_font(text.font);
	var h = string_height(text.str);
	draw_set_font(last_font);
	
	return h;
}

function draw_set_align(halign, valign){
	draw_set_halign(halign);
	draw_set_valign(valign);
}