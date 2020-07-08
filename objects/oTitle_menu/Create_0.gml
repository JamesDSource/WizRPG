#region main
	global.menu_button_list = "main menu"

	panel_w = 100;
	panel_h = VIEWHEIGHT/2;
	main_button_list = new button_list(global.button_presets.title_menu, panel_w, panel_h);
	main_page(main_button_list);
	
	panel_add(global.menu_button_list, panel_w, panel_h, 0, 0);
	panel_set_position(global.menu_button_list, VIEWWIDTH/2 - panel_get_width(global.menu_button_list)/2, VIEWHEIGHT/3);
	panel_set_background(global.menu_button_list, sTitle_screen_menu_background)
	panel_set_run_on_pause(global.menu_button_list, true);
	panel_add_element(global.menu_button_list, "button list", MENUELEMENT.BUTTONLIST, main_button_list, 0, 0);
	panel_set_activation(global.menu_button_list, true);
#endregion