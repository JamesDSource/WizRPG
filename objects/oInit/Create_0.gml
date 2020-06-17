// surfaces and drawing
surface_resize(application_surface, VIEWWIDTH, VIEWHEIGHT);
display_set_gui_size(VIEWWIDTH, VIEWHEIGHT);
application_surface_draw_enable(false);
instance_create_layer(0, 0, "Instances", oRender);
instance_create_layer(0, 0, "Instances", oMenus);

init_save_file(0);
alarm[0] = 2;