panels = ds_map_create();
panels_names = ds_list_create();

global.square_selected = [-1, -1, -1];	// [grid index, x, y]
global.square_moving = [-1, -1, -1];	// [grid index, x, y]

#macro PANELEDGE 8

mouse_text = "";