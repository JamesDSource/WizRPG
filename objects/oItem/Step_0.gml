event_inherited();

if(disappear) {
	image_xscale = approach(image_xscale, 0, 0.1);
	image_yscale = approach(image_yscale, 0, 0.1);
		
	if(image_xscale == 0 && image_yscale == 0) instance_destroy();	
}