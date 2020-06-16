event_inherited();

if(opened) {
	if(keyboard_check_pressed(vk_tab)) opened = false;	
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	var items_result = storage_find_pos(items, items_surface_draw_x, items_surface_draw_y, mx, my);
	if(items_result != -1) global.square_selected = [items, items_result[0], items_result[1]];
}