// run state machine
state();

if(last_selected != interact_entity) {
	box_progress = 0;
	last_selected = interact_entity;	
}

if(keyboard_check_pressed(vk_space)) esp = 3;