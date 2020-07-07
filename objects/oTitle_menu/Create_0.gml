function main_page() {
	button_list_clear(main_button_list);
	
	button_list_add_button(
		main_button_list,
		"NG",
		"New Game",
		function new_game_button() {
			if(DEVMODE) room_goto(rDev_room);
			else room_goto(rInfirmary);
		}
	);
		
	button_list_add_button(
		main_button_list, 
		"LG", 
		"Load Game", 
		-1
	);
	
	button_list_add_button(
		main_button_list,
		"Settings",
		"Settings",
		-1
	);
	
	button_list_add_button(
		main_button_list,
		"Quit",
		"Quit",
		function quit_button() {
			quit_page();	
		}
	);
}

function quit_page() {
	button_list_clear(main_button_list);
	
	button_list_add_button(
		main_button_list,
		"Quit",
		"Quit",
		function end_game_button() {
			game_end();	
		}
	);
		
	button_list_add_button(
		main_button_list, 
		"Back", 
		"Back", 
		function back_button() {
			main_page();
		}
	);
}

#region main
	panel_w = 100;
	panel_h = VIEWHEIGHT/2;
	panel_id = "title menu";
	main_button_list = new button_list(global.button_presets.title_menu, panel_w, panel_h);
	main_page();
	
	panel_add(panel_id, panel_w, panel_h, 0, 0);
	panel_set_position(panel_id, VIEWWIDTH/2 - panel_get_width(panel_id)/2, VIEWHEIGHT/3);
	panel_set_background(panel_id, sTitle_screen_menu_background)
	panel_add_element(panel_id, "button list", MENUELEMENT.BUTTONLIST, main_button_list, 0, 0);
	panel_set_activation(panel_id, true);
#endregion