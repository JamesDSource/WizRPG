function spell_components(template, element) constructor {
	base = template;
	element_type = element;
}

function spell_projectile_spawm(spell, x_pos, y_pos, z_pos, angle, element_type) {
	with(instance_create_layer(x_pos, y_pos, "Instances", spell)) {
		z = z_pos;
		dir = angle;
		element_using = element_type;
		
		hsp = lengthdir_x(spd, dir);
		vsp = lengthdir_y(spd, dir);
	}
}