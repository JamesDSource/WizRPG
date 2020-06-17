for(var i = 0; i < ds_list_size(panels_names); i++) {
	var current_element = panels[? panels_names[| i]];
	ds_map_destroy(current_element.elements);
	ds_list_destroy(current_element.elements_names);
}

ds_map_destroy(panels);
ds_list_destroy(panels_names);