show_stats = false;

stats = [
	["FPS", fps],
	["Unlocked FPS", fps_real]
];

y_margin = 10;
w = VIEWWIDTH/2;
h = y_margin;

draw_set_font(fDev_tools);
for(var i = 0; i < array_length(stats); i++) {
	var str = stats[i][0] + ": " + string(stats[i][1]);
	h += string_height(str);
}