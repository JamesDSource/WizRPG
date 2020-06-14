// run state machine
state();

if(last_selected != interact_entity) {
	box_progress = 0;
	last_selected = interact_entity;	
}

toolbar_alpha = approach(toolbar_alpha, 0, 0.005);
spells_alpha = approach(spells_alpha, 0, 0.005);