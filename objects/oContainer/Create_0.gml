event_inherited();

opened = false;

image_speed = 0;
image_index = 0;

interact_method = function container_interacted_with(other_id) {
	if(other_id.object_index == oPlayer) image_speed = 1;
}

items = new storage(storage_width, storage_height, "All");
name_text = new text(name, fRune, c_white, fa_left, fa_top);

items_w = max(storage_get_width(items), text_get_width(name_text));
items_h = storage_get_height(items) + text_get_height(name_text);
items_draw_x = VIEWWIDTH - items_w - 10;
items_draw_y = VIEWHEIGHT/2 - items_h/2;

panel_add(string(id), items_w, items_h, items_draw_x, items_draw_y);
panel_add_element(string(id), "items", MENUELEMENT.STORAGE, items, items_w/2 - storage_get_width(items)/2, text_get_height(name_text));
panel_add_element(string(id), "name", MENUELEMENT.TEXT, name_text, items_w/2 - text_get_width(name_text)/2, 0);