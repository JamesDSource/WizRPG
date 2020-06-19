function draw_equipt() {
	if(is_struct(equipt_item.index)) {
		draw_sprite_ext(equipt_item.sprite, 0, equipt_item.x_pos, equipt_item.y_pos - equipt_item.z_pos, 1, 1, equipt_item.angle, c_white, equipt_item.alpha);
	}
}

var item_drawn = false;
if(side == sprite_side_index.back || side == sprite_side_index.left) {
	draw_equipt();
	item_drawn = true;
}

event_inherited();

if(!item_drawn) draw_equipt();
