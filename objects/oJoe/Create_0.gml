event_inherited();

interact_method = function interacted(other_id) {
	show_debug_message("Ah, you've killed me");
	instance_destroy();
}

image_blend = c_yellow;