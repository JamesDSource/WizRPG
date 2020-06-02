if(instance_exists(interact_entity) && interact_entity.sprite_index != noone) {
	if(box_progress < 1) box_progress = approach(box_progress, 1, 0.05);
	var channel = animcurve_get_channel(acOvershoot, "overshoot");
	var curve = animcurve_channel_evaluate(channel, box_progress);
	
	with(interact_entity) {	
		draw_set_color(c_white);
		var x_org = x - sprite_xoffset;
		var y_org = y - sprite_yoffset;
		draw_rectangle(x_org, y_org, x_org + sprite_width, y_org + sprite_height*curve, true);
	}
}