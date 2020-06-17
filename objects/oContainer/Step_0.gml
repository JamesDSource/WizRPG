event_inherited();

if(keyboard_check_pressed(vk_tab) && opened) {
	opened = false;
	panel_set_activation(string(id), false);	
}