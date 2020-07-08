if(!surface_exists(global.gui_surface)) global.gui_surface = surface_create(VIEWWIDTH, VIEWHEIGHT);

shader_set(shPostprocessing);
if(is_array(global.sPause)) {
	draw_sprite(global.sPause[0], 0, 0, 0);
	draw_sprite(global.sPause[1], 0, 0, 0);
	
	if(!surface_exists(global.pause_overlay)) global.pause_overlay = surface_create(VIEWWIDTH, VIEWHEIGHT);
	draw_surface(global.pause_overlay, 0, 0);
	surface_set_target(global.pause_overlay);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
}
else{
	draw_surface(application_surface, 0, 0);
	draw_surface(global.gui_surface, 0, 0);
	
	surface_set_target(global.gui_surface);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
}

draw_set_alpha(global.transition_percent);
draw_rectangle_color(0, 0, VIEWWIDTH, VIEWHEIGHT, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

shader_reset();