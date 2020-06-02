event_inherited();

states = {
	free: player_state_free	
};
state = states.free;

sprite_sides = {
	front: sPlayer_front,	
	back: sPlayer_back,	
	side: sPlayer_side	
};

box_progress = 0;
last_selected = noone;