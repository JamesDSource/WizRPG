var scale_target;
if(vsp == 0) {
	scale_target = 0;
	if(scale == 0) instance_destroy();
}
else scale_target = 1;

scale = approach(scale, scale_target, 0.05);

draw_set_align(fa_center, fa_bottom);
var color = c_black;
if(damage_element != -1) color = global.elements[damage_element].color;
draw_set_font(fDamage_numbers);

draw_set_color(c_black);
draw_text_transformed(x-1, y+1, round(damage_taken), scale, scale, 0);
draw_set_color(color);
draw_text_transformed(x, y, round(damage_taken), scale, scale, 0);