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
main = new storage(11, 4, "All");
// spells
spells = new storage(8, 1, [ITEMTYPE.SPELL])
spells_equipt = [spells, 0, 0];
spells_alpha = 0;
// toolbar
toolbar = new storage(5, 1, [ITEMTYPE.STAFF]);
toolbar_equipt = [toolbar, 0, 0];
toolbar_alpha = 0;
update_toolbar = false;
// charms
charms = new storage(3, 1, [ITEMTYPE.CHARM]);

panel_add_element("inventory", "main", MENUELEMENT.STORAGE, main, 0, 0);
var spells_draw_y = inventory_surface_h - storage_get_height(spells);
panel_add_element("inventory", "spells", MENUELEMENT.STORAGE, spells, 0, spells_draw_y);
var toolbar_draw_y = spells_draw_y - storage_get_height(toolbar);
panel_add_element("inventory", "toolbar", MENUELEMENT.STORAGE, toolbar, 0, toolbar_draw_y);
var charms_draw_y = toolbar_draw_y - storage_get_height(charms);
panel_add_element("inventory", "charms", MENUELEMENT.STORAGE, charms, 0, charms_draw_y);

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

storage_add_item(main, global.items.forest_staff);
storage_add_item(main, global.items.stick_wand);
storage_add_item(main, global.items.lightning_staff);
storage_add_item(main, global.items.mushroom_wand);