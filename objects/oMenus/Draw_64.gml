surfaces_draw = array_create(0);

for(var i = 0; i < ds_list_size(panels_names); i++) {
	var panel_name = panels_names[| i];
	var current_panel = panels[? panel_name];
	if(current_panel.active) {
		if(!surface_exists(current_panel.surface)) current_panel.surface = surface_create(current_panel.width, current_panel.height);
		else {
			surface_set_target(current_panel.surface);	
			draw_rectangle_color(0, 0, current_panel.width, current_panel.height, c_black, c_black, c_black, c_black, false);
			
			for(var j = 0; j < ds_list_size(current_panel.elements_names); j++) {
					
			}
			surface_reset_target();
			
			surfaces_draw[array_length(surfaces_draw)] = [current_panel.surface, current_panel.x, current_panel.y];
		}
	}
}

surface_set_target(global.gui_surface);
for(var i = 0; i < array_length(surfaces_draw); i++) {
	var surf = surfaces_draw[i];
	draw_surface(surf[0], surf[1], surf[2]);
}
surface_reset_target();