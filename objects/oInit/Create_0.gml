#macro DEVMODE false
#macro DevBuild:DEVMODE true

// surfaces and drawing
surface_resize(application_surface, VIEWWIDTH, VIEWHEIGHT);
display_set_gui_size(VIEWWIDTH, VIEWHEIGHT);
application_surface_draw_enable(false);
shader_enable_corner_id(true);
instance_create_layer(0, 0, "Instances", oRender);
instance_create_layer(0, 0, "Instances", oMenus);
instance_create_layer(0, 0, "Instances", oSprite_reader);
if(DEVMODE) instance_create_layer(0, 0, "Instances", oDev_tools);

init_bases();
init_items();

init_save_file(0);
alarm[0] = 2;