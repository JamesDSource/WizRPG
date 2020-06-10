#macro STORAGESQUARESIZE 16
#macro STORAGESQUAREMARGIN 4

function storage(w, h, item_types) constructor{
	items_allowed = item_types;
	grid = ds_grid_create(w, h);
}

function draw_storage(storage, draw_x, draw_y) {
	var storage_grid = storage.grid;
	draw_x += STORAGESQUAREMARGIN;
	draw_y += STORAGESQUAREMARGIN;
	var draw_x_init = draw_x;
	
	for(var r = 0; r < ds_grid_height(storage_grid); r++) {
		for(var c = 0; c < ds_grid_width(storage_grid); c++) {
			if(array_equals(global.square_selected, [storage, c, r])) draw_set_color(c_yellow);
			else draw_set_color(c_white);
			
			draw_rectangle(draw_x, draw_y, draw_x + STORAGESQUARESIZE, draw_y + STORAGESQUARESIZE, false);
			draw_x += STORAGESQUARESIZE + STORAGESQUAREMARGIN;
		}
		draw_y += STORAGESQUARESIZE + STORAGESQUAREMARGIN;
		draw_x = draw_x_init;
	}
	
}

function storage_find_pos(storage, storage_x, storage_y, pos_x, pos_y) {
	var rect_x1 = storage_x;
	var rect_y1 = storage_y;
	var rect_x2 = rect_x1 + storage_get_width(storage);
	var rect_y2 = rect_y1 + storage_get_height(storage);
	
	if(point_in_rectangle(pos_x, pos_y, rect_x1, rect_y1, rect_x2, rect_y2)) {
		var offset_x = pos_x - rect_x1;
		var offset_y = pos_y - rect_y1;
		
		var inven_x = offset_x div (STORAGESQUARESIZE + STORAGESQUAREMARGIN);
		var inven_y = offset_y div (STORAGESQUARESIZE + STORAGESQUAREMARGIN);
		
		return [inven_x, inven_y];
	}
	else return -1;
}

function storage_get_width(storage) {
	var w = ds_grid_width(storage.grid);
	return w*(STORAGESQUARESIZE + STORAGESQUAREMARGIN) + STORAGESQUAREMARGIN;
}

function storage_get_height(storage) {
	var h = ds_grid_height(storage.grid);
	return h*(STORAGESQUARESIZE + STORAGESQUAREMARGIN) + STORAGESQUAREMARGIN;
}