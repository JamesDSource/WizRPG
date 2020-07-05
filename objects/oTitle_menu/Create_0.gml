panel_w = 100;
panel_h = VIEWHEIGHT - PANELEDGE*2;
panel_id = "title menu";

#region main
	main_button_list = new button_list(global.button_presets.title_menu, 100, panel_h);
	button_list_add_button(main_button_list, "Play", "Play", -1);
	button_list_add_button(main_button_list, "Settings", "Settings", -1);
	button_list_add_button(main_button_list, "Quit", "Quit", -1);
	
	panel_add(panel_id, panel_w, panel_h, 0, 0);
	panel_set_position(panel_id, VIEWWIDTH/2 - panel_get_width(panel_id)/2, 0);
	panel_set_background(panel_id, sTitle_screen_menu_background)
	panel_add_element(panel_id, "button list", MENUELEMENT.BUTTONLIST, main_button_list, 0, 0);
	panel_set_activation(panel_id, true);
#endregion