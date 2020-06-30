#region spell base types
	enum SPELLBASE {
		PROJECTILE,
		BEAM
	}
	
	function spell_base_projectile(spell_name, spell_shape, spell_damage, projectile_speed, projectile_life, spell_cooldown) constructor {
		name = spell_name;
		shape = spell_shape;
		damage = spell_damage;
		spd = projectile_speed;
		life = projectile_life * room_speed;
		cooldown = spell_cooldown * room_speed;
		
		type = SPELLBASE.PROJECTILE;
	}
#endregion

#region spell bases
	function init_bases() {
		global.spell_base = {
			bolt: new spell_base_projectile(
				"Bolt",
				sSpell_bolt,
				5,
				6,
				2,
				1
			),
		
			arc: new spell_base_projectile(
				"Arc",
				sSpell_arc,
				10,
				3,
				4,
				2.2
			),
		
			dart: new spell_base_projectile(
				"Dart",
				sSpell_dart,
				2,
				8,
				0.35,
				0.05
			)
		};
	}
#endregion

function spell_components(template, element) constructor {
	base = template;
	element_type = element;
}

function spell_projectile_spawm(spell, x_pos, y_pos, z_pos, angle) {
	if(mouse_check_button_pressed(mb_left)) {
		var inst = instance_create_layer(x_pos, y_pos, "Instances", oSpell_projectile)
		with(inst) {
			var spell_props = spell.components;
		
			name = spell.name;
			z = z_pos;
			element_using = spell_props.element_type;
			hsp = lengthdir_x(spell_props.base.spd, angle);
			vsp = lengthdir_y(spell_props.base.spd, angle);
			projectile_life = spell_props.base.life;
			pixels = oSprite_reader.read_sprite(spell_props.base.shape);
			damage = spell_props.base.damage;
			sprite_index = spell_props.base.shape;
			image_angle = angle;
		}
		
		return spell.components.base.cooldown;
	}
}

