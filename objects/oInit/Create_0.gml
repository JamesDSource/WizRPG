// surfaces and drawing
surface_resize(application_surface, VIEWWIDTH, VIEWHEIGHT);
display_set_gui_size(VIEWWIDTH, VIEWHEIGHT);
application_surface_draw_enable(false);
instance_create_layer(0, 0, "Instances", oRender);

room_goto_next();