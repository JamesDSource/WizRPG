
function image(sprite_resource, sprite_subimage, animation_speed) constructor {
	sprite = sprite_resource;
	subimage = sprite_subimage;
	speed = animation_speed/room_speed;
}

function draw_image(image, x_pos, y_pos) {
	draw_sprite(image.sprite, image.subimage, x_pos, y_pos);
	image.subimage += image.speed * get_delta();
}