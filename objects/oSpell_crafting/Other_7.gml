if(sprite_index == sSpell_crafting_opening) sprite_index = sSpell_crafting_active;
else if(sprite_index == sSpell_crafting_closeing) {
	sprite_index = sSpell_crafting_opening;
	image_speed = 0;
	image_index = 0;
}