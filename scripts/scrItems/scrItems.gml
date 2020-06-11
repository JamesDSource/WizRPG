enum ITEMTYPE {
	STAFF,
	SPELLS,
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
	global.test_item = new item("Test Item", ITEMTYPE.MISC, -1, sTest_item_icon, -1);
#endregion