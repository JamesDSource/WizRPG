event_inherited();

states = {
	free: player_state_free	,
	inventory: player_state_inventory
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
//sprite_sides = [
//	[sMushroom_spider_walk_side, 1],
//	[sMushroom_spider_walk_back, 1],
//	[sMushroom_spider_walk_side, -1],
//	[sMushroom_spider_walk_front, 1]
//];

side = sprite_side_index.front;

hFacing = noone;
vFacing = noone;

box_progress = 0;
last_selected = noone;

// inventory system
enum ITEMTYPE {
	STAFF,
	MISC
}

// the surface
inventory_surface = -1;
inventory_surface_w = VIEWWIDTH/1.5;
inventory_surface_h = VIEWHEIGHT/1.5;

// main inventory storage
inventory_draw_x = VIEWWIDTH/2 - inventory_surface_w/2;
inventory_draw_y = VIEWHEIGHT/2 - inventory_surface_h/2;
inventory = new storage(10, 5, [ITEMTYPE.STAFF, ITEMTYPE.MISC]);

// toolbar
toolbar_upper_margin = 10;
toolbar_draw_x = inventory_draw_x;
toolbar_draw_y = inventory_draw_y + storage_get_height(inventory) + toolbar_upper_margin;
toolbar = new storage(5, 1, [ITEMTYPE.STAFF])

global.square_selected = [-1, -1, -1]; // [grid index, x, y]