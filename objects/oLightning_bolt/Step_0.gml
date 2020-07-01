event_inherited();

if(instance_exists(creator)) {
	x = creator.x;
	y = creator.y;
	z = creator.z;
}

if(target == noone) instance_destroy();

if(life > 0) life -= get_delta();
else instance_destroy();

if(!has_damaged && instance_exists(target)) {
	target.elemental_damage(lightning_damage, ELEMENTTYPE.LIGHTNING);
	has_damaged = true;
}