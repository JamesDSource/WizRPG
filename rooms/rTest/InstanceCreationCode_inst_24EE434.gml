storage_add_item(items, global.items.mushroom_wand);
storage_add_item(items, global.items.lightning_staff);
storage_add_item(items, new item(
	"Test Fire Spell",
	ITEMTYPE.SPELL,
	-1,
	sFlame_particle,
	-1,
	new spell_components(global.spell_base.bolt, ELEMENTTYPE.FIRE)
	)
);