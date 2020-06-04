
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
			sprite_index = sprite_sides.side;
			image_xscale = hFacing;
		}
		else if(vDir != 0) {
			vFacing = vDir;
			hFacing = noone;
			image_xscale = 1;
			switch(vFacing) {
				case 1: sprite_index = sprite_sides.front; break;
				case -1: sprite_index = sprite_sides.back; break;
			}
		}
	}
	
	// interacting
	if(keyboard_check_pressed(ord("E"))) interact();
}