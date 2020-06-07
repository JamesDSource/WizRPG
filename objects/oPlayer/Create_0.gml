event_inherited();

states = {
	free: player_state_free	
};
state = states.free;

// facing direction
sprite_side_index = {
	front: 3,	
	back: 1,	
	left: 2,
	right: 0
};

sprite_sides = [
	[sPlayer_side, 1],
	[sPlayer_back, 1],
	[sPlayer_side, -1],
	[sPlayer_front, 1]
];

side = sprite_side_index.front;

hFacing = noone;
vFacing = noone;

box_progress = 0;
last_selected = noone;