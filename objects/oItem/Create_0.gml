event_inherited();

item_is = -1;
alarm[0] = 5;

disappear = false;

interact_method = function item_pickup(other_id) {
	if(is_struct(item_is) && other_id.object_index == oPlayer && storage_add_item(oPlayer.main, item_is) != -1) {
		disappear = true;
	}
}