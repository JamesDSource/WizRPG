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