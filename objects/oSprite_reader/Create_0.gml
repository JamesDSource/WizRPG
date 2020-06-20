sprite_data_memory = ds_map_create();
surface = -1;


function read_sprite(sprite) {
	if(surface_exists(surface)) {
		var white_pixels = sprite_data_memory[? sprite_get_name(sprite)];
	
		if(is_undefined(white_pixels)) {
			sprite_data_memory[? sprite_get_name(sprite)] = array_create(0);
			white_pixels = sprite_data_memory[? sprite_get_name(sprite)];	
		
		
			var spr_w = sprite_get_width(sprite);
			var spr_h = sprite_get_height(sprite);
			var spr_xoffset = sprite_get_xoffset(sprite);
			var spr_yoffset = sprite_get_yoffset(sprite);
		
			surface_resize(surface, spr_w, spr_h);
		
			surface_set_target(surface);
			draw_clear_alpha(c_black, 0);
			draw_sprite(sprite, 0, spr_xoffset, spr_yoffset);
			surface_reset_target();
		
			for(var r = 0; r < spr_w; r++) {
				for(var c = 0; c < spr_h; c++) {
					var col = surface_getpixel_ext(surface, r, c);
					var alpha = (col >> 24) & 255
					var angle = point_direction(spr_xoffset, spr_yoffset, r, c);
					var dist = point_distance(spr_xoffset, spr_yoffset, r, c);
					if(alpha >= 255) white_pixels[array_length(white_pixels)] = [dist, angle];
				}
			}
		}
		
		return white_pixels;
	}
	else return undefined;
}