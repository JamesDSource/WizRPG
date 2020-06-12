if(!surface_exists(global.gui_surface)) global.gui_surface = surface_create(VIEWWIDTH, VIEWHEIGHT);

shader_set(shPostprocessing);
if(is_array(global.sPause)) {
	draw_sprite(global.sPause[0], 0, 0, 0);
	draw_sprite(global.sPause[1], 0, 0, 0);
	draw_text(VIEWWIDTH/2, VIEWHEIGHT/2, "Paused");
}
else{
	draw_surface(application_surface, 0, 0);
	draw_surface(global.gui_surface, 0, 0);
	
	surface_set_target(global.gui_surface);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
}
shader_reset();