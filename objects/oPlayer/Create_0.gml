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
	{
		idle: sPlayer_side,
		running: sPlayer_side_run,
		xscale: 1
	},
	{
		idle: sPlayer_back,
		running: sPlayer_back_run,
		xscale: 1
	},
	{
		idle: sPlayer_side,
		running: sPlayer_side_run,
		xscale: -1
	},
	{
		idle: sPlayer_front,
		running: sPlayer_front_run,
		xscale: 1
	}
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

// the panel
inventory_surface_w = storage_get_width(main);
inventory_surface_h = VIEWHEIGHT/1.5;

panel_add("inventory", inventory_surface_w, inventory_surface_h, 0, 0);

inventory_surface_draw_x = 10;
inventory_surface_draw_y = VIEWHEIGHT/2 - panel_get_height("inventory")/2;

panel_set_position("inventory", inventory_surface_draw_x, inventory_surface_draw_y);

panel_add_element("inventory", "main", MENUELEMENT.STORAGE, main, 0, 0);
var spells_draw_y = inventory_surface_h - storage_get_height(spells);
panel_add_element("inventory", "spells", MENUELEMENT.STORAGE, spells, 0, spells_draw_y);
var toolbar_draw_y = spells_draw_y - storage_get_height(toolbar);
panel_add_element("inventory", "toolbar", MENUELEMENT.STORAGE, toolbar, 0, toolbar_draw_y);
var charms_draw_y = toolbar_draw_y - storage_get_height(charms);
panel_add_element("inventory", "charms", MENUELEMENT.STORAGE, charms, 0, charms_draw_y);

var spells_text = new text("Spells", fRune, c_white, fa_left, fa_middle, true);
var toolbar_text = new text("Toolbar", fRune, c_white, fa_left, fa_middle, true);
var charms_text = new text("Charms", fRune, c_white, fa_left, fa_middle, true);

panel_add_element("inventory", "spells_text", MENUELEMENT.TEXT, spells_text, storage_get_width(spells), spells_draw_y + storage_get_height(spells)/2);
panel_add_element("inventory", "toolbar_text", MENUELEMENT.TEXT, toolbar_text, storage_get_width(toolbar), toolbar_draw_y + storage_get_height(toolbar)/2);
panel_add_element("inventory", "charms_text", MENUELEMENT.TEXT, charms_text, storage_get_width(charms), charms_draw_y + storage_get_height(charms)/2);

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

equipt_spell = -1;

item_height_base = 14;