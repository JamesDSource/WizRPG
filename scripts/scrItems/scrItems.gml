enum ITEMTYPE {
	STAFF,
	SPELL,
	ELEMENTORB,
	BASE,
	CHARM,
	MISC
}

function item(i_name, i_type, i_sprite, i_icon, i_action, i_components) constructor {
	name = i_name;		// string of item name
	type = i_type;		// item type
	sprite = i_sprite;	// sprite that's shown when held
	icon = i_icon;		// sprite that's shown in inventory
	action = i_action;	// function that plays when item is held (or when in a charm slot)
	components = i_components;
}

global.item_memory = array_create(0);

function item_copy(item) {
	var new_item_components;
	switch(item.type) {
		case ITEMTYPE.SPELL:
			new_item_components = new spell_components(item.components.base, item.components.element_type);
			break;
		default:
			new_item_components = item.components
			break;
	}
	
	var copy = {
		name: item.name,	
		type: item.type,	
		sprite: item.sprite,	
		icon: item.icon,	
		action: item.action,
		components: new_item_components
	};
	
	global.item_memory[array_length(global.item_memory)] = copy;
	return copy;
}

function item_make_spell(spell_base, spell_element, modifiers) {
	var new_spell_name = global.elements[spell_element].name +  " " +spell_base.name;
	
	var new_spell = new item(
		new_spell_name,
		ITEMTYPE.SPELL,
		noone,
		sBase_bolt,
		noone,
		new spell_components(spell_base, spell_element)
	);
	
	return new_spell;
}

#region items
	function staff_wand_default_behavior(data) {
		static cooldown = 0;
		
		data.angle = point_direction(data.x_pos, data.y_pos - data.z_pos, mouse_x, mouse_y);
		
		if(instance_exists(oPlayer) && is_struct(oPlayer.equipt_spell) && cooldown <= 0) {
			var spell = oPlayer.equipt_spell;
			switch(spell.components.base.type) {
				case SPELLBASE.PROJECTILE:
					cooldown = spell_projectile_spawm(spell, data.x_pos, data.y_pos, data.z_pos, data.angle);
					break;
					
			}
			
		}
		else if(cooldown > 0) cooldown -= get_delta();
	}
	function init_items() {
		global.items = {
			#region staffs and wands
				stick_wand: new item(
					"Stick Wand",
					ITEMTYPE.STAFF,
					sStick_wand,
					sStick_wand_icon,
					function act_stick_wand(data) {
						staff_wand_default_behavior(data);
					},
					-1
				),
		
				forest_staff: new item(
					"Forest Staff",
					ITEMTYPE.STAFF,
					sForest_staff,
					sForest_staff_icon,
					function act_forest_staff(data) {
						staff_wand_default_behavior(data);
					},
					-1
				),
		
				mushroom_wand: new item(
					"Mushroom Wand",
					ITEMTYPE.STAFF,
					sMushroom_wand,
					sMushroom_wand_icon,
					function act_mushroom_wand(data) {
						staff_wand_default_behavior(data);	
					},
					-1
				), 
		
				lightning_staff: new item(
					"Lightning Staff",
					ITEMTYPE.STAFF,
					sLightning_staff,
					sLightning_staff_icon,
					function act_lightning_staff(data) {
						staff_wand_default_behavior(data);	
					},
					-1
				),
			#endregion
			#region elements
				element_fire: new item(
					"Fire Orb",
					ITEMTYPE.ELEMENTORB,
					noone,
					sFire_orb,
					noone,
					ELEMENTTYPE.FIRE
				),
			#endregion
		
			#region spell bases
				base_bolt: new item(
					"Bolt Spell Base",
					ITEMTYPE.BASE,
					noone,
					sBase_bolt,
					noone,
					global.spell_base.bolt
				),
			#endregion
		}
	};
#endregion