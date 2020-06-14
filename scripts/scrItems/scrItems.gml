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

#region items
	function staff_wand_default_behavior(data, x_pos, y_pos) {
		data.angle = point_direction(x_pos, y_pos, mouse_x, mouse_y);
	}

	global.items = {
		// staffs
		stick_wand: new item(
			"Forest Staff",
			ITEMTYPE.STAFF,
			sStick_wand,
			sStick_wand_icon,
			function act_stick_wand(data, x_pos, y_pos, height) {
				staff_wand_default_behavior(data, x_pos, y_pos);
			}
		),
		
		forest_staff: new item(
			"Forest Staff",
			ITEMTYPE.STAFF,
			sForest_staff,
			sForest_staff_icon,
			function act_forest_staff(data, x_pos, y_pos, height) {
				staff_wand_default_behavior(data, x_pos, y_pos);
			}
		)
		
		
	};
#endregion