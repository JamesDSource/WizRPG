panel_id = "pause menu";
panel_w = 100;
panel_h = VIEWHEIGHT/2;

panel_add(panel_id, panel_w, panel_h, 0, 0);
panel_set_position(panel_id, VIEWWIDTH/2 - panel_get_width(panel_id)/2, VIEWHEIGHT/3);
panel_set_background(panel_id, sTitle_screen_menu_background);
panel_set_run_on_pause(panel_id, true);

main_button_list = new button_list(global.button_presets.title_menu, panel_w, panel_h);
panel_add_element(panel_id, "button list", MENUELEMENT.BUTTONLIST, main_button_list, 0, 0);
pause_page(main_button_list);

function toggle_pause() {
	global.paused = !global.paused;
	if(global.paused) {
		global.sPause = [
			sprite_create_from_surface(application_surface, 0, 0, VIEWWIDTH, VIEWHEIGHT, false, false, 0, 0),	
			sprite_create_from_surface(global.gui_surface, 0, 0, VIEWWIDTH, VIEWHEIGHT, false, false, 0, 0)	
		];
		instance_deactivate_object(oEntity);
		instance_deactivate_object(oCamera);
		
		panel_set_activation(panel_id, true);
	}
	else {
		for(var i = 0; i < array_length(global.sPause); i++) sprite_delete(global.sPause[i]);
		global.sPause = noone;
		instance_activate_all();
		
		panel_set_activation(panel_id, false);
	}
}