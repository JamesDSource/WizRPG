surfaces_draw = array_create(0);

for(var i = 0; i < ds_list_size(panels_names); i++) {
	var panel_name = panels_names[| i];
	var current_panel = panels[? panel_name];
	if(current_panel.active) {
		if(!surface_exists(current_panel.surface)) current_panel.surface = surface_create(current_panel.width, current_panel.height);
		else {
			surface_set_target(current_panel.surface);	
			draw_set_alpha(0.9);
			nine_slice(sPanel_background, PANELEDGE, PANELEDGE, current_panel.width - PANELEDGE*2, current_panel.height - PANELEDGE*2);
			draw_set_alpha(1);
			
			for(var j = 0; j < ds_list_size(current_panel.elements_names); j++) {
					var current_element = current_panel.elements[? current_panel.elements_names[| j]];
					switch(current_element[0]) {
						case MENUELEMENT.STORAGE:
							draw_storage(current_element[1], current_element[2], current_element[3]);
							break;
						case MENUELEMENT.TEXT:
							var txt = current_element[1];
							draw_set_font(txt.font);
							draw_set_halign(txt.halign);
							draw_set_valign(txt.valign);
							draw_set_color(c_black);
							draw_text(current_element[2]-1, current_element[3]+1, txt.str);
							draw_set_color(txt.color);
							draw_text(current_element[2], current_element[3], txt.str);
							break;
					}
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