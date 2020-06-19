draw_set_font(fDev_tools);

stats = [
	["FPS", fps],
	["Unlocked FPS", fps_real]
];


if(keyboard_check_pressed(vk_f5)) show_stats = !show_stats;