event_inherited();

if(instance_exists(creator)) {
	x = creator.x;
	y = creator.y;
	z = creator.z;
}

if(target != noone) {
	image_angle = point_direction(x, y, target.x, target.y);	
}
else instance_destroy();