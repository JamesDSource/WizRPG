
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
	
	if(hsp != 0 || vsp != 0) {
		if(hsp != 0) {
			sprite_index = sprite_sides.side;
			image_xscale = sign(hsp);	
		}
		else if(vsp != 0) {
			if(sign(vsp) == 1) sprite_index = sprite_sides.front;
			else sprite_index = sprite_sides.back;
			image_xscale = 1;
		}	
	}
	
	// interacting
	if(keyboard_check_pressed(ord("E"))) interact();
}