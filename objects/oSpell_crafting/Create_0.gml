event_inherited();

active = false;
activate_rad = interact_rad;

image_speed = 0;
image_index = 0;

panel_id = string(id) + " " + room_get_name(room);

// storage
spell_base = new storage(1, 1, [ITEMTYPE.BASE]);
spell_element = new storage(1, 1, [ITEMTYPE.ELEMENTORB]);
spell_modifiers = new storage(3, 1, [ITEMTYPE.SPELLMOD]);
result = new storage(1, 1, "All");

spell_base.sprite = sItem_container_spell_table;
spell_element.sprite = sItem_container_spell_table;
spell_modifiers.sprite = sItem_container_spell_table;
result.sprite = sItem_container_spell_table;

title = new text("Spell Table", fRune, c_black, fa_left, fa_top, false);
element_text = new text("Element Orb", fRune, c_black, fa_left, fa_bottom, false);
base_text = new text("Spell Base", fRune, c_black, fa_right, fa_bottom, false);
modifiers_text = new text("Modifiers", fRune, c_black, fa_center, fa_top, false);

circle = new image(sSpell_table_circle, 0, 0);

craft = new text_button("Create", global.button_presets.spell_book, 
	function button_craft() {
		var new_spell_modifiers = array_create(0);
		for(var i = 0; i < ds_grid_width(spell_modifiers.grid); i++) {
			var modifier_item = spell_modifiers.grid[# i, 0];
			if(is_struct(modifier_item)) new_spell_modifiers[array_length(new_spell_modifiers)] = modifier_item.components;
		}
		
		var new_spell_base = spell_base.grid[# 0, 0].components;
		var new_spell_element = spell_element.grid[# 0, 0].components;
		
		var new_spell = item_make_spell(new_spell_base, new_spell_element, new_spell_modifiers);
		if(storage_add_item(result, new_spell) != -1) {
			storage_clear(spell_base);
			storage_clear(spell_element);
			storage_clear(spell_modifiers);
		}
	}
);

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

var element_base_storage_y = height - max(storage_get_height(spell_element), storage_get_height(spell_base)) - storage_padding + push_down;
panel_add_element(panel_id, "element", MENUELEMENT.STORAGE, spell_element, 0, element_base_storage_y);
panel_add_element(panel_id, "base", MENUELEMENT.STORAGE, spell_base, width - storage_get_width(spell_base), element_base_storage_y);

panel_add_element(panel_id, "element_text", MENUELEMENT.TEXT, element_text, 0, height - text_padding + push_down);
panel_add_element(panel_id, "base_text", MENUELEMENT.TEXT, base_text, width, height - text_padding + push_down);

panel_add_element(panel_id, "modifiers", MENUELEMENT.STORAGE, spell_modifiers, width/2 - storage_get_width(spell_modifiers)/2, storage_padding + push_down);
panel_add_element(panel_id, "modifiers_text", MENUELEMENT.TEXT, modifiers_text, width/2, text_padding + push_down);

panel_add_element(panel_id, "craft", MENUELEMENT.TEXTBUTTON, craft, width/2 - text_button_get_width(craft)/2, element_base_storage_y + storage_get_height(spell_element)/2 - text_button_get_height(craft)/2);

interact_method = function open_spell_crafting(other_id) {
	if(other_id.object_index == oPlayer) {
		panel_set_activation(panel_id, true);
		oPlayer.open_inventory();
	}
}