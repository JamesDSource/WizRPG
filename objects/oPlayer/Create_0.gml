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

side = sprite_side_index.front;

hFacing = noone;
vFacing = noone;

box_progress = 0;
last_selected = noone;

// inventory system
function open_inventory() {
	state = states.inventory;
	panel_set_activation("inventory", true);
	target_speed = 0;
}

// the panel
inventory_surface_w = VIEWWIDTH/1.5;
inventory_surface_h = VIEWHEIGHT/1.5;
inventory_surface_draw_x = 10;
inventory_surface_draw_y = VIEWHEIGHT/2 - inventory_surface_h/2;

panel_add("inventory", inventory_surface_w, inventory_surface_h, inventory_surface_draw_x, inventory_surface_draw_y);

// main inventory storage
inventory = new storage(11, 4, "All");
inventory_draw_x = inventory_surface_draw_x;
inventory_draw_y = inventory_surface_draw_y;

// spells
spells = new storage(8, 1, [ITEMTYPE.SPELL])
spells_draw_x = inventory_surface_draw_x;
spells_draw_y = inventory_surface_draw_y + inventory_surface_h - storage_get_height(spells);
spells_equipt = [spells, 0, 0];
spells_alpha = 0;


// toolbar
toolbar = new storage(5, 1, [ITEMTYPE.STAFF]);
toolbar_draw_x = inventory_surface_draw_x;
toolbar_draw_y = spells_draw_y - storage_get_height(toolbar);
toolbar_equipt = [toolbar, 0, 0];
toolbar_alpha = 0;
update_toolbar = false;

// charms
charms = new storage(3, 1, [ITEMTYPE.CHARM]);
charms_draw_x = inventory_surface_draw_x;
charms_draw_y = toolbar_draw_y - storage_get_height(toolbar);

equipt_item = {
	index: -1,
	sprite: noone,
	x_pos: x,
	y_pos: y,
	z_pos: z,
	x_offset: 0,
	y_offset: 0,
	angle: 0,
	alpha: 1
};
item_height_base = 14;

global.square_selected = [-1, -1, -1];	// [grid index, x, y]
global.square_moving = [-1, -1, -1];	// [grid index, x, y]

storage_add_item(inventory, global.items.forest_staff);
storage_add_item(inventory, global.items.stick_wand);
storage_add_item(inventory, global.items.lightning_staff);
storage_add_item(inventory, global.items.mushroom_wand);