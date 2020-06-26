function nine_slice(sprite, x1, y1, x2, y2) {
	// sprite
	var size = sprite_get_width(sprite) / 3;
	x1 -= size;
	y1 -= size;
	x2 += size;
	y2 += size;

	// dimensions
	var width = x2 - x1;
	var height = y2 - y1;

	#region corners
		//top left
		draw_sprite_part_ext(sprite, 0, 0, 0, size, size, x1, y1, 1, 1, c_white, draw_get_alpha());
	
		// top right
		draw_sprite_part_ext(sprite, 0, size*2, 0, size, size, x1 + width, y1, 1, 1, c_white, draw_get_alpha());
	
		// bottom left
		draw_sprite_part_ext(sprite, 0, 0, size*2, size, size, x1, y1 + height, 1, 1, c_white, draw_get_alpha());
	
		// bottom right
		draw_sprite_part_ext(sprite, 0, size*2, size*2, size, size, x1 + width, y1 + height, 1, 1, c_white, draw_get_alpha());
	#endregion
	#region edges
		// left
		draw_sprite_part_ext(sprite, 0, 0, size, size, size, x1, y1 + size, 1, (height-size)/size, c_white, draw_get_alpha());
		
		// right
		draw_sprite_part_ext(sprite, 0, size*2, size, size, size, x1 + width, y1 + size, 1, (height-size)/size, c_white, draw_get_alpha());		
			
		// top
		draw_sprite_part_ext(sprite, 0, size, 0, size, size, x1 + size, y1, (width-size)/size, 1, c_white, draw_get_alpha());
		
		// bottom 
		draw_sprite_part_ext(sprite, 0, size, size*2, size, size, x1 + size, y1 + height, (width-size)/size, 1, c_white, draw_get_alpha());
	#endregion
	#region middle
		draw_sprite_part_ext(sprite, 0, size, size, size, size, x1 + size, y1 + size, (width-size)/size, (height-size)/size, c_white, draw_get_alpha());
	#endregion
}