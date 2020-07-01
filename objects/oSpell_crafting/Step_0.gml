event_inherited();

var player_collision = collision_rectangle(bbox_left - activate_rad, bbox_top - activate_rad, 
bbox_right + activate_rad, bbox_bottom + activate_rad, oPlayer, false, true);

var player_detect = false
if(player_collision != noone) player_detect = true;


if(player_detect != active) {
	active = player_detect;
	
	if(active) {
		sprite_index = sSpell_crafting_opening;
		image_speed = 1;
	}
	else sprite_index = sSpell_crafting_closeing;
}

if(keyboard_check_pressed(vk_tab)) panel_set_activation(panel_id, false);

#region item crafting
	var valid_components = true;

	// check element and base
	if(!is_struct(spell_element.grid[# 0, 0]) || !is_struct(spell_base.grid[# 0, 0]) || is_struct(result.grid[# 0, 0])) valid_components = false;
	
	// check the modifiers to see if they work with the
	// base
	for(var i = 0; i < ds_grid_width(spell_modifiers.grid); i++) {
		var modifier_item = spell_modifiers.grid[# i, 0];
		if(valid_components && is_struct(modifier_item) && modifier_item.components.base == spell_base.grid[# 0, 0].components) valid_components = false;
	}
	
	if(valid_components) craft.active = true;
	else craft.active = false;
#endregion