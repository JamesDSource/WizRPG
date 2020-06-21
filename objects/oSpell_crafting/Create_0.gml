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
result = new storage(1, 1, "All");

spell_base.sprite = sItem_container_spell_table;
spell_element.sprite = sItem_container_spell_table;
spell_modifiers.sprite = sItem_container_spell_table;
result.sprite = sItem_container_spell_table;

title = new text("Spell Crafting", fRune, c_black, fa_left, fa_top, false);
element_text = new text("Element", fRune, c_black, fa_left, fa_bottom, false);
base_text = new text("Base", fRune, c_black, fa_right, fa_bottom, false);
modifiers_text = new text("Modifiers", fRune, c_black, fa_center, fa_top, false);

circle = new image(sSpell_table_circle, 0, 0);

var width = 120;
var height = 160;

panel_add(panel_id, width, height, 0, 0);
panel_set_position(panel_id, VIEWWIDTH - panel_get_width(panel_id) - 10, VIEWHEIGHT/2 - panel_get_height(panel_id)/2);
panel_set_background(panel_id, sSpell_creation_background, false);

panel_add_element(panel_id, "title", MENUELEMENT.TEXT, title, 0, 0);

var push_down = 10;
panel_add_element(panel_id, "circle", MENUELEMENT.IMAGE, circle, width/2, height/2 + push_down);
panel_add_element(panel_id, "result", MENUELEMENT.STORAGE, result, width/2 - storage_get_width(result)/2, height/2 - storage_get_height(result)/2 + push_down);

var storage_padding = 25;
var text_padding = 10;

panel_add_element(panel_id, "element", MENUELEMENT.STORAGE, spell_element, 0, height - storage_get_height(spell_element) - storage_padding + push_down);
panel_add_element(panel_id, "base", MENUELEMENT.STORAGE, spell_base, width - storage_get_width(spell_base), height - storage_get_height(spell_base) - storage_padding + push_down);

panel_add_element(panel_id, "element_text", MENUELEMENT.TEXT, element_text, 0, height - text_padding + push_down);
panel_add_element(panel_id, "base_text", MENUELEMENT.TEXT, base_text, width, height - text_padding + push_down);

panel_add_element(panel_id, "modifiers", MENUELEMENT.STORAGE, spell_modifiers, width/2 - storage_get_width(spell_modifiers)/2, storage_padding + push_down);
panel_add_element(panel_id, "modifiers_text", MENUELEMENT.TEXT, modifiers_text, width/2, text_padding + push_down);

interact_method = function open_spell_crafting(other_id) {
	if(other_id.object_index == oPlayer) {
		panel_set_activation(panel_id, true);
		oPlayer.open_inventory();
	}
}