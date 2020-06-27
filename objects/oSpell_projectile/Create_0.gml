event_inherited();

stopped = false;

draw_function = function draw_self_projectile_spell() {
	if(!stopped) {
		
		var spell_color = global.elements[element_using].color;
		spell_color = [color_get_red(spell_color)/255, color_get_green(spell_color)/255, color_get_blue(spell_color)/255];
		
		shader_set(shProjectile_shape);
		
		var u_spell_color = shader_get_uniform(shProjectile_shape, "spell_color");
		shader_set_uniform_f_array(u_spell_color, spell_color)
		
		draw_sprite_ext(sprite_index, image_index, x, y-z, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		
		shader_reset();
		
		var element_particle = global.elements[element_using].particles;
		var particles_per_step = ceil(array_length(pixels)/100);
		repeat(particles_per_step) {
			var offset_angle = pixels[irandom_range(0, array_length(pixels)-1)];
			var offset_x = lengthdir_x(offset_angle[0], offset_angle[1] + image_angle);
			var offset_y = lengthdir_y(offset_angle[0], offset_angle[1] + image_angle);
			part_particles_create(particles, x + offset_x, y - z + offset_y, element_particle, 1);
		}
	}
}

collided_with = function collided_with_spell_projectile(other_collider) {
	other_collider.elemental_damage(damage, element_using);
	stopped = true;
}

destroy_counter = room_speed;
ds_list_add(dont_collide, oPlayer);