if(creator != noone) {
	with(creator) {
		var x1 = bbox_left;	
		var y1 = bbox_top;	
		var x2 = bbox_right;	
		var y2 = bbox_bottom;	
	}
	draw_set_alpha(0.2);
	draw_set_color(c_black);
	draw_rectangle(x1, y1 - z, x2, y2 - z, false);
	draw_set_alpha(1);	
}