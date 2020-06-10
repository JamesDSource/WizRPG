
function player_state_free(){
	// movement
	var hDir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var vDir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
	if(vDir != 0 || hDir != 0) {
		target_speed = 3;	
		dir = point_direction(0, 0, hDir, vDir);
	}
	else target_speed = 0;
	
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
	
	// opening inventory
	if(keyboard_check_pressed(vk_tab)) state = states.inventory;
}

function player_state_inventory() {
	// selecting a square
	var gui_mouse_x = device_mouse_x_to_gui(0);
	var gui_mouse_y = device_mouse_y_to_gui(0);

	var items_x1 = inventory_draw_x;
	var items_y1 = inventory_draw_y;
	var items_x2 = items_x1 + inventory_w*(inventory_square_margin + inventory_square_size);
	var items_y2 = items_y1 + inventory_h*(inventory_square_margin + inventory_square_size);
	if(point_in_rectangle(gui_mouse_x, gui_mouse_y, items_x1, items_y1, items_x2, items_y2)) {
		inventory_square_selected[0] = global.inventory;
		var offset_x = gui_mouse_x - items_x1;
		var offset_y = gui_mouse_y - items_y1;
		var inven_x = offset_x div (inventory_square_size + inventory_square_margin);
		var inven_y = offset_y div (inventory_square_size + inventory_square_margin);
		
		inventory_square_selected[1] = inven_x;
		inventory_square_selected[2] = inven_y;
	}
	else inventory_square_selected = [-1, -1, -1];
	
	// closeing inventory
	if(keyboard_check_pressed(vk_tab)) state = states.free;
}