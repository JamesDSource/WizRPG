// loop through all panels and check for storage
// spaces and see if the mouse is hovering over them
global.square_selected = [-1, -1, -1];
var square_moving_is_shown = false;
var panels_active = false;
for(var i = 0; i < ds_list_size(global.panels_names); i++) {
	var current_panel = global.panels[? global.panels_names[| i]];
	if(current_panel.active) {
		panels_active = true;
		
		for(var j = 0; j < ds_list_size(current_panel.elements_names); j++) {
			var current_element = current_panel.elements[? current_panel.elements_names[| j]];
			var element_x = current_element[2] + current_panel.x;
			var element_y = current_element[3] + current_panel.y;
			
			var mouse_x_gui = device_mouse_x_to_gui(0);
			var mouse_y_gui = device_mouse_y_to_gui(0);
			switch(current_element[0]) {
				case MENUELEMENT.STORAGE:
					// checking if the grid is equal to square moving
					if(current_element[1] == global.square_moving[0]) square_moving_is_shown = true;
					
					var storage_result = storage_find_pos(current_element[1], element_x, element_y, mouse_x_gui, mouse_y_gui);
					if(storage_result != -1) global.square_selected = [current_element[1], storage_result[0], storage_result[1]];
					break;
				
				case MENUELEMENT.TEXTBUTTON:
					text_button_check(current_element[1], element_x, element_y);
					break;
			
				case MENUELEMENT.BUTTONLIST:
					button_list_check(current_element[1], element_x, element_y);
					break;
			}	
		}
	}
}

if(!square_moving_is_shown) global.square_moving = [-1, -1, -1];

mouse_text = "";
if(!array_equals(global.square_selected, [-1, -1, -1])) {
	var selected_grid = global.square_selected[0].grid;
	var r = global.square_selected[1];
	var c = global.square_selected[2];
	var selected_item = selected_grid[# r, c];
	
	// dragging items
	if(mouse_check_button_pressed(mb_left)) {
		// if we're not moving any items yet
		if(array_equals(global.square_moving, [-1, -1, -1])) {
			// if your hovering over an item, set square moving to the square your hovering over
			if(is_struct(selected_item)) global.square_moving = global.square_selected;
		}
		else if(array_equals(global.square_moving, global.square_selected)) global.square_moving = [-1, -1, -1];
		else { // if we are moving an item
			if(move_and_swap_items(global.square_moving[0], global.square_moving[1], global.square_moving[2], 
			global.square_selected[0], global.square_selected[1], global.square_selected[2])) {
				// check to see if the square moving space is still an item
				// if not, set square moving to [-1, -1, -1]
				if(!is_struct(global.square_moving[0].grid[# global.square_moving[1], global.square_moving[2]])) global.square_moving = [-1, -1, -1];	
			}
		}
	}

	// item name on mouse
	if(is_struct(selected_item)) mouse_text = selected_item.name;
}
if(mouse_check_button_pressed(mb_right)) global.square_moving = [-1, -1, -1];

// mouse cursor
if(panels_active) {
	if(mouse_check_button(mb_left)) cursor_sprite = sMenu_cursor_activated;
	else cursor_sprite = sMenu_cursor_deactivated;
}
else {
	if(instance_exists(oPlayer) && is_struct(oPlayer.equipt_spell)) {
		switch(oPlayer.equipt_spell.components.element_type) {
			case ELEMENTTYPE.FIRE:
				cursor_sprite = sMenu_cursor_target_fire;
				break;
			case ELEMENTTYPE.LIGHTNING:
				cursor_sprite = sMenu_cursor_target_lightning;
				break;
			
		}
	}
	else cursor_sprite = sMenu_cursor_target;
}