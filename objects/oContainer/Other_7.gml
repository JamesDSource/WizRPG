if(image_speed == 1) {
	with(oPlayer) open_inventory();	
	opened = true;
	panel_set_activation(string(id), true);
	image_index = sprite_get_number(sprite_index)-1;
}
else image_index = 0;

image_speed = 0;