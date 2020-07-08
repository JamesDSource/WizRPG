function main_page(bl) {
	button_list_clear(bl);
	
	button_list_add_button(
		bl,
		"NG",
		"New Game",
		function new_game_button(list_index) {
			if(DEVMODE) transition_to(rDev_room);
			else transition_to(rInfirmary);
		}
	);
		
	button_list_add_button(
		bl, 
		"LG", 
		"Load Game", 
		-1
	);
	
	button_list_add_button(
		bl,
		"Settings",
		"Settings",
		-1
	);
	
	button_list_add_button(
		bl,
		"Quit",
		"Quit",
		function quit_button(list_index) {
			quit_page(list_index);	
		}
	);
}

function pause_page(bl) {
	button_list_clear(bl);
	
	button_list_add_button(
		bl,
		"Resume",
		"Resume",
		function resume_button(list_index) {
			oPause.toggle_pause();
		}
	);
	
	button_list_add_button(
		bl,
		"Settings",
		"Settings",
		-1
	);
	
	button_list_add_button(
		bl,
		"Main Menu",
		"Main Menu",
		function quit_button(list_index) {
		}
	);
}

function quit_page(bl) {
	button_list_clear(bl);
	
	button_list_add_button(
		bl,
		"Quit",
		"Quit",
		function end_game_button(list_index) {
			transition_quit();
		}
	);
		
	button_list_add_button(
		bl, 
		"Back", 
		"Back", 
		function back_button(list_index) {
			main_page(list_index);
		}
	);
}