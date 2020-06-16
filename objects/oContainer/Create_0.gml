event_inherited();

opened = false;

interact_method = function container_interacted_with(other_id) {
	if(other_id.object_index == oPlayer) {
		with(oPlayer) open_inventory();	
		opened = true;
	}
}

items = new storage(w, h, "All");

items_surface = -1;
items_surface_w = storage_get_width(items);
items_surface_h = storage_get_height(items);
items_surface_draw_x = VIEWWIDTH - items_surface_w - 10;
items_surface_draw_y = VIEWHEIGHT/2 - items_surface_h/2;
