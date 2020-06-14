
function player_state_free(){
	// movement
	var hDir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var vDir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
	if(vDir != 0 || hDir != 0) {
		target_speed = 3;	
		dir = point_direction(0, 0, hDir, vDir);
		
		// making held items bob up and down
		equipt_item.z_pos = z + item_height_base + wave(-2, 2, 1, 0);
	}
	else {
		target_speed = 0;
		equipt_item.z_pos = z + item_height_base;	
	}
	
	event_inherited();
	
	// direction facing and xscale
	if(hFacing != hDir && vFacing != vDir) {
		if(hDir != 0) {
			hFacing = hDir;
			vFacing = noone;
			switch(hFacing) {
				case 1: side = sprite_side_index.right; break;	
				case -1: side = sprite_side_index.left; break;	
			}
		}
		else if(vDir != 0) {
			vFacing = vDir;
			hFacing = noone;
			switch(vFacing) {
				case 1: side = sprite_side_index.front; break;
				case -1: side = sprite_side_index.back; break;
			}
		}
	}
	
	sprite_index = sprite_sides[floor(side)][0];
	image_xscale = sprite_sides[floor(side)][1];
	
	// interacting
	if(keyboard_check_pressed(ord("E"))) interact();
	
	// scrolling through toolbar
	global.square_selected = toolbar_equipt;
	if(mouse_wheel_up() || mouse_wheel_down() || update_toolbar) { 
		toolbar_alpha = 1;
		update_toolbar = false;
		
		if(mouse_wheel_up()) toolbar_equipt[1]--;
		else if(mouse_wheel_down()) toolbar_equipt[1]++;
		
		toolbar_equipt[1] = clamp(toolbar_equipt[1], 0, ds_grid_width(toolbar.grid)-1);
		
		// setting the equipt item
		var new_item = toolbar_equipt[0].grid[# toolbar_equipt[1], toolbar_equipt[2]];
		equipt_item.index = new_item;
		equipt_item.angle = 0;
		equipt_item.alpha = 1;
		if(is_struct(new_item)) equipt_item.sprite = new_item.sprite;
	}
	
	// item functions
	if(is_struct(equipt_item.index)) {
		equipt_item.x_pos = x;
		equipt_item.y_pos = y;
		equipt_item.index.action(equipt_item);
	}
	
	// opening inventory
	if(keyboard_check_pressed(vk_tab)) {
		state = states.inventory;
		target_speed = 0;
	}
}

function player_state_inventory() {
	event_inherited();
	
	// selecting a square
	var gui_mouse_x = device_mouse_x_to_gui(0);
	var gui_mouse_y = device_mouse_y_to_gui(0);

	var inventory_result = storage_find_pos(inventory, inventory_draw_x, inventory_draw_y, gui_mouse_x, gui_mouse_y);
	var toolbar_result = storage_find_pos(toolbar, toolbar_draw_x, toolbar_draw_y, gui_mouse_x, gui_mouse_y);
	var spells_result = storage_find_pos(spells, spells_draw_x, spells_draw_y, gui_mouse_x, gui_mouse_y);
	
	if(inventory_result != -1) global.square_selected = [inventory, inventory_result[0], inventory_result[1]];
	else if(spells_result != -1) global.square_selected = [spells, spells_result[0], spells_result[1]];
	else if(toolbar_result != -1) global.square_selected = [toolbar, toolbar_result[0], toolbar_result[1]];
	else global.square_selected = [-1, -1, -1];
	
	// dragging items
	if(mouse_check_button_pressed(mb_left) && !array_equals(global.square_selected, [-1, -1, -1])) {
		var selected_grid = global.square_selected[0].grid;
		var r = global.square_selected[1];
		var c = global.square_selected[2];
		var selected_item = selected_grid[# r, c];
		
		// if we're not moving any items yet
		if(array_equals(global.square_moving, [-1, -1, -1])) {
			// if your hovering over an item, set square moving to the square your hovering over
			if(is_struct(selected_item)) global.square_moving = global.square_selected;
		}
		else { // if we are moving an item
			if(move_and_swap_items(global.square_moving[0], global.square_moving[1], global.square_moving[2], 
			global.square_selected[0], global.square_selected[1], global.square_selected[2])) global.square_moving = [-1, -1, -1];	
		}
	}
	
	// closeing inventory
	if(keyboard_check_pressed(vk_tab)) {
		state = states.free;
		update_toolbar = true;
		global.square_moving = [-1, -1, -1];	
	}
}