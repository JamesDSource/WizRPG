visible = false;

// moving
hsp = 0;
vsp = 0;

// interactables
interact_method = noone;
interact_list = ds_list_create();
interact_radius = 20;
interact_entity = noone;

function interact() {
	if(interact_entity != noone) {
		interact_entity.interact_method(id);
	}
}