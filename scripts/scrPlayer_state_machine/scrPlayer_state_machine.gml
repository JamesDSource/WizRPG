
function player_state_free() {
	// movement
	var hDir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var vDir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
	if(vDir != 0 || hDir != 0) {
		target_speed = 3;	
		dir = point_direction(0, 0, hDir, vDir);
		
		// making held items bob up and down
		equipt_item.z_pos = z + item_height_base + wave(-2, 2, 0.5, 0);
	}
	else {
		target_speed = 0;
		equipt_item.z_pos = z + item_height_base;	
	}
	
	event_inherited();
	
	// direction facing and xscale
	if(is_struct(equipt_item.index)) {
		side = floor(((equipt_item.angle div 45) + 1) * 0.5);
		if(side == 4) side = 0;
		switch(side) {
			case 0:
				hFacing = 1;
				vFacing = 0;
				break;
			case 1: 
				hFacing = 0;
				vFacing = -1;
				break;
			case 2: 
				hFacing = -1;
				vFacing = 0;
				break;
			case 3: 
				hFacing = 0;
				vFacing = 1;
				break;
		}
		
		if((hFacing != 0 && hFacing != hDir) || (vFacing != 0 && vFacing != vDir)) image_speed = -1;
		else image_speed = 1;
	}
	else if(hFacing != hDir && vFacing != vDir) {
		image_speed = 1;
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
	
	if(target_speed > 0) sprite_index = sprite_sides[floor(side)].running; 
	else sprite_index = sprite_sides[floor(side)].idle;
	image_xscale = sprite_sides[floor(side)].xscale;
	
	// interacting
	if(keyboard_check_pressed(ord("E"))) interact();
	
	// scrolling through toolbar
	if(mouse_wheel_up() || mouse_wheel_down() || update_toolbar) {
		if(keyboard_check(vk_shift)) {
			toolbar_alpha = 0;
			spells_alpha = 1;
			if(mouse_wheel_up()) spells_equipt[1]--;
			else if(mouse_wheel_down()) spells_equipt[1]++;
		
			spells_equipt[1] = clamp(spells_equipt[1], 0, ds_grid_width(spells_equipt[0].grid)-1);
		}
		else {
			toolbar_alpha = 1;
			spells_alpha = 0;
			if(mouse_wheel_up()) toolbar_equipt[1]--;
			else if(mouse_wheel_down()) toolbar_equipt[1]++;
		
			toolbar_equipt[1] = clamp(toolbar_equipt[1], 0, ds_grid_width(toolbar_equipt[0].grid)-1);
		}
		update_toolbar = false;

		// setting the equipt item
		var new_item = toolbar_equipt[0].grid[# toolbar_equipt[1], toolbar_equipt[2]];
		equipt_item.index = new_item;
		equipt_item.angle = 0;
		equipt_item.alpha = 1;
		if(is_struct(new_item)) equipt_item.sprite = new_item.sprite;
		
		// setting equipt spell
		var new_spell = spells_equipt[0].grid[# spells_equipt[1], spells_equipt[2]];
		equipt_spell = new_spell;
	}
	
	// item functions
	var ang = point_direction(x, y-equipt_item.z_pos, mouse_x, mouse_y);
	equipt_item.x_offset = approach(equipt_item.x_offset, lengthdir_x(6, ang), abs(lengthdir_x(0.5, ang)));
	equipt_item.y_offset = approach(equipt_item.y_offset, lengthdir_y(6, ang), abs(lengthdir_y(0.5, ang)));
	equipt_item.x_pos = x + equipt_item.x_offset;
	equipt_item.y_pos = y + equipt_item.y_offset;
	if(is_struct(equipt_item.index)) {
		equipt_item.index.action(equipt_item);
	}
	
	// opening inventory
	if(keyboard_check_pressed(vk_tab)) open_inventory();
}

function player_state_inventory() {
	event_inherited();
	
	// closeing inventory
	if(keyboard_check_pressed(vk_tab)) {
		state = states.free;
		update_toolbar = true;
		panel_set_activation("inventory", false);	
	}
}