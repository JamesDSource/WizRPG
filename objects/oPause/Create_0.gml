paused = false;
function toggle_pause() {
	paused = !paused;
	if(paused) {
		global.sPause = sprite_create_from_surface(application_surface, 0, 0, VIEWWIDTH, VIEWHEIGHT, false, false, 0, 0);
		instance_deactivate_object(oEntity);
		instance_deactivate_object(oCamera);
	}
	else {
		sprite_delete(global.sPause);
		global.sPause = noone;
		instance_activate_all();
	}
}