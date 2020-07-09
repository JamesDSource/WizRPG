#region main
	panel_id = "main menu"

	panel_w = 100;
	panel_h = VIEWHEIGHT/2;
	main_button_list = new button_list(global.button_presets.title_menu, panel_w, panel_h);
	main_page(main_button_list);
	
	panel_add(panel_id, panel_w, panel_h, 0, 0);
	panel_set_position(panel_id, VIEWWIDTH/2 - panel_get_width(panel_id)/2, VIEWHEIGHT/3);
	panel_set_background(panel_id, sTitle_screen_menu_background);
	panel_add_element(panel_id, "button list", MENUELEMENT.BUTTONLIST, main_button_list, 0, 0);
	panel_set_activation(panel_id, true);
#endregion