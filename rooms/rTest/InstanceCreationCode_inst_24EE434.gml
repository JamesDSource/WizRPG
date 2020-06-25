storage_add_item(items, global.items.mushroom_wand);
storage_add_item(items, global.items.lightning_staff);
storage_add_item(items, global.items.fire_element);
storage_add_item(items, new item(
	"Lightining Spell",
	ITEMTYPE.SPELL,
	-1,
	sLightning_particle,
	-1,
	new spell_components(
		global.spell_base.arc,
		ELEMENTTYPE.LIGHTNING
	)
));

storage_add_item(items, new item(
	"Fire Spell",
	ITEMTYPE.SPELL,
	-1,
	sFlame_particle,
	-1,
	new spell_components(
		global.spell_base.arc,
		ELEMENTTYPE.FIRE
	)
));