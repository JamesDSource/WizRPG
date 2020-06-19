event_inherited();

stopped = false;

draw_function = function draw_self_projectile_spell() {
	if(!stopped) {
		var element_particle = global.elements[element_using].particles;
		repeat(2) {
			var offsets = pixels[irandom_range(0, array_length(pixels)-1)];
			part_particles_create(particles, x + offsets[0], y + offsets[1], element_particle, 1);
		}
	}
}

destroy_counter = room_speed;