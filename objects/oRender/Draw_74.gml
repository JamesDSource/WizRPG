shader_set(shPostprocessing);
if(sprite_exists(global.sPause)) draw_sprite(global.sPause, 0, 0, 0);
else draw_surface(application_surface, 0, 0);
shader_reset();