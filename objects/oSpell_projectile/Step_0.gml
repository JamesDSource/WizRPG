event_inherited();

projectile_life -= get_delta();
if(projectile_life < 0) {
	stopped = true;
	hsp = 0;
	vsp = 0;
}

if(stopped) destroy_counter -= get_delta();
if(destroy_counter < 0) instance_destroy();