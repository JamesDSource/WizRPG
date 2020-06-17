enum MENUELEMENT {
	STORAGE,
	TEXT
}

function panel (w, h, x_pos, y_pos) constructor {
	width = w;
	height = h;
	x = x_pos;
	y = y_pos;
	surface = -1;
	active = false;
	elements = ds_map_create();
	elements_names = ds_list_create();
}

// adding
function panel_add(name, width, height, x_pos, y_pos) {
	if(instance_exists(oMenus)) {
		var map = oMenus.panels;
		var list = oMenus.panels_names;
		var is_new = true;
		
		for(var i = 0; i < ds_list_size(list); i++) {
			if(list[| i] == name) is_new = false;	
		}
		
		if(is_new) {
			var new_panel = new panel(width, height, x_pos, y_pos);
			ds_map_add(map, name, new_panel);
			ds_list_add(list, name);
		}
	}
}


// removing
function panel_remove(name) {
	if(instance_exists(oMenus))  {
		var map = oMenus.panels;
		var list = oMenus.panels_names;
	
		var surf = map[? name].surface;
		if(surface_exists(surf)) surface_free(surf);
		
		ds_map_destroy(map[? name].elements);
		ds_list_destroy(map[? name].elements_names);
	
		ds_map_delete(map, name);
		ds_list_delete(list, ds_list_find_index(list, name));
	}
}

function panel_set_activation(name, activation) {
	if(instance_exists(oMenus)) {
		var map = oMenus.panels;
		map[? name].active = activation;
	}
}

function panel_add_element(name, element_name, element_type, element, x_pos, y_pos) {
	if(instance_exists(oMenus)) {
		var map = oMenus.panels;
		var elements_map = map[? name].elements;
		var elements_list = map[? name].elements_names;
		var is_new = true;
		
		for(var i = 0; i < ds_list_size(elements_list); i++) {
			if(elements_list[| i] == element_name) is_new = false;
		}
		
		if(is_new) {
			ds_map_add(elements_map, element_name, [element_type, element, x_pos, y_pos]);
			ds_list_add(elements_list, element_name);
		}
	}
}

function panel_remove_element(name, element_name) {
	if(instance_exists(oMenus)) {
		var map = oMenus.panels;
		var elements_map = map[? name].elements;
		var elements_list = map[? name].elements_names;
		
		ds_map_delete(elements_map, element_name);
		ds_list_delete(elements_list, ds_list_find_index(elements_list, element_name));
	}
}