enum ITEMTYPE {
	STAFF,
	SPELL,
	CHARM,
	MISC
}

function item(i_name, i_type, i_sprite, i_icon, i_action) constructor {
	name = i_name;		// string of item name
	type = i_type;		// item type
	sprite = i_sprite;	// sprite that's shown when held
	icon = i_icon;		// sprite that's shown in inventory
	action = i_action;	// function that plays when item is held (or when in a charm slot)
}

function item_copy(item) {
	var copy = {
		name: item.name,	
		type: item.type,	
		sprite: item.sprite,	
		icon: item.icon,	
		action: item.action	
	};
	
	return copy;
}

#region items
	function staff_wand_default_behavior(data) {
		data.angle = point_direction(data.x_pos, data.y_pos - data.z_pos, mouse_x, mouse_y);
	}

	global.items = {
		// staffs
		stick_wand: new item(
			"Forest Staff",
			ITEMTYPE.STAFF,
			sStick_wand,
			sStick_wand_icon,
			function act_stick_wand(data) {
				staff_wand_default_behavior(data);
			}
		),
		
		forest_staff: new item(
			"Forest Staff",
			ITEMTYPE.STAFF,
			sForest_staff,
			sForest_staff_icon,
			function act_forest_staff(data) {
				staff_wand_default_behavior(data);
			}
		),
		
		mushroom_wand: new item(
			"Mushroom Wand",
			ITEMTYPE.STAFF,
			sMushroom_wand,
			sMushroom_wand_icon,
			function act_mushroom_wand(data) {
				staff_wand_default_behavior(data);	
			}
		), 
		
		lightning_staff: new item(
			"Lightning Staff",
			ITEMTYPE.STAFF,
			sLightning_staff,
			sLightning_staff_icon,
			function act_lightning_staff(data) {
				staff_wand_default_behavior(data);	
			}
		)
		
		
	};
#endregion