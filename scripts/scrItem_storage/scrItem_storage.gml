#macro STORAGESQUARESIZE 18
#macro STORAGESQUAREMARGIN 4

function storage(w, h, item_types) constructor {
	items_allowed = item_types;
	grid = ds_grid_create(w, h);
	
	for(var r = 0; r < ds_grid_width(grid); r++) {
		for(var c = 0; c < ds_grid_height(grid); c++) {
			grid[# r, c] = -1;
		}
	}
	
	sprite = sItem_container;
}

function draw_storage(storage, draw_x, draw_y, highlighted) {
	var storage_grid = storage.grid;
	draw_x += STORAGESQUAREMARGIN;
	draw_y += STORAGESQUAREMARGIN;
	var draw_x_init = draw_x;
	
	for(var c = 0; c < ds_grid_height(storage_grid); c++) {
		for(var r = 0; r < ds_grid_width(storage_grid); r++) {
			var container_image_index = 0;
			if(array_equals(highlighted, [storage, r, c])) container_image_index = 1;
			
			draw_sprite(storage.sprite, container_image_index, draw_x, draw_y);
			
			// check if an item is filling this space
			var current_item = storage_grid[# r, c];
			if(is_struct(current_item)) {
				var prev_alpha = draw_get_alpha();
				// draw item icon on square unless being dragged by mouse
				if(array_equals(global.square_moving, [storage, r, c])) draw_set_alpha(prev_alpha/2);
				draw_sprite(current_item.icon, 0, draw_x + 1, draw_y + 1);
				draw_set_alpha(prev_alpha);
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

function move_and_swap_items(storage1, x1, y1, storage2, x2, y2) {
	var item1 = storage1.grid[# x1, y1];
	var item2 = storage2.grid[# x2, y2];
	
	if(is_struct(item1)) {
		var can_swap1 = false;
		var can_swap2 = false;
		var req1 = storage1.items_allowed;
		var req2 = storage2.items_allowed;
		// checks if item 1 can fit into space2
		if(is_array(req2)) {
			for(var i = 0; i < array_length(req2); i++) {
				var requirement = req2[i];
				if(requirement == item1.type) can_swap1 = true;
			}
		}
		else can_swap1 = true;
		// checks if item 2 can fit into space1
		if(is_struct(item2) && is_array(req1)) {
			for(var i = 0; i < array_length(req1); i++) {
				var requirement = req1[i];
				if(requirement == item2.type) can_swap2 = true;
			}
		}
		else can_swap2 = true
		
		if(!can_swap1 || !can_swap2) return false;
		
		// if we're not moving over the same space
		if(!array_equals([storage1, x1, y1], [storage2, x2, y2])) {
			// overwise swap the two indexs
			storage2.grid[# x2, y2] = item1;
			storage1.grid[# x1, y1] = item2;
		}
		return true;
	}
	else return false;
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
	var requirements = storage.items_allowed;
	var can_add = false;
	
	// checks to see if the item is allowed in the storage space
	if(is_array(requirements)) { 
		for(var i = 0; i < array_length(requirements); i++) {
			var requirement = requirements[i];
			if(requirement == item.type) can_add = true;	
		}
	}
	else can_add = true;
	
	if(can_add) {
		// trys to find an empty space in the grid to add the item
		var data = storage.grid;
		for(var c = 0; c < ds_grid_height(data); c++) {
			for(var r = 0; r < ds_grid_width(data); r++) {
				if(data[# r, c] == -1) {
					var new_item = item_copy(item);
					data[# r, c] = new_item;
					return [r, c];
				}
			}
		}
	}
	
	return -1;
}