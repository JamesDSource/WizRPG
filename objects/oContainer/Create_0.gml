event_inherited();

opened = false;

image_speed = 0;
image_index = 0;
panel_id = string(id) + " " + room_get_name(room);

interact_method = function container_interacted_with(other_id) {
	if(other_id.object_index == oPlayer) image_speed = 1;
}

items = new storage(storage_width, storage_height, "All");
name_text = new text(name, fRune, c_white, fa_left, fa_top);

items_w = max(storage_get_width(items), text_get_width(name_text));
items_h = storage_get_height(items) + text_get_height(name_text);

panel_add(panel_id, items_w, items_h, 0, 0);
panel_add_element(panel_id, "items", MENUELEMENT.STORAGE, items, items_w/2 - storage_get_width(items)/2, text_get_height(name_text));
panel_add_element(panel_id, "name", MENUELEMENT.TEXT, name_text, items_w/2 - text_get_width(name_text)/2, 0);

items_draw_x = VIEWWIDTH - panel_get_width(panel_id) - 10;
items_draw_y = VIEWHEIGHT/2 - items_h/2;

panel_set_position(panel_id, items_draw_x, items_draw_y);