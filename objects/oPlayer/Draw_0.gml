function draw_equipt() {
	if(is_struct(equipt_item.index)) {
		draw_sprite_ext(equipt_item.sprite, 0, x, y - equipt_item.z_pos, 1, 1, equipt_item.angle, c_white, equipt_item.alpha);
	}
}

var item_drawn = false;
if(side == sprite_side_index.back) {
	draw_equipt();
	item_drawn = true;
}

event_inherited();

if(!item_drawn) draw_equipt();
