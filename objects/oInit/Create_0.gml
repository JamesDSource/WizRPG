// surfaces and drawing
surface_resize(application_surface, VIEWWIDTH, VIEWHEIGHT);
display_set_gui_size(VIEWWIDTH, VIEWHEIGHT);
application_surface_draw_enable(false);
instance_create_layer(0, 0, "Instances", oRender);

init_save_file(0);

room_goto_next();