if(instance_exists(interact_entity) && interact_entity.sprite_index != noone && is_method(interact_entity.interact_method)) {
	if(box_progress < 1) box_progress = approach(box_progress, 1, 0.05);
	var channel = animcurve_get_channel(acOvershoot, "overshoot");
	var curve = animcurve_channel_evaluate(channel, box_progress);
	
	with(interact_entity) {	
		draw_set_color(c_white);
		var x_org = x - sprite_xoffset + sprite_width/2;
		var y_org = y - sprite_yoffset + sprite_height/2;
		var rectx1 = x_org - sprite_width/2*curve;
		var recty1 = y_org - sprite_height/2*curve;
		var rectx2 = x_org + sprite_width/2*curve;
		var recty2 = y_org + sprite_height/2*curve;
		draw_rectangle(rectx1, recty1, rectx2, recty2, true);
	}
}