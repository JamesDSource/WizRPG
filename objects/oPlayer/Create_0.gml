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

// the surface
inventory_surface = -1;
inventory_surface_w = VIEWWIDTH/1.5;
inventory_surface_h = VIEWHEIGHT/1.5;
inventory_surface_draw_x = VIEWWIDTH/2 - inventory_surface_w/2;
inventory_surface_draw_y = VIEWHEIGHT/2 - inventory_surface_h/2;

// main inventory storage
inventory = new storage(10, 5, [ITEMTYPE.STAFF, ITEMTYPE.SPELLS, ITEMTYPE.MISC]);
inventory_draw_x = inventory_surface_draw_x;
inventory_draw_y = inventory_surface_draw_y;

// spells
spells = new storage(8, 1, [ITEMTYPE.SPELLS])
spells_draw_x = inventory_surface_draw_x;
spells_draw_y = inventory_surface_draw_y + inventory_surface_h - storage_get_height(spells);;


// toolbar
toolbar = new storage(5, 1, [ITEMTYPE.STAFF]);
toolbar_draw_x = inventory_surface_draw_x;
toolbar_draw_y = spells_draw_y - storage_get_height(toolbar);

global.square_selected = [-1, -1, -1]; // [grid index, x, y]
global.mouse_item = -1;

storage_add_item(inventory, global.test_item);