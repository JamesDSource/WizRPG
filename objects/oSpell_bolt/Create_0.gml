event_inherited();

pixels = oSprite_reader.read_sprite(sprite_index);

draw_function = function draw_self_spell_bolt() {
	var element_particle = global.elements[element_using].particles;
	repeat(2) {
		var offsets = pixels[irandom_range(0, array_length(pixels)-1)];
		part_particles_create(particles, x + offsets[0], y + offsets[1], element_particle, 1);
	}
}