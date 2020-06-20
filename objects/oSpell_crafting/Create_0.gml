event_inherited();

active = false;
activate_rad = interact_rad;

image_speed = 0;
image_index = 0;

panel_id = string(id) + " " + room_get_name(room);

// storage
spell_base = new storage(1, 1, "All");
spell_element = new storage(1, 1, "All");
spell_modifiers = new storage(3, 1, "All");

element_text = new text("Element", fRune, c_white, fa_left, fa_middle);
base_text = new text("Base", fRune, c_white, fa_left, fa_middle);

var margin = 5;
var w1 = storage_get_width(spell_modifiers);
var w2 = storage_get_width(spell_base) + text_get_width(base_text);
var w3 = storage_get_width(spell_element) + text_get_width(element_text);
var width = max(w1, w2, w3);
var height = storage_get_height(spell_base) + storage_get_height(spell_element) + 
storage_get_height(spell_modifiers) + margin*2;

panel_add(panel_id, width, height, 0, 0);
panel_set_position(panel_id, VIEWWIDTH - panel_get_width(panel_id) - 10, VIEWHEIGHT/2 - panel_get_height(panel_id)/2);

panel_add_element(panel_id, "modifiers", MENUELEMENT.STORAGE, spell_modifiers, 0, 0);
var spell_element_y = storage_get_height(spell_base) + margin;
panel_add_element(panel_id, "element", MENUELEMENT.STORAGE, spell_element, 0, spell_element_y);
var spell_base_y = spell_element_y + storage_get_height(spell_modifiers) + margin;
panel_add_element(panel_id, "base", MENUELEMENT.STORAGE, spell_base, 0, spell_base_y);

panel_add_element(panel_id, "base text", MENUELEMENT.TEXT, base_text, storage_get_width(spell_base), spell_base_y + storage_get_height(spell_base)/2);
panel_add_element(panel_id, "element text", MENUELEMENT.TEXT, element_text, storage_get_width(spell_element), spell_element_y + storage_get_height(spell_element)/2);

interact_method = function open_spell_crafting(other_id) {
	if(other_id.object_index == oPlayer) {
		panel_set_activation(panel_id, true);
		oPlayer.open_inventory();
	}
}