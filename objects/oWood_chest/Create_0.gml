event_inherited();

draw_function = function draw_self_wooden_chest() {
	drawing_self();
	if(show_cracks) draw_sprite_ext(sWood_chest_cracks, image_index, x, y-z, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	if(show_vines) draw_sprite_ext(sWood_chest_vines, image_index, x, y-z, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}