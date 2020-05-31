event_inherited();

function interact_method(other_id) {
	show_debug_message("Ah, you've killed me");
	instance_destroy();
}

image_blend = c_yellow;