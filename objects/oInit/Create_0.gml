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
instance_create_layer(0, 0, "Instances", oElements);
instance_create_layer(0, 0, "Instances", oEntity_sort);
if(DEVMODE) instance_create_layer(0, 0, "Instances", oDev_tools);

global.paused = false;

init_bases();
init_modifiers();
init_items();

alarm[0] = 2;