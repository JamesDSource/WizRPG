if(show_stats) {
	draw_set_color(c_black);
	draw_rectangle(0, 0, w, h, false);

	var draw_y = y_margin;
	draw_set_align(fa_left, fa_top);
	draw_set_font(fDev_tools);
	for(var i = 0; i < array_length(stats); i++) {
		var str1 = stats[i][0];
		var str2 = string(stats[i][1]);
	
		draw_set_color(c_white);
		draw_text(0, draw_y, str1 + ":");
	
		draw_set_color(c_lime);
		draw_text(string_width(str1), draw_y, " " + str2);
	
		draw_y += max(string_height(str1), string_height(str2));
	}
}