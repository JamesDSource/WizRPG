#macro STORAGESQUARESIZE 16
#macro STORAGESQUAREMARGIN 4

function storage(w, h, item_types) constructor {
	items_allowed = item_types;
	grid = ds_grid_create(w, h);
	
	for(var r = 0; r < ds_grid_width(grid); r++) {
		for(var c = 0; c < ds_grid_height(grid); c++) {
			grid[# r, c] = -1;
		}
	}
}

function draw_storage(storage, draw_x, draw_y) {
	var storage_grid = storage.grid;
	draw_x += STORAGESQUAREMARGIN;
	draw_y += STORAGESQUAREMARGIN;
	var draw_x_init = draw_x;
	
	for(var c = 0; c < ds_grid_height(storage_grid); c++) {
		for(var r = 0; r < ds_grid_width(storage_grid); r++) {
			if(array_equals(global.square_selected, [storage, r, c])) draw_set_color(c_yellow);
			else draw_set_color(c_white);
			
			draw_rectangle(draw_x, draw_y, draw_x + STORAGESQUARESIZE, draw_y + STORAGESQUARESIZE, false);
			
			// check if an item is filling this space
			var current_item = storage_grid[# r, c];
			if(is_struct(current_item)) {
				// draw item icon on square unless being dragged by mouse
				if(array_equals(global.square_moving, [storage, r, c])) draw_set_alpha(0.5); 
				draw_sprite(current_item.icon, 0, draw_x, draw_y);	
				draw_set_alpha(1);
			}
			
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
		
		inven_x = clamp(inven_x, 0, ds_grid_width(storage.grid)-1);
		inven_y = clamp(inven_y, 0, ds_grid_height(storage.grid)-1);
		
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
	
function storage_add_item(storage, item) {
	var data = storage.grid;
	for(var c = 0; c < ds_grid_height(data); c++) {
		for(var r = 0; r < ds_grid_width(data); r++) {
			if(data[# r, c] == -1) {
				data[# r, c] = item;
				return [r, c];
			}
		}
	}
	
	return -1;
}