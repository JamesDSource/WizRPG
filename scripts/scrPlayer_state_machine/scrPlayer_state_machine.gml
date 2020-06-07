
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
}