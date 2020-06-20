event_inherited();

if(keyboard_check_pressed(vk_tab) && opened) {
	opened = false;
	panel_set_activation(panel_id, false);
	image_speed = -1;
}