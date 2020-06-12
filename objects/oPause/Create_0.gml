paused = false;
function toggle_pause() {
	paused = !paused;
	if(paused) {
		global.sPause = [
			sprite_create_from_surface(application_surface, 0, 0, VIEWWIDTH, VIEWHEIGHT, false, false, 0, 0),	
			sprite_create_from_surface(global.gui_surface, 0, 0, VIEWWIDTH, VIEWHEIGHT, false, false, 0, 0)	
		];
		instance_deactivate_object(oEntity);
		instance_deactivate_object(oCamera);
	}
	else {
		for(var i = 0; i < array_length(global.sPause); i++) sprite_delete(global.sPause[i]);
		global.sPause = noone;
		instance_activate_all();
	}
}