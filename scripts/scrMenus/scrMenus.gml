enum MENUELEMENT {
	STORAGE,
	TEXT,
	TEXTBUTTON,
	IMAGE,
	BUTTONLIST
}

function panel (w, h, x_pos, y_pos) constructor {
	width = w + PANELEDGE*2;
	height = h + PANELEDGE*2;
	x = x_pos;
	y = y_pos;
	surface = -1;
	active = false;
	elements = ds_map_create();
	elements_names = ds_list_create();
	
	background = sPanel_background;
	scale = 0.01;
	elements_opacity = 0.0;
	run_on_pause = false;
}

function panel_set_background(name, new_background) {
	var map = global.panels;
	map[? name].background = new_background;	
}

// adding
function panel_add(name, width, height, x_pos, y_pos) {
	var map = global.panels;
	var list = global.panels_names;
	var is_new = true;
	
	for(var i = 0; i < ds_list_size(list); i++) {
		if(list[| i] == name) is_new = false;	
	}
	
	if(is_new) {
		var new_panel = new panel(width, height, x_pos, y_pos);
		map[? name] = new_panel;
		ds_list_add(list, name);
	}
}


// removing
function panel_remove(name) {
	var map = global.panels;
	var list = global.panels_names;
	
	var surf = map[? name].surface;
	if(surface_exists(surf)) surface_free(surf);
		
	ds_map_destroy(map[? name].elements);
	ds_list_destroy(map[? name].elements_names);
	
	ds_map_delete(map, name);
	ds_list_delete(list, ds_list_find_index(list, name));
}

function panel_set_activation(name, activation) {
	var map = global.panels;
	map[? name].active = activation;
}

function panel_add_element(name, element_name, element_type, element, x_pos, y_pos) {
	var map = global.panels;
	var elements_map = map[? name].elements;
	var elements_list = map[? name].elements_names;
	var is_new = true;
	
	for(var i = 0; i < ds_list_size(elements_list); i++) {
		if(elements_list[| i] == element_name) is_new = false;
	}
	
	if(is_new) {
		elements_map[? element_name] = [element_type, element, x_pos + PANELEDGE, y_pos + PANELEDGE];
		ds_list_add(elements_list, element_name);
	}
}

function panel_remove_element(name, element_name) {
	var map = global.panels;
	var elements_map = map[? name].elements;
	var elements_list = map[? name].elements_names;
	
	ds_map_delete(elements_map, element_name);
	ds_list_delete(elements_list, ds_list_find_index(elements_list, element_name));
}

function panel_get_width(name) {
	var map = global.panels;
	return map[? name].width;
}

function panel_get_height(name) {
	var map = global.panels;
	return map[? name].height;
}

function panel_set_position(name, x_pos, y_pos) {
	var map = global.panels;
	map[? name].x = x_pos;
	map[? name].y = y_pos;
}

function panel_set_run_on_pause(name, run_paused) {
	var map = global.panels;
	map[? name].run_on_pause = run_paused;
}

